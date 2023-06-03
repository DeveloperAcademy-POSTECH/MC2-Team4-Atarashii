const functions = require("firebase-functions");

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

function makeJWT() {
  const jwt = require("jsonwebtoken");
  const fs = require("fs");

  // Path to download key file from developer.apple.com/account/resources/authkeys/list
  let privateKey = fs.readFileSync("AuthKey_XXXXXXXXXX.p8");

  //Sign with your team ID and key ID information.
  let token = jwt.sign(
    {
      iss: "YOUR TEAM ID",
      iat: Math.floor(Date.now() / 1000),
      exp: Math.floor(Date.now() / 1000) + 120,
      aud: "https://appleid.apple.com",
      sub: "YOUR CLIENT ID",
    },
    privateKey,
    {
      algorithm: "ES256",
      header: {
        alg: "ES256",
        kid: "YOUR KEY ID",
      },
    }
  );

  return token;
}
