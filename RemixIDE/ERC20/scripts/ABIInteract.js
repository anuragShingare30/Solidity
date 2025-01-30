(async ()=>{

    let address = "0xd9145CCE52D386f254917e481eB44e9943F39138";
    let abiArray = [
	{
		"inputs": [],
		"name": "myInt",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "newInt",
				"type": "uint256"
			}
		],
		"name": "setInt",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	}
];

    let contract = new web3.eth.Contract(abiArray,address);
    console.log(await contract.methods.myInt().call());

    let account = await web3.eth.getAccounts();
	let result = await contract.methods.setInt(1000).send({from:account[0]});
	console.log(result);
	console.log(await contract.methods.myInt().call());
})();