const jwt = require('jsonwebtoken');
const jwksClient = require('jwks-rsa');

// Configure the JWKS client
const client = jwksClient({
    jwksUri: `https://cognito-idp.${process.env.AWS_REGION}.amazonaws.com/${process.env.USER_POOL_ID}/.well-known/jwks.json`
});

function getKey(header, callback) {
    client.getSigningKey(header.kid, (err, key) => {
        const signingKey = key.getPublicKey();
        callback(null, signingKey);
    });
}

exports.handler = async (event) => {
    console.log('Received event:', JSON.stringify(event, null, 2));

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

    const { token } = body;

    if (!token) {
        return {
            statusCode: 400,
            headers: {
                'Access-Control-Allow-Origin': '*',
                'Access-Control-Allow-Headers': '*',
                'Access-Control-Allow-Methods': '*'
            },
            body: JSON.stringify({
                message: "Token is required"
            })
        };
    }

    try {
        const decoded = await new Promise((resolve, reject) => {
            jwt.verify(token, getKey, { algorithms: ['RS256'] }, (err, decoded) => {
                if (err) {
                    reject(err);
                } else {
                    resolve(decoded);
                }
            });
        });

        return {
            statusCode: 200,
            headers: {
                'Access-Control-Allow-Origin': '*',
                'Access-Control-Allow-Headers': '*',
                'Access-Control-Allow-Methods': '*'
            },
            body: JSON.stringify(decoded)
        };
    } catch (error) {
        console.error('Error verifying token:', error);
        return {
            statusCode: 401,
            headers: {
                'Access-Control-Allow-Origin': '*',
                'Access-Control-Allow-Headers': '*',
                'Access-Control-Allow-Methods': '*'
            },
            body: JSON.stringify({
                message: "Invalid token",
                error: error.message
            })
        };
    }
};
