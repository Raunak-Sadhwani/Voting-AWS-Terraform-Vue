const aws = require('aws-sdk');
const ddc = new aws.DynamoDB.DocumentClient();
const tableName = process.env.TABLE_NAME;

exports.handler = async (event) => {
    console.log(event);

    const httpMethod = event.httpMethod;
    switch (httpMethod) {
        case 'POST':
            try {
                await _postData(JSON.parse(event.body));
                return _responseHelper(200, JSON.stringify({ message: "Data inserted successfully!" }));
            } catch (error) {
                return _responseHelper(404, error.message);
            }
        case 'GET':
            try {
                const response = await _getData();
                return _responseHelper(200, JSON.stringify(response));
            } catch (error) {
                return _responseHelper(404, error.message);
            }
        case 'DELETE':
            try {
                let id;
                if (tableName.startsWith("voter")){
                    id = event.queryStringParameters['voter_id'];
                } else {
                    id = event.queryStringParameters['company_id'];
                }
                await _deleteItem(id);
                return _responseHelper(200, "Item deleted successfully!");
            } catch (error) {
                return _responseHelper(404, error.message);
            }
        default:
            return _responseHelper(400, "Unsupported method");
    }
};

const _postData = async (oRequestData) => {
    const oParams = {
        TableName: tableName,
        Item: oRequestData
    };
    if (tableName.startsWith("voter")){
        const userx = oParams.Item.voted_for_id;
        const tabName= "companyTable";
        // get the user in companyTable
        // add one to the vote count of company users
        const getUserParams = {
            TableName: tabName,
            Key: {
                user_id: userx
            },
        };
        try {
            const userResult = await ddc.get(getUserParams).promise();
            if (userResult.Item) {
                // Increment the vote count
                const updatedVotes = userResult.Item.user_votes + 1;

                // Update the user vote count in the company table
                const updateUserParams = {
                    TableName: companyTable,
                    Key: {
                        'user_id': userx
                    },
                    UpdateExpression: 'set user_votes = :votes',
                    ExpressionAttributeValues: {
                        ':votes': updatedVotes
                    }
                };
                await ddc.update(updateUserParams).promise();
            } else {
                throw new Error("User not found");
            }
        } catch (error) {
            throw new Error(error.message);
        }
    }
    try {
        await ddc.put(oParams).promise();
    } catch (error) {
        throw new Error(error.message);
    }
};

const _getData = async () => {
    const oParams = {
        TableName: tableName,
    };

    try {
        const response = await ddc.scan(oParams).promise();
        return response.Items;
    } catch (error) {
        throw new Error(error.message);
    }
};

const _deleteItem = async (id) => {
    let name;
                if (tableName.startsWith("voter")){
                    name = "voter_id";
                } else {
                    name =  "company_id";
                }
    const oParams = {
        TableName: tableName,
        Key: {
            name: id
        }
    };

    try {
        await ddc.delete(oParams).promise();
    } catch (error) {
        throw new Error(error.message);
    }
};

const _responseHelper = (statusCode, payload) => {
    return {
        "statusCode": statusCode,
        "headers": {
            "Access-Control-Allow-Origin": "*"
        },
        "body": payload
    };
};

