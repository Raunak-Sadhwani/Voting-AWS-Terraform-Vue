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
    const oParams = {
        TableName: tableName,
        Item: oRequestData
    };
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

