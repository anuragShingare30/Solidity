(async () => {
  const accounts = await web3.eth.getAccounts();
  console.log(accounts.length);
})();