require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
require('dotenv').config();
//Exporting the API keys for deployment networks
const API_URL_MUMBAI = process.env.API_URL_MUMBAI;
const PRIVATE_KEY = process.env.PRIVATE_KEY;

module.exports = {
  solidity: "0.8.18",
  //Networks used for deployment
  defaultNetwork: "polygon_mumbai",
  networks: {
     hardhat: {},
     polygon_mumbai: {
        url: API_URL_MUMBAI,
        accounts: [`0x${PRIVATE_KEY}`],
        chainId: 80001,
     },
     localhost: {
        url: "http://127.0.0.1:8545",
        chainId: 31337
     }
    }
};
