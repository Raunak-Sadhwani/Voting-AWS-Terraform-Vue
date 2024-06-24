const AmazonCognitoIdentity = require('amazon-cognito-identity-js');

const poolData = {
  UserPoolId: process.env.USER_POOL_ID,
  ClientId: process.env.CLIENT_ID
};

const userPool = new AmazonCognitoIdentity.CognitoUserPool(poolData);

exports.handler = async (event) => {
  const { username, password } = JSON.parse(event.body);

  const authenticationDetails = new AmazonCognitoIdentity.AuthenticationDetails({
    Username: username,
    Password: password,
  });

  const userData = {
    Username: username,
    Pool: userPool,
  };

  const cognitoUser = new AmazonCognitoIdentity.CognitoUser(userData);

  return new Promise((resolve, reject) => {
    cognitoUser.authenticateUser(authenticationDetails, {
      onSuccess: function(result) {
        const accessToken = result.getAccessToken().getJwtToken();
        resolve({
          statusCode: 200,
          body: JSON.stringify({ token: accessToken }),
        });
      },
      onFailure: function(err) {
        reject({
          statusCode: 401,
          body: JSON.stringify({ message: err.message }),
        });
      },
    });
  });
};
