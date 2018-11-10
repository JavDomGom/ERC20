'use strict';

// Import libraries
const Web3 = require('web3'),
  abi = require('human-standard-token-abi'),
  fs = require('fs'),
  log = require('ololog').configure({
    time: true,
    handleNodeErrors: true,
  }),
  dotenv = require('dotenv').config();

const args = process.argv.slice(2);

// Set the web3 client and contract
// log.yellow('Connecting to Ethereum network and processing contract...');
const network = process.env.INFURA_API_ENDPOINT,
  web3 = new Web3(network),
  contract = new web3.eth.Contract(abi, process.env.TOKEN_ADDRESS);

// Configure our wallet
// log.yellow('Accessing wallet...');
const account = web3.eth.accounts.privateKeyToAccount('0x' + process.env.WALLET_PRIVATE_KEY);
web3.eth.accounts.wallet.add(account);
web3.eth.defaultAccount = account.address;

// log.yellow('Processing transactions ');
contract.methods.transfer(args[0].trim(), Math.round(parseFloat(args[1]) * 10e7))
  .send({ from: web3.eth.defaultAccount, gas: 210000 })
  .then(log.green)
  .catch(log.red)
