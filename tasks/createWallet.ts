import { task } from 'hardhat/config';

task('createWallet', 'Creates a new wallet and displays the private key')
  .addParam('total', 'Total of account will be created')
  .setAction(async (taskArgs, { ethers }) => {
    const len = taskArgs.total;
    console.log(`\x1b[34m Creating ${len} accounts \x1b[0m`);
    for (let index = 1; index <= len; index++) {
      const wallet = ethers.Wallet.createRandom();
      console.log(`${index}. Wallet`);
      console.log(`Public Address: ${wallet.address}`);
      console.log(`Private Key: ${wallet.privateKey}`);
      console.log('-------');
    }
    console.log(`\x1b[32m Created ${len} accounts successfully \x1b[0m`);
  });
