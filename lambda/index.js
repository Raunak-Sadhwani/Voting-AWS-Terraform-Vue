const aws = require('aws-sdk');
const ddc = new aws.DynamoDB.DocumentClient();
const tableName = process.env.TABLE_NAME;

exports.handler = async (event) => {
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
    if (tableName.startsWith("voter")) {
        const votedForId = oParams.Item.voted_for_id;
        const companyTableName = "CompanyTable";

        try {
            // Get the company from CompanyTable
            const compParams = {
                TableName: companyTableName,
                Key: {
                    'company_id': "1234567890"
                }
            };
            const response = await ddc.get(compParams).promise();
            const company = response.Item;

            // Get the user from the company
            const user = company.users.find(user => user.user_id === votedForId);
            if (user) {
                // Update the user votes
                user.user_votes = user.user_votes + 1;

                // Update the company in CompanyTable
                const compParams = {
                    TableName: companyTableName,
                    Item: company
                };
                await ddc.put(compParams).promise();
            } else {
                throw new Error("User not found in the company");
            }
            // Put the new voter item in voterTable
            // await ddc.put(oParams).promise();
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

                    const voterId = id;
                    const companyTableName = "CompanyTable";

                    try {
                        // get the voted_for_id
                        const oParams = {
                            TableName: tableName,
                            Key: {
                                'voter_id': voterId
                            }
                        };
                        const responsex = await ddc.get(oParams).promise();
                        const votedForId = responsex.Item.voted_for_id;


                        // Get the company from CompanyTable
                        const compParams = {
                            TableName: companyTableName,
                            Key: {
                                'company_id': "1234567890"
                            }
                        };
                        const response = await ddc.get(compParams).promise();
                        const company = response.Item;

                        // Get the user from the company
                        const user = company.users.find(user => user.user_id === votedForId);
                        if (user) {
                            // Update the user votes
                            user.user_votes = user.user_votes - 1;

                            // Update the company in CompanyTable
                            const compParams = {
                                TableName: companyTableName,
                                Item: company
                            };
                            await ddc.put(compParams).promise();
                        } else {
                            throw new Error("User not found in the company");
                        }
                        // Put the new voter item in voterTable
                        // await ddc.put(oParams).promise();
                    } catch (error) {
                        throw new Error(error.message);
                    }
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
        headers: {
            'Access-Control-Allow-Origin': '*',
        },
        "body": payload
    };
};

