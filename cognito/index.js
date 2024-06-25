const AWS = require('aws-sdk');
const cognito = new AWS.CognitoIdentityServiceProvider();

exports.handler = async (event) => {
    // console.log('Received event:', JSON.stringify(event, null, 2));
    let body;

    if (event.body) {
        body = JSON.parse(event.body);
    } else {
        return {
            statusCode: 400,
            headers: {
                'Access-Control-Allow-Origin': '*',
                'Access-Control-Allow-Headers': '*',
                'Access-Control-Allow-Methods': '*'
            },
            body: JSON.stringify({
                message: "Missing request body"
            })
        };
    }

    const { username, password } = body;

    if (!username || !password) {
        return {
            statusCode: 400,
            headers: {
                'Access-Control-Allow-Origin': '*',
                'Access-Control-Allow-Headers': '*',
                'Access-Control-Allow-Methods': '*'
            },
            body: JSON.stringify({
                message: "Username and password are required"
            })
        };
    }

    const params = {
        AuthFlow: 'ADMIN_NO_SRP_AUTH',
        UserPoolId: process.env.USER_POOL_ID,
        ClientId: process.env.CLIENT_ID,
        AuthParameters: {
            USERNAME: username,
            PASSWORD: password
        }
    };

    try {
        const response = await cognito.adminInitiateAuth(params).promise();
        return {
            statusCode: 200,
            headers: {
                'Access-Control-Allow-Origin': '*',
                'Access-Control-Allow-Headers': '*',
                'Access-Control-Allow-Methods': '*'
            },
            body: JSON.stringify(response)
        };
    } catch (error) {
        console.error('Error initiating auth:', error);
        return {
            statusCode: 500,
            headers: {
                'Access-Control-Allow-Origin': '*',
                'Access-Control-Allow-Headers': '*',
                'Access-Control-Allow-Methods': '*'
            },
            body: JSON.stringify({
                message: "Error initiating auth",
                error: error.message
            })
        };
    }
};
