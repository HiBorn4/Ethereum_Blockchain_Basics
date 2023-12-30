
import * as Web3 from 'web3';

(async () => {

    const web3 = new Web3("ws://localhost:8546");

    // console.log("abc");
    let accounts = await web3.eth.getAccounts();
    console.log(accounts, accounts.length);
    let balance = await web3.eth.getBalance(accounts[0]);
    console.log(balance);
    console.log(await web3.utils.frameWei(balance.toString(), "eth"));
})