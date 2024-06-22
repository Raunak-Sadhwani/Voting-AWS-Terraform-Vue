const aws = require('aws-sdk');
const ddc = new aws.DynamoDB.DocumentClient();
const tableName = 'CompanyTable';

exports.handler = async (event) => {
    console.log(event);

    const httpMethod = event.httpMethod;
    switch (httpMethod) {
        case 'POST':
            try {
                await _postData(JSON.parse(event.body));
                return _responseHelper(200, "Records inserted successfully!");
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
                const companyID = event.queryStringParameters['company_id'];
                await _deleteItem(companyID);
                return _responseHelper(200, "Item deleted successfully!");
            } catch (error) {
                return _responseHelper(404, error.message);
            }
        default:
            return _responseHelper(400, "Unsupported method");
    }
};

const _postData = async (oRequestData) => {
    let oData = [], count = 0;

    for (let idx = 0; idx < oRequestData.length; idx++) {
        const item = oRequestData[idx];
        count++;

        oData.push({
            PutRequest: {
                Item: {
                    ...item,
                    company_id: item.company_id,
                }
            }
        });

        // Batch write rejects requests with more than 25 request items
        if (count === 25 || (idx === (oRequestData.length - 1))) {
            try {
                await ddc.batchWrite({
                    RequestItems: {
                        [tableName]: oData // DynamoDB table name
                    }
                }).promise();
                oData = [];
                count = 0;
            } catch (error) {
                throw new Error(error.message);
            }
        }
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

const _deleteItem = async (companyID) => {
    const oParams = {
        TableName: tableName,
        Key: {
            'company_id': companyID
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