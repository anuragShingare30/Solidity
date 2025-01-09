# Solidity Programming Language AND Framework Guide 😎

### Software and Platform Used!!!


**`RPC Provider`**
1. Infura RPC provider
2. Alchemy RPC Provider

**`Contracts`**
1. Openzeppllein
2. Chainlink DevHub
    - Chainlink VRFv2.5
    - Chainlink automationv2.1
3. Alchemy contracts
4. Soulmate and brownie-smart-contracts

**`wallets and Frameworks`**
1. Metamask
2. Hardhat
3. Foundry-forge
4. Web3.js/ethers.js

**`File storage`**
1. IPFS (web/desktop app)
2. Pinata
3. svg to base64
4. Sepolia Opensea



### Best Practices of smart contract to be followed:


**`Natspec format`**
```solidity
/// @title A simulator for trees
/// @author Larry A. Gardner
/// @notice You can use this contract for only the most basic simulation
/// @dev All function calls are currently implemented without side effects
/// @return Returning variable of function
/// @param  A Parameters used in function
```

**`Layout of Contract:`**
```solidity
// version
// imports
// errors
// interfaces, libraries, contracts
// Type declarations
// State variables
// Events
// Modifiers
// Functions
```

**`Layout of Functions:`**
```solidity
// constructor
// receive function (if exists)
// fallback function (if exists)
// external
// public
// internal
// private
// internal & private view & pure functions
// external & public view & pure functions
```

## SOLIIDTY PROGRAMMING CODE SNIPPETS



### SIMPLE STRUCTURE FOR SOLIDITY SMART CONTRACT.

- Here we will see the simple layout and structure to write the solidity smart contracts.

```solidity
pragma solidity ^0.8.0;

contract MyFirstContract {
    // functions
    ...
    // variables
    ...
    // arrays
}

```

### VARIABLES IN SOLIDITY.

- Variables in sol is similar to javascript. Except address.

```solidity
uint8 , uint16, uint128, uint256;

string public str = "Hello world";

bool public correct = true/false;
```

### STRINGS AND BYTES.

- Strings are actually arbitrary long bytes in UTF-8 representation. Strings do not have a length property.

- When we are using 'string' as a parameter in our function define **memory** to allocate the memory to our string.

```solidity
string public myString = "Hello world";

function getMyString(string memory _myString) public {
    myString = _myString;
}
```

- Bytes have the length property.

```solidity
bytes public myBytes = "Hello";

// myBytes = 0x72375375bc758734784c834874
```

### BASIC FUNCTIONS TO WRITE SIMPLE S.C .

1. Here we will discuss the basic functions to write simple smart contracts.

```solidity
uint256 result;

function addition(uint256 a, uint256 b) public returns(uint256){
    return result=a+b;
}
```

2. When we are just returning an variable inside an function we will use 'view' keyword.

```solidity
function get() public view returns (uint256){
    return result;
}
```

### FUNCTION VISIBILITY.

1. **Public** : Can be used internally and externally.

- Our metamask wallet and other smart contracts can call this type of function.

```solidity
function addition() public {
    result+=10;
}
```

2. **Private** : Can be used within contract.

```solidity
uint256 result = 0;

function addition() private {
    result+=10;
}
```

3. **Internal** : Can be used within the contract and other inheriting contract.

- Our metamask cannot used the internal function.
- But, inheriting contracts can used this function.

```solidity

contract Children {

    uint256 public result = 0;
    function addition(uint256 num) internal {
        result+=num;
    }
}

contract Parent is Children {

    uint256 x;
    // Here we have use the function from child contract.
    // Inheriting.
    function checkSum(uint256 x) internal {
        add(x);
    }
}
```

4. **External** : Can only be accessed from external contracts or accounts.

- We cannot used this function internally inside an other function.
- Our metamask wallet can accessed this type of function.

```solidity
function add(uint256 num) external {
    result += num;
}
```

- The 'public' function uses more ethereum gas fees than 'external' function.

#### NOTE : The default behavior to error out if the maximum/minimum value is reached. But you can still enforce this behavior. With an 'unchecked' block. Let's see an example.

```solidity

uint256 num; // by default it is 0

// Error
function Test1() public {
    num--;
}

// 115758729374974893749972177129737
function Test2() public {
    unchecked{
        num--;
    }
}
```

### CONSTRUCTOR FUNCTION

- It is a special function that is called only once during contract deployment.
- It is automatically called during Smart Contract deployment. And it can never be called again after that.

```solidity
constructor(uint256 _myaddress) {
    owner = _myaddress;

    owner = msg.sender;
}
```

### PAYABLE MODIFIER

- The payable modifier tells solidity that the function is expecting eth to receive.

```solidity

string public myMessage;
function getMessage(string memory _myMessage) public payable {
    myMessage = _myMessage;
}

```

### msg OBJECT

- The msg-object contains information about the current message with the smart contract.
- It's a global variable that can be accessed in every function.

```solidity
string public myMessage = "Hello World";

function updateString(string memory myMessage) public payable {
    if(msg.value == 1 ether) {
        myMessage = myMessage;
    }
    else{
        payable(msg.sender).transfer(msg.value);
    }
}
```

- **msg.sender** is the address of the person who deployed the Smart Contract.
- **msg.value** is used to get the amount of ETH sent along with a transaction to a smart contract.

### RECEIVE FUNCTION

- **Low-Level interaction**
- This is the function that is executed on plain Ether transfers.
- The receive function is executed on a call to the contract with empty calldata.
- The receive function can only rely on 2300 gas being available.

```solidity
uint public value;
string public message;

receive() external payable {
    value = msg.value;
    message = "recieved";
}
```

### FALLBACK FUNCTION (Handling ether transaction)

- **Low-Level interaction**
- When Call-data field is filled, then we can call fallback function.
- If a payable fallback function is also used in place of a receive function, it can only rely on 2300 gas being available.
- The fallback function always receives data, but in order to also receive Ether it must be marked payable.
- If Ether is sent to the contract without any data or with data that doesn't match any existing function signatures, the fallback function is triggered

```solidity
uint public value;
string public message;

receive() external payable {
    value = msg.value;
    message = "recieved";
}

fallback() external payable {
    value = msg.value;
    message = "fallback";
}
```

- **receive()** is a function that gets priority over **fallback()** when a calldata is empty.
- But **fallback** gets precedence over **receive** when calldata does not fit a valid function signature.

#### SENDING ETHER TO SPECIFIC ADDRESS

- To send ETH on specific address we can use **transfer function**

```solidity
// 1.
address payable toAddress;
toAddress.transfer(amountToSend);

// 2.
payable(address.transfer(amount));
```

- To receive an ETH on specific address, the address variable should also be an **payable**

#### NOTE : The **address(this)** expression refers to the contract's own address within its code.

#### **address(this).balance** returns the balance of the smart contract.

### MAPPING TYPES (mapping(KeyType => ValueType))

- Mapping types use the syntax **mapping(KeyType => ValueType)**
- The **KeyType** can be any built-in value type, bytes, string, or any contract or enum type.
- **ValueType** can be any type, including mappings, arrays and structs.

- It is an key and value datatype that does not have lenght or storage property.

```solidity
mapping (address => uint) public Balance;

function sendMoney() public payable {
    Balance[msg.sender] += msg.value;
}

function withDrawMoney(address to, uint amount) public payable {
    Balance[msg.sender] -= msg.value;
    to.transfer(amount);
}
```

- Understand the mapping as **key:value** pair.
- In mapping the datatypes has its default value initially.
- **mappings** do not have a length or a concept of a key or value being set.

### STRUCTS

- Solidity provides a way to define new types in the form of structs.
- Solidity uses structs to define new datatypes and group several variables together.
- A struct is a way to generate a new DataType, by basically grouping several simple Data Types together.

```solidity

// Defining struct
struct PaymentReceipt {
    address from;
    uint amount;
}

// THIS IS ONE METHOD TO ACCESS MAPS.
mapping (address => PaymentReceipt) public Balance;

function getPaymentHistory() public payable {
    Balance[msg.sender].amount = msg.value;
}


// ANOTHER WAY TO USE STRUCT.

PaymentReceipt public payment;
payment.from = msg.sender;
payment.amount = msg.value;

```

### NESTING MAPS IN STRUCT.

- Now, we will nest an map in an struct, so that it will become more easy and powerful to use struct with mappings.

```solidity
struct Transaction {
    uint amount;
    uint timestamp;
}

struct Payment {
    uint totalBalance;
    uint totalDeposit;
    mapping(uint => Transaction) deposits;
}

mapping (address => Payment) public Balance;

function deposit() public payable {
    Balance[msg.sender].totalBalance += msg.value;

    Balance[msg.sender].deposits[Balance[msg.sender].totalDeposit].amount = msg.value;
    Balance[msg.sender].deposits[Balance[msg.sender].totalDeposit].timestamp = block.timestamp;
    Balance[msg.sender].totalDeposit++;
}

function checkBalance(address _address) public view returns (uint){
    return Balance[msg.sender].totalBalance;
}
```

- By using **struct** inside an **mappings**, will be easier to handle the transaction.

### ARRAYS IN SOLIDITY.

- Just like an array in JS, arrays is solidity work exactly same.

```solidity
contract SampleArray {

    uint[] public dynamicArray;
    string[] public StringArray;

    function setValue(uint value) public {
        dynamicArray.push(value);
    }

    function getValue(uint index) public view returns (uint){
        return dynamicArray[index];
    }

    function deleteElement() public {
        dynamicArray.pop();
    }

    function sizeOfArray() public view  returns (uint){
        return dynamicArray.length;
    }
}
```

- An array can be of any data type (uint, string, struct, enum).

### ARRAY AND STRUCT (ARRAY AND JS OBJECT).

- An array can be of any data type (including **struct**) stored at specific index.

```solidity

struct StudentReport{
    string name;
    uint mark1;
    string HomeAdd;
}

StudentReport[] public ReportArray;

function fillReport(string _name, uint _mark1, string homeAddress) public {
    StudentReport memory ReportCard = StudentReport({
        name : _name,
        mark1 : _mark1,
        HomeAdd : homeAddress
    });

    ReportArray.push(ReportCard);
}

function getReportCard() public view returns(StudentReport[] memory){
    return (ReportArray)
}

```

### EXCEPTION HANDLING IN SOLIDITY.

1. **require() Statements**

- **require(condition,"Error Occurred!!!")**
- It read as if condition is false it will throw an error exception with log statement.
- And, if it is true it will execute the remaining code.

```solidity

mapping (address => uint) public Balance;

function deposit() public payable {
    Balance[msg.sender] += msg.value;
}

function withDrawMoney(address payable to, uint amount) public payable {

    require(amount <= Balance[msg.sender], "Not enough funds!!!");
    Balance[msg.sender] -= amount;
    to.transfer(amount);
}

```

- **require()** statement works exactly opposit to if-else statements.

2. **assert() statements** (DON'T KNOW WHEN TO USE???)

- Assert is used to check invariants
- Those are states our contract or variables should never reach, ever.

```solidity

mapping (address => uint8) public Balance;

function deposit() public payable {
    assert(msg.value == uint8(msg.value));
    Balance[msg.sender] += uint8(msg.value);
    assert(Balance[msg.sender] >= uint8(msg.value));
}

function withDrawMoney(address payable to, uint8 amount) public payable {

    require(amount <= Balance[msg.sender], "Not enough funds!!!");
    assert(Balance[msg.sender] >= Balance[msg.sender] - amount);
    Balance[msg.sender] -= amount;
    to.transfer(amount);
}

```

3. **try/catch statements**

```solidity

contract ExampleTryCatch {

    // THIS FUNCTION WILL ALWAYS FAIL TO EXECUTE.
    function tryCatch() public pure {
        require(false,"Error Occurred!!!");
    }
}

contract ErrorHandling {
    event ErrorLogging(string reason);
    event ErrorLoggingCode(uint errorcode);

    function handlingError() public {
        ExampleTryCatch test = new  ExampleTryCatch();

        try test.tryCatch(){
            // do something
        }
        catch Error(string memory reason){
            emit ErrorLogging(reason);
        }
        // Panic is for assert (optional)
        catch Panic(uint errorcode){
            emit ErrorLoggingCode(errorcode);
        }
    }
}

```

### enum type in solidity

- **enum** can have multiple values

```solidity
contract Enum {
    enum Status{open, closed};

    Status public s_status = Status.open;

    function updateStatus() public {
        s_status = Status.closed;
    }
}
```

### LOW-LEVEL SOLIDITY CALLS (INTERACTING WITH TWO SMART CONTRACT).

- Low-Level solidity call refers to **recieve the funds from other smart contracts.**

```solidity
contract ContractOne {

    mapping (address => uint) public Balance;

    function deposit() public payable {
        Balance[msg.sender] += msg.value;
    }

    function checkBalance() public view returns (uint){
        return address(this).balance;
    }

    // 2. REQUIRES FALL-BACK FUNCTION TO RECIEVE THE FUNDS FROM DIFFERENT SMART CONTRACTS.
    receive() external payable {
        deposit();
    }
}


contract ContractTwo {
    receive() external payable { }

    function DepositInContractOne(address to, uint amount) public {

        // 1.
        ContractOne one = ContractOne(to);
        one.deposit{value:amount, gas:100000}();

        // 2. REQUIRES FALL-BACK FUNCTION.
        (bool send,) = to.call{value:amount, gas:100000}("");
        require(send);
    }
}

```

- Here, we have two methods to recieve funds from low-level calls.

1. WITHOUT FALL-BACK FUNCTION

```solidity
ContractOne one = ContractOne(to);
one.deposit{value:amount, gas:100000}();
```

2. WITH FALL-BACK FUNCTION

```solidity
(bool send,) = to.call{value:amount, gas:100000}("");
require(send);
```

### EVENTS

- This provide logging facility of Ethereum.
- Events are a way to access this logging facility

```solidity
// SAMPLE SMART CONTRACT TO UNDERSTAND THE EVENTS.
contract Events {
    mapping(address => uint) public Balance;

    events(address _from, address _to, uint _amount);

    constructor(){
        Balance[msg.sender] = 100;
    }

    function sendTokens(address _to, uint _amount) public payable{
        require(Balance[msg.sender] >= _amount, "No Enough MOney");
        Balance[msg.sender] -= _amount;
        Balance[_to] += _amount;

        emit(msg.sender, _to, _amount);
    }
}

// THE LOGS WILL BE DISPLAYED ON THE 'logs' FIELD IN OUTPUT.
```

### MODIEFIERS, INHERITANCE AND IMPORTS IN SOLIDITY.

- Let's see a simple smart contract and how we can use the modifiers, inheritance and imports in our smart contracts.

```solidity
// InheritedContract.sol
contract InheritedContract{

    mapping (address => uint) public Account;
    address owner;

    constructor(){
        owner = msg.sender;
        Account[owner] = 100;
    }

    modifier isOwner(){
        require(msg.sender == owner, "You are not allowed");
        // placeholder input
        _;
    }
}


// InheritedContract.sol

import "InheritedContract.sol";
contract InheritedContract is InheritedContract {

    event History(address _from, address _to, uint _amnt);

    function createNewToken() public isOwner{
        Account[owner]++;
    }

    function burnToken() public isOwner{
        Account[owner]--;
    }

    function sendToken(address _to,uint _amount) public payable {
        require(Account[msg.sender] >= _amount);
        Account[msg.sender] -= _amount;
        Account[_to] += _amount;

        emit History(msg.sender, _to, _amount);

    }
}

```

#### MODIFIERS

- Right now we have several similar require statements.
- To avoid code duplication and make it easier to change this from a single place, we can use modifiers

```solidity
modifiers onlyOwner(){
    require(msg.sender == owner, "You are not allowed");
    _;
}

function sendTokens() public onlyOwner{
    // some code...
}
```

#### INHERITANCE

- By inheritance we can make two or more smart contracts.
- And, we can use the function of second inherited smart contract.

```solidity
contract Owned {
    address owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not allowed");
        _;
    }
}


contract Sample is Owned{
    // sample code...
}

```

#### IMPORTS

- Now, we export smart contract from one file to another using importing.

```solidity
// Ownerable.sol

contract Owned {
    address owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not allowed");
        _;
    }
}

// SAMPLE SMART CONTRACT
import "./Owned.sol";

contract SampleSmartContract is Owned {
    // some code...
}

```

- We can inherit the smart contract from one file to another file.

### CONTRACT TO CONTRACT INTERACTION (INTERFACE)

- Sometimes we are required different smart contract to handle some conditions necessary to our DApps.
- Just like in (ReactJs -> Componenets) we have smart contract to handle conditions.

```solidity
// Test1.sol
contract ContractA {
    uint data;

    function setData(uint _data) public {
        data = _data;
    }
    function getData() public view returns(uint){
        return data;
    }
}

// Test2.sol
interface IContractA {
    function setData(uint _data) external;
    function getData() external view returns (uint);
}

contract ContractB {
    IContractA public contractA;
    // sc address wil be of the interfaced contract address
    constructor(address _smartcontractAddress) {
        contractA = IContractA(_smartcontractAddress);
    }

    function setDataInContractA(uint _data) external  {
        contractA.setData(_data);
    }
}

```

### WITHDRAW MONEY FROM SMART CONTRACT

- After minting an nft's the price will be stored in smart contract and not in owners balance.
- To withdraw money,

```solidity
function withDrawMoney(address _address) external payable {
    uint balance = address(this).balance;
    payable(_address).transfer(balance);
}
```

- **address(this)** will return the current smart contract address.

















### INTRODUCTION TO WEB3.JS

- **Web3.js** is a JavaScript-library that lets us interact with a blockchain node via its RPC interface or Websockets.
- Here, there are **JavaScript functions** to interact with a blockchain node.

#### WEB3 PROVIDERS (WEBSOCKETS PROVIDERS).

- Web3.js is not sending the requests directly, it abstracts it away into these providers (EIP-6963, EIP-1193).
- Here, we can have example of metamask which automatically connects with website.
- Similarly, for **Web3 Providers** lastly it is connecting to the blockchain node.

#### ABI(Application Binary Interface) ARRAY.

- It is used to interact with smart contracts.
- **ABI ARRAY** provides web3js, what functions are present in smart contract.
- The **ABI Array** contains all functions, inputs, as well as all variables and their types from a smart contract

```solidity
// THIS IS THE SIMPLE EXAMPLE OF ABI ARRAY.
let abiArray = [
	{
		"inputs": [],
        // name : variables, functions,
		"name": "setData",
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
]
```

#### INTERACTION WITH SMART CONTRACT (web3.eth)

- We can use **Web3** libraries to interact with our smart contract.
- **web3.eth** provide us different methods/functions to interact with smart contract

```solidity
// TO GET THE ACCOUNTS
(async () => {
  const accounts = await web3.eth.getAccounts();
  console.log(accounts);
  console.log(accounts.lenght);
})()
```

- To interact with smart contract we have,

```solidity

// SAMPLE SMART CONTRACT
contract setData {
    uint public data = 100;

    function setData(uint _data) public {
        data = _data;
    }
    function getData() public view returns(uint){
        return (data);
    }
}


// JS CODE TO INTERACT WITH SMART CONTRACT
(async ()=>{

    // TO GET ALL ACCOUNTS
    let accounts = await web3.eth.getAccounts();

    let SmartContractAddress = "";
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
];

    let contract = new web3.eth.Contract(abiArray,contractAddress);

    // TO UPDATE ANY STATE VARIABLE
    async function setData(newData){
        await contract.methods.setData(newData).send({from : accounts[0]});
    }

    // TO DISPLAY/READ DATA
    let result = await contract.methods.getData().call();
    console.log(result);

})();

```

- From above code we can interact with smart contracts.

1. **new web3.eth.Contract() -> await myContract.methods.myMethod().call()** To call an variable

2. **new web3.eth.Contract() -> await myContract.methods.myMethod({from:account[0]}).send()** To update variable or function with params.




### Fungible and Non-fungible(NFT) token



1. **Fungible tokens(cryptocurrencies)** : These tokens are identical and can be exchanged for one another with equal value. Think of fungible tokens like currency

- interchangeable, identical in value (e.g., money).
**Fungible = `Link,Dollar`**



2. **Non-fungible tokens(NFTs)** : These tokens are unique and cannot be exchanged on a one-to-one basis for something of equal value because each one has its distinct attributes.

- NFTs are often used to represent digital art, collectibles, or unique assets
- like a serial number or unique content
- unique, distinct in value (e.g., a rare collectible).

**Non-fungible = `A pokemon card with diff. stats`**


### TOPICS COVERED IN ERC - 721, 1155, 721A (Ethereum Request for Comment)

1. public mint function
2. mint multiple nfts
3. add uri function
4. view nfts on opensea
5. withdraw function
6. allowlist minting function
7. minting window to enable and disable
8. MAX LIMIT PER WALLET
9. Refund functionality and Refund time period
10. Testing smart contract on Testnet



### Ethereum Improvement Proposal (EIP) 

-  a formal suggestion for changes or updates to the Ethereum network.
- According to `EIP` the token functionality is improved or added.
- Tokens follows EIP pattern.



### TOKENS(ERC-20,721,1155,1155A)

- **Token** is a representation of something in the digital or physical world that resides on the Ethereum blockchain
- Managed by a smart contract, which is a program on Ethereum, a token can represent just about anything.
- **It can be fungible(cryptocurrency) and non-fungible(NFT)**




#### ERC-20(Fungible) TOKEN

- **`ERC20` is a smart contract that follows the ERC20 standard created by `EIP`**.
- And, `keeps track of balances using storage variables in the contract.`
- ERC-20 tokens are simple smart contract.
- **`Ex:Chainlink`**

- ERC20 is a standard for **fungible** tokens, which are all identical and interchangeable.
- For tokens where every unit is the same (like currency).
- ERC20 is exactly the same as any other ERC20, just like how one dollar is the same as another dollar.

**EXAMPLE**
```solidity
// ERC-20 TOKEN SAMPLE CONTRACT FROM OZ
contract Web3 is ERC20, Ownable {
    constructor()
        ERC20("Web3", "ERC20")
        Ownable(msg.sender)
    {
        _mint(msg.sender, 10000 * 10 ** decimals()); // 10000 ether
    }

}
```



#### ERC-721(Non-Fungible) TOKEN

- **For ERC721 you have one address that has many tokens and all unique. The SC also works same**.

- ERC721 is a standard for non-fungible tokens, meaning each token is unique and cannot be exchanged one-for-one with another.
- Each NFT has its own value based on its uniqueness.
- For unique, one-of-a-kind items (like art or collectibles).


**`EXAMPLE`**:
- Think of an NFT for a unique piece of digital artwork. If you have a token representing **DigitalArt#1**, it's unique and can't just be swapped for **DigitalArt#2**




#### ERC-1155(Fungible and Non-Fungible) TOKEN

- **ERC1155** is a flexible standard that allows both **fungible and non-fungible** tokens within the **same smart contrac**t.
- This means you can create tokens that are all the same, all unique, or even some of each!
- A mix, allowing both identical and unique items in one contract

**EXAMPLE**

- Imagine a game where you have coins(fungible) and weapons(non-fungible).
- With ERC1155, you can have GameCoins(all identical) and unique items like rare swords or shields, all in one place.

#### COMMON FUNCTION IN ABOVE TOKENS

1. **PUBLIC MINT FUNCTION**

```solidity
function publicMint() public payable {
    require(true | false, "Minting is closed!!!");
    require(msg.value == 0.1 ether, "Not enough funds!!!");
    require(totalSupply() < 5, "We sold out!!!");
    uint256 tokenId = _nextTokenId++;
    _safeMint(msg.sender, tokenId);
}
```

2. **ALLOWLIST MINTING**

```solidity
function allowListMint() public payable {
    require(allowListAddress[msg.sender], "You are not in allow list!!!");
    require(true | false, "Minting is closed!!!");
    require(msg.value == 0.01 ether, "Not enough funds!!!");
    require(totalSupply() < 5, "We sold out!!!");
    uint256 tokenId = _nextTokenId++;
    _safeMint(msg.sender, tokenId);
}
```

3. **WITHDRAW FUNCTION**

```solidity
function withDrawMoney(address _address) external payable {
    uint balance = address(this).balance;
    payable(_address).transfer(balance);
}
```

4. **SET ALLOWLIST ADDRESS**

```solidity
mapping(address => bool) public allowListAddress;
function setAllowList(address[] memory addresses) external  onlyOwner{
    for(uint i=0;i<addresses.length;i++){
        allowListAddress[addresses[i]] = true;
    }
}
```

5. **PUBLIC MINTING (ERC-1155)**

- THE **amount** REFERS TO TOTAL NO. OF NFTs TO BE MINTED.

```solidity
uint constant public maxPurchasePerWallet = 3;

function publicMint(uint256 id, uint256 amount) public payable {
    require(true | false, "Minting is closed!!!");
    require(purchasePerWallet[msg.sender] + amount <= maxPurchasePerWallet, "MAX LIMIT PER WALLET REACHED");
    // by this require we can mint multiple nfts
    require(msg.value == (amount * 2 ether), "NOT ENOUGH MONEY SENT!!!");
    require(totalSupply(id) + amount <= maxSupply, "SORRY! WE MINTED OUT.");
    require(id < 5, "YOU ARE TRYING TO MINT WRONG NFTs");
    _mint(msg.sender, id, amount, "");
}
```

- **AllowListMint** function is same just add mapping of allowlist addresses.

6. **ADD URI FUNCTION (ERC1155)**

- This will return us the link for our **NFT Metadata through IPFS**
- We have added the IPFS Link this function will append NFT id and .json extension

```solidity
function uri(uint256 _id) public view virtual override returns (string memory){
    require(exists(_id), "URI : NOT EXIST");
    return
        string(
            abi.encodePacked(super.uri(_id), Strings.toString(_id), ".json")
        );
}
```

7. **PAYMENT SPLITTER (ERC-1155)**

- IT SPLITS BETWEEN THE ADDRESS(\_payees) FOR SHARES(\_shares).
- WE WILL ADD **address_array and shares_array** DURING DEPLOYMENT.

```solidity
constructor(address[] memory _payees, uint[] memory _shares)
    ERC1155("ipfs://Qmaa6TuP2s9pSKczHF4rwWhTKUdygrrDs8RmYYqCjP3Hye/")
    Ownable(msg.sender)
    PaymentSplitter(_payees,_shares)
    {

    }
```

- This can be integrated in our DApps.

8. **PUBLIC MINT (ERC-721A)**

```solidity
function publicMint(uint256 amount) public payable  {
    require(msg.value == (publicPrice * amount),"NOT ENOUGH MONEY!!!");
    // returns the number of tokens minted by 'owner'
    require(_numberMinted(msg.sender) + amount < maxMintPerUser, "SORRY LIMIT REACHED FOR MINTING NFTs!!!");
    // returns the total amount of tokens minted in the contract
    require(_totalMinted() <= maxNFTMinting, "WE SOLD OUT!!!");
    _safeMint(msg.sender, amount);

    refundEndTimeStamp = block.timestamp + refundPeriod;
    for(uint i = _currentIndex - amount; i<_currentIndex; i++){
        refundEndTimeStamps[i] = refundEndTimeStamp;
    }
}
```

9. **REFUND FUNCTIONALITY**

```solidity
// refund functionality
function refund(uint tokenId) external payable {
    // check token expiry time stamp
    require(getTokenTimeStamp(tokenId) > block.timestamp, "REFUND PERIOD EXPIRED!!!");
    // you should be the owner of tokenid
    require(msg.sender == ownerOf(tokenId), "YOU ARE NOT THE OWNER OF THIS TOKEN");

    // mark the refund
    hasRefunded[tokenId] = true;

    // Transfer Ownership of nft
    _transfer(msg.sender, refundAddress, tokenId);

    // refund the price
    uint refundAmount = getRefundAmount(tokenId);
    payable(msg.sender).transfer(refundAmount);
}


// GET REFUND AMOUNT
function getRefundAmount(uint tokenId) public view returns (uint){
    if(hasRefunded[tokenId]){
        return 0;
    }
    return publicPrice;
}
```



### LIQUIDITY POOL (moneyjar -> smart contract)

- A liquidity pool on the Ethereum blockchain is like a big **money jar** filled with two types of tokens (ETH AND ERC-20).
- Here, people can trade directly with this jar, making it much faster and easier.
- Anyone who wants to trade ETH for DAI (or DAI for ETH) can use this jar.

#### Process followed when Pool is created and its Trading

1. **Creating Pool(Uniswap)** : A **liquidity pool** is created by someone who puts both **ETH and ERC** into a digital jar **(smart contract)** on platform like Uniswap.
2. **Trading** : Now, anyone who wants to trade ETH for DAI (or DAI for ETH) can use this smart contract(jar)
3. **Swapping** : When someone swaps ETH for DAI, the pool takes in ETH and gives out DAI.
4. **Pricing** : The prices adjust automatically based on how much ETH and DAI are in the jar.



### NFT STAKING SMART CONTRACT (ERC-20 AND ERC-721)

**In, NFT staking sc we will use both ERC20 and ERC721 token**

- An NFT staking sc is a type of program on the blockchain that allows **NFT holders(ERC721)** to **stake(or lock up)** their NFTs **in the contract for a certain period of time.**
- In exchange, they earn rewards, usually in the **form of tokens(ERC20)** or other benefits.
- It's a way for NFT owners to gain extra value from their NFTs without selling them.

#### FLOW OF NFT STAKING SC

- To understand the process flow we will consider some basic tokens and contract :

**Staking SmartContract(App)** : A contract with functions for staking, unstaking, and getting rewards (main function).
**ERC-721(NFT)** : The NFT that users lock up for a set period when staking.
**ERC-20(token)** : The reward token users earn when they unstake their NFTs.

1. **STAKING** : NFT holders connect their wallets to the staking platform and select an NFT they want to stake.
2. **Lock Period** : The NFT is locked and temporarily transferred to the smart contract for a specific time
3. **Rewards** : For keeping their NFT staked, users earn rewards like tokens, points.
   depending on the terms of the smart contract and company for which we are building
4. **Unstaking** : When the lock period ends, users can withdraw their NFT and collect any rewards they earned.




### L1, L2 AND ROLL-UPS IN ETHEREUM BLOCKCHAIN

1. **Layer1 (Main Blockchain Layer)** -> **(Bitcoin, Ethereum, and Solana)**

- the foundational blockchain layer, the core network where transactions are processed directly.
- They each have their own rules, consensus mechanisms, and security.

- **Problem** Layer 1 blockchains can get slow and expensive when there's high demand of tsx

2. **LAYER2 (Secondary Layer on Top of Layer1)** -> **(Polygon, Arbitrum, and Optimism)**

- Layer2 solutions are built on top of Layer1 blockchains.
- handle transactions faster and more cheaply.
- They offload some transactions from the main chain and then submit them in batches to Layer 1.

- **BENEFITS** : Layer 2 can offer faster processing and lower fees,

3. **Rollups (Special Type of Layer 2 Solution)** -> **Arbitrum, zkSync**

- Rollups bundle many transactions together, process them on Layer 2, and then send a single, compact summary back to Layer 1 for finalization.
- This reduces the number of transactions Layer 1 has to handle directly.

- **BENEFITS** : Rollups improve scalability even more than regular Layer2s by minimizing amount of data sent to the main chain.





### ORACLE PROBLEMS / SMART CONTRACT CONNECTIVITY PROBLEM

- The **Oracle problems** refers to the connectivity issue of smart contract with the off-chain data(such as market-data, api_calls, api-data) with on-chain data.

- **Blockchain Oracles** is any device that interacts with the off-chain world to provide external data or computation on on-chain.
- **Blockchain oracle** is a secure piece of middleware that facilitates communication between blockchains and any off-chain system, including data providers, web APIs, enterprise backends, cloud providers, IoT devices, e-signatures, payment systems.
- We will not use **centralized computation or centralized oracle/node** for our extrenal data.

- **Chainlink is a decentralized Oracle Network**
- When a smart contract combines on-chain and off-chain data, can be defined as **hybrid smart contract**

**Now, how this blockchain oracles work**:

- With the help of **decentralized oracle network**
- On off-chain, chainlink nodes will store external data from data-providers.
- On on-chain, the chainlink node will transfer the data to **Reference contract** so that other contract can used this data.

- Here, we will use the **chainlink functions** to get the external data for our smart contract
- And, this chainlink function will be the future of DeFi apps.

1. **CHAINLINK FUNCTIONS**
2. **CHAINLINK VRF**
3. **CHAINLINK AUTOMATION**
4. **END-TO-END RELIABILITY(TAKE INPUT, RETURN OUTPUT)**





#### CHAINLINK VRF

- Chainlink VRF (Verifiable Random Function) is a provably fair and verifiable random number generator (RNG)
- that enables smart contracts to access random values without compromising security or usability.
- Use Chainlink VRF to build reliable smart contracts for any applications that rely on unpredictable outcomes



**Two methods to request randomness**

1. `Subscription Method`(Programmaticaly || Manually)

   - Create Subscription
   - Get Subscription ID
   - Fund the Subscription
   - Add contract address as consumer
   - Use the random number

2. `Direct funding`
   - Add consumer
   - allow contract to pay TNX fee to request random number






#### CHAINLINK VRF (SUBSCRIPTION METHOD)

- To get the a random word, we will follow the following structure :
  - requestRandomWords
  - fulfillRandomWords
  - Getting the random word

1. **Import the libiraries**

   ```solidity
    import {VRFConsumerBaseV2Plus} from "@chainlink/contracts/src/v0.8/vrf/dev/VRFConsumerBaseV2Plus.sol";
    import {VRFV2PlusClient} from "@chainlink/contracts/src/v0.8/vrf/dev/libraries/VRFV2PlusClient.sol";

    contract MyContract is VRFConsumerBaseV2Plus{}
   ```

2. **Contract Variables**

   ```solidity
    uint256 s_subscriptionId;
    address vrfCoordinator;
    bytes32 s_keyHash;
    uint32 callbackGasLimit;
    uint16 requestConfirmations;
    uint32 numWords =  1;
   ```

3. **Initializing the contract**

   ```solidity
   constructor(
       uint256 subscriptionId,
       address vrfCoordinator,
   ) VRFConsumerBaseV2Plus(vrfCoordinator) {
       s_subscriptionId = subscriptionId;
   }
   ```

4. **`requestRandomWords function`**

   ```solidity
   function requestRandomWords() public view returns(uint256 requestId){

        // This will call the oracles network for requestId.
       VRFV2PlusClient.RandomWordsRequest memory request =  VRFV2PlusClient.RandomWordsRequest({
               keyHash: i_keyHash,
               subId: s_subscriptionId,
               requestConfirmations: requestConfirmations,
               callbackGasLimit: callbackGasLimit,
               numWords: numWords,
               extraArgs: VRFV2PlusClient._argsToBytes(
                   VRFV2PlusClient.ExtraArgsV1({nativePayment: false})
               )
       });
       requestId = s_vrfCoordinator.requestRandomWords(request);
       console.log(requestId);
   }
   ```


5. **`fulfillRandomWords function`**

    ```solidity
    // The coordinator sends the result of our generated randomWords back to fulfillRandomWords
    function fulfillRandomWords(uint256 requestId, uint256[] calldata randomWords) public {

        uint randomNum = (randomWords[0]%arrayLength);

        <!-- Now, implement the functionality you want to use!!! -->
    }
    ```




### CHAINLINK AUTOMATION

- To automate some functions in our smart contract,
    - `checkUpkeep()` checks if enough time has passed to call main logic
    - `performUpkeep()` main logic which has to be automated!!!!
  


1. **Import the libraries**
    
    ```solidity
    import {AutomationCompatibleInterface} from "@chainlink/contracts/src/v0.8/automation/AutomationCompatible.sol";
    ```


2. **Initializing state variables**

    ```solidity
    constructor(uint256 _interval) {
        interval = _interval;
        lastTimeStamp = block.timestamp;
        counter = 0;
    }
    ```


4. **`checkUpkeep() and performUpkeep()`**

    ```solidity
    contract Counter is AutomationCompatibleInterface{

    // constructor

    // this function will check if we need to call our logic to call again
    function checkUpkeep(
        bytes calldata /* checkData */
    )
        external
        view
        override
        returns (bool upkeepNeeded, bytes memory /* performData */)
    {
        upkeepNeeded = (block.timestamp - lastTimeStamp) > interval;
    }


    // Our main logic of function
    function performUpkeep(bytes calldata /* performData */) external override {

        (bool upkeepNeeded,) = checkUpkeep("");
        if(!upkeepNeeded){
            revert();
        }

        // some condition n logic to increase counter
        counter = counter + 1;
    }


    }
    ```





### MATH CONVERSIONS IN SOLIDITY

- Converting the value of ETH to USD
- As prog. language it does not **support floating point number**

```js
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
function getPrice() internal view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (int256 answer) = priceFeed.latestRoundData();
        return uint256(answer * 10000000000);
}
function getConversionRate(uint256 ethAmount) public view returns (uint256) {
    // getPrice() function will return current eth price in usd.
    uint256 ethPrice = getPrice();
    uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
    return ethAmountInUsd;
}
```

**NOTE** : In solidity, multiply before dividing to get better precision.

### CREATING OUR OWN libraries(optional)

- When a functionality can be commonly used, we can create a **library** to efficiently manage repeated parts of codes.
- Use keyword **library** instead of **contract**.

```js
// PriceConverter.sol

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    function getPrice() internal view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (int256 answer) = priceFeed.latestRoundData();
        return uint256(answer * 10000000000);
    }

    function getConversionRate(uint256 ethAmount) internal view returns (uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1000000000000000000;
        return ethAmountInUsd;
    }
}
```

- Now, to use the library in our solidity file, we have:
- Here, **msg.value** is first-parameter and value in parenthesis is second-parameter.

```js
import {PriceConverter} from "./PriceConverter.sol";
using PriceConverter for uint256;

require(msg.value.getConversionRate(123) >= minimumUsd, "didn't send enough ETH");
```

### GAS OPTIMIZATION TECHNIQUE

- Using keyword like **constant** and **immutable** can optimize the gas cost.

**NOTE : constant and immutable keyword are used for gas optimization in smart contract**

### MODULO OPERATOR

- Modulo operator returns the remainder when a number is divided by a specific modulo.

```solidity
// modulo of 10
function mod10(uint num) public pure  returns (uint){
        return (num%10);


}

// modulo of 2
function mod2(uint num) public pure  returns (uint){
        return (num%2);
}
```

### SENDING ETH FROM SMART CONTRACT TO SPECIFIC ADRRESS

- Send the balance of smart contract to specific address

```solidity
function sendETH() public payable{
    address userAddress = "0x001";
    // sending ETH from smart contract to user
    (bool success,)= userAddress.call{value: address(this).balance}("");
    if(!success){
        revert();
    }
}
```

### TECHNIQUE TO CONVERT THE ETH INTO WEI

```solidity
1 Ether = 1e18 wei;
1 Ether = 1e9 wei;

uint256 public constant SEND_VALUE = 1e18;
uint256 public constant SEND_VALUE = 1_000_000_000_000_000_000;
uint256 public constant SEND_VALUE = 1000000000000000000;
```

### TRUFFLE ️‍🔥

#### INSTALLING TRUFFLE

- npm install -g truffle (globally)
- mkdir project_name
- truffle init
- npm init -y
- echo "node_modules" > .gitignore
- npm i --save @openzeppelin/contracts

#### INSTALLING GANACHE

- This initialize the ganache rpc server

```js
npm i --global ganache
ganache
```

- **add a network called "ganache" to the truffle-config.js file**

```js
// ganache-cli opens an RPC listener on Port 8545
module.exports = {
  networks: {
    ganache: {
      host: "127.0.0.1", // Localhost (default: none)
      port: 8545, // Standard Ethereum port (default: none)
      network_id: "*", // Any network (default: none)
    },
  },
};
```

#### MIGRATION FILE

- In truffle, we will use migration to deploy our sc.

```js
// migrations/01-web3-deployment.js
const Web3 = artifacts.require("Web3");

module.exports = function (deployer, network, accounts) {
  deployer.deploy(Web3, { from: accounts[0] });
};
```

- **artifacts.require** function will scan the contents of the build/contracts folder from json and extract all relevant function from json.

#### TRUFFLE CONSOLE (GANACHE-CLI)

- Truffle has an integrated and interactive JavaScript console using ganache.

```js
// deploy our sc on ganache
truffle migrate --network ganache
// inititalize console
truffle console --network ganache
```

- Now, inside the console we can interact with our smart contract.
- **Run "migrate" to redeploy our sc inside console**

#### INTERACT WITH SC IN TRUFFLE CONSOLE

```js
// Create a new contract instance:
let token = await Web3.deployed();

// Truffle will scan the complete build artifacts directory and inject all contracts with their ABI and addresses directly in the console.
token.name();

// This way you can also mint an NFT
let accounts = await web3.eth.getAccounts();
await token.publicMint(accounts[0], 0.1 ether);
```

- Here **contract instance** will make a call (which you can see in Ganache) and return the output stored in the contract.
  **Note : Truffle will scan the complete build artifacts directory and inject all contracts with their ABI and addresses directly in the console**

#### UNIT TESTING IN TRUFFLE (JS)

```js
// TO TEST OUR SC
truffle console --network ganache
migrate
test
```

- Truffle can do tests in JavaScript and solidity

```js
// test/Web3.test.js
const Web3 = artifacts.require("Web3");

contract("Web3", (accounts) => {
  // first test check
  it("compare the two addresses for transaction", async () => {
    let token = await Web3.deployed();
    assert.equal(accounts[0], accounts[1], "Alert!!! Transaction fraud");
  });

  // second test check
  it("Testing sample smart contract", async () => {
    let token = await Web3.deployed();
    let tokenName = await token.name();
    console.log(tokenName);
  });
});
```

- **Here each it(...) function represents new test, which expects a function as second params and msg as first params**

- Here, contract function gets all accounts which are injected by Truffle by doing a web3.eth.getAccounts() before starting the test.
- truffle uses Mocha, here instead of 'describe' we will use 'contract'.
- Truffle will automatically redeploy the contracts based on the migrations files to offer so called **"clean room testing"**

#### UNIT TESTING IN TRUFFLE (Solidity)

- You can't choose the account you're sending the TX from in Solidity.
- You can't modify anything on the chain.
- You can't listen to events.

#### Deploy Smart Contracts to a real Network (HD WALLET PROVIDER/INFURA/ALCHEMY)

- This is the most standard way to deploy sc which is also followed by hardhat and foundary also.
- Here, We start with Infura to deploy the Smart Contract

- We sign up with a service(**Infura**) that hosts these blockchain nodes and get access.
- The first thing we need to do is instruct Truffle to sign a transaction before sending it (using HDWALLET-PROVIDER)

```js
npm install @truffle/hdwallet-provider
touch .secret
echo ".secret" >> .gitignore
touch .infura
echo ".infura" >> .gitignore
```

- **.secret** : Add the secretPhrase from our metamask.
- **.infura** : Add the infura_project_id from infura dashboard
- **.etherscan** : To verify our sc on etherscan

- Here, we will not use '.env' because it is not good practice in terms of security.
- We will use 'fileSystem' to store our key.
- Use the **HDWalletProvider** in your network configuration.

```js
//  tailwind-config.js
const HDWalletProvider = require("@truffle/hdwallet-provider");
const fs = require("fs");
const mnemonicPhrase = fs.readFileSync(".secret").toString().trim();
const infuraProjectID = fs.readFileSync(".infura").toString().trim();
const ETHERSCAN_ID = fs.readFileSync(".etherscan_id").toString().trim();

module.exports = {
  // ...
  networks: {
    sepolia: {
      provider: () =>
        new HDWalletProvider(
          mnemonicPhrase,
          `https://sepolia.infura.io/v3/${infuraId}`
        ),
      network_id: 11155111, // Sepolia's id
      confirmations: 2, // # of confirmations to wait between deployments. (default: 0)
      timeoutBlocks: 200, // # of blocks before a deployment times out  (minimum/default: 50)
      skipDryRun: true, // Skip dry run before migrations? (default: false for public nets)
    },
  },
};
```

- **Deploy our sc on sepolia using migrate**

```js
// inside truffle-console
truffle migrate --network sepolia
truffle console --network sepolia
```

#### Deploy Smart Contracts to a real network (Truffle Dashboard and METAMASK)

- We will use MetaMask to do the actual interaction with a blockchain. It's in there for a while, but not used very widely.

- Start with,

```js
// This will open an RPC tunnel to a website where MetaMask can connect to
truffle dashboard
truffle migrate --network dashboard
```

- **in this method we are not required to define the network in tailwind-config.js file**

#### Verification of SC on Etherscan

- login to your etherscan account and copy the API key.
- Save API key in .env or in fileSystem.

```js
npm install -D truffle-plugin-verify

//   tailwind-config.js
module.exports = {
  /* ... rest of truffle-config */
  plugins: ['truffle-plugin-verify'],
  api_keys:{
    etherScanId:process.env.ETHERSCAN_ID,
  },
}
```

- Simply, run the following command in terminal

```js
// FOR INFURA
truffle run verify Spacebear --network sepolia

// FOR DASHBOARD AND METAMASK
truffle run verify Spacebear --network dashboard
```

#### Solidity Optimizer¶

- Reduces the gas needed for contract deployment as well as for external calls made to the contract.

```js
module.exports = {
    //...
    compilers: {
    solc: {
      version: "0.8.16",      // Fetch exact version from solc-bin (default: truffle's version)
      // docker: true,        // Use "0.5.1" you've installed locally with docker (default: false)
      settings: {          // See the solidity docs for advice about optimization and evmVersion
       optimizer: {
        enabled: false,
        runs: 200
      },
      //  evmVersion: "byzantium"
      // }
    }
  },
}
```

#### FINAL tailwind-config.js

- Most of the time the **tailwind-config.js** will look like:

```js
// tailwind-config.js
const HDWalletProvider = require("@truffle/hdwallet-provider");
const fs = require("fs");
const mnemonicPhrase = fs.readFileSync(".secret").toString().trim();
const infuraProjectID = fs.readFileSync(".infura").toString().trim();

module.exports = {
  plugins: ["truffle-plugin-verify"],
  api_keys: {
    etherscan: fs.readFileSync(".etherscan").toString().trim(),
  },

  networks: {
    // GANACHE
    ganache: {
      host: "127.0.0.1",
      port: 8545,
      network_id: "*",
    },
    // SEPOLIA
    sepolia: {
      provider: () =>
        new HDWalletProvider(
          mnemonicPhrase,
          `https://sepolia.infura.io/v3/${infuraId}`
        ),
      network_id: 11155111, // Sepolia's id
      confirmations: 2, // # of confirmations to wait between deployments. (default: 0)
      timeoutBlocks: 200, // # of blocks before a deployment times out  (minimum/default: 50)
      skipDryRun: true, // Skip dry run before migrations? (default: false for public nets)
    },
  },

  // Set default mocha options here, use special reporters, etc.
  mocha: {
    // timeout: 100000
  },

  // Configure your compilers
  compilers: {
    solc: {
      version: "0.8.16", // Fetch exact version from solc-bin (default: truffle's version)
      // docker: true,        // Use "0.5.1" you've installed locally with docker (default: false)
      settings: {
        // See the solidity docs for advice about optimization and evmVersion
        optimizer: {
          enabled: false,
          runs: 200,
        },
        //  evmVersion: "byzantium"
      },
    },
  },
};
```

#### Debugging During Smart Contract Development (console.log)

```js
npm install @ganache/console.log

// import
import "@ganache/console.log/console.sol";
```

- Start using the 'console.log' in your smart contract for debugging.

```js
ganache
truffle console --network ganache
migrate
```

- Try to mint an NFTs and you will see your console.log on the **ganache server**

#### Debugging already deployed Smart Contracts with Forking (Truffle Debugger)

- There it is, your contract, on Mainnet. But suddenly users are reporting a bug. Something isn't right.
- because your users funds are at stake, after all...

- Now,
- **Ganache can fork the mainchain**
- **Truffle can debug smart contracts without even having the source code locally**

```js
// Pick any recent transaction from Etherscan and check it is verified smart contract.
ganache --fork.network sepolia

// Then you can use truffle to connect to Ganache, which will happily serve the requests.
truffle debug <TXHASH> --network ganache --fetch-external
```

- You can get the **TXHASH** from **Web3.json** file in networks object.

<!-- for ganache mainchain forking -->

- can fork mainchain/ testnet
- ganache downloads the code
- ganache offers debug-trace transaction rpc call (normal blockchain node do not offers this)

- Hit return a few times to see the actual execution of the code.
- Hit h for help and v for the current variables








### Blockchain File Storage🔥



#### WORKING OF IPFS(InterPlanetary File Storage) and CID(Content Identifier).

- IPFS is a decentralized P2P distributed file storing protocol.
- Storing data on blockchain is way expensive. So, the company store their data on **`centralized server and cloud providers`**
- In IPFS, files and other data are stored in a network of nodes.
- `When a file is added to IPFS, it is split into smaller blocks, coverted to hash using hash algorithm (SHA-256).`
- This `hash` is called as **`CID(Content Identifier)`**
- Everytime re-uploading file a new CID is generated.
- To retrieve data, a user requests it using the hash.
- IPFS locates the nodes storing the corresponding blocks and downloads them.



#### Location-Addressing vs Content-Addressing

1. Traditional web uses location-based addressing, where content is accessed by its location on a server (URL).

2. IPFS uses content-based addressing, where content is accessed by a hash of its content. This ensures that as long as the content remains the same, its address does not change.



#### PINNING SERVICE TO PINNED A NODE.

- If file is not in used in node using garbage collection process, file will be deleted.
- To prevent from garbage collection process we will use pinning service.

#### TYPES OF WEB3 STORAGE.

1. **`On-chain storage`**: 
   - refers to the practice of storing data directly on the blockchain, leveraging its inherent security features but at the cost of speed and expense.
   - **`Base64 encoding`** is best example

2. **`off-chain decentralized storage`** 
   - involves storing data across a network of decentralized nodes or servers.
   - **`IPFS,arweave,filecoin`**

3. **`Off-chain private storage solutions`** 
   - encompass traditional **`cloud-based and legacy data storage`** options designed for secure and controlled access.
   - **`AWS,azure,GCS`**



#### NFT METADATA (TokenURI and ImageURI)

- **NFT metadata** -> TokenURI
- **Hosted NFT image** -> ImageURI

- NFT metadata is the sum of all data that describes an NFT, typically including its name, traits, trait rarity, link to the hosted image, total supply, transaction history, and other essential data.

- **NFT MetaData** contains all description for our NFT including image, image_uri, description, attributes.

```json
// NFT-MetaData-Template

{
  "name": "Cryptodunks #101",
  "description": "",
  "image": "ipfs://QmXtHPbZoUNkUwGcZTcqD8TLRtozdxpjReMroioMPEvkSC/0.png",
  "attributes": [
    {
      "trait_type": "language",
      "value": "JavaScript"
    },
    {
      "trait_type": "OS",
      "value": "Windows"
    },
    {
      "trait_type": "Token",
      "value": "ERC-721"
    }
  ]
}
```

- We can see our minted and deployed NFT on `opensea (Testnet)` through Etherscan and also on our `Metamask portfolio.`




### Off-chain and On-chain storage


**Off-chain URI Representation**
ipfs://CID/?filename=NFT.json
https://ipfs.io/ipfs/CID/?filename=NFT.json


**on-chain URI Representation**
data:application/json;base64,hash



1. **`off-chain decentralized storage`** :
   - `IPFS, FileCoin and Arweave` are some off-chain storage solutions.
   - They do the heavy lifting with respect to *decentralized NFT data storage* by leveraging a ‘community’ of nodes around the world!!!
    
   - **NFTMetadata -> Host on IPFS -> Hash/CID -> TokenURI**
   - We can access the tokenUri in browser by:
       - https://ipfs.io/ipfs/hash/?filename=NFT.json
       - ipfs://hash/?filename=NFT.json


2. **`On-chain storage`**: 
    - We can store the files on-chain and it will be more secure but **`storage and expensive`**
    - The steps to store files on-chain is:
        - Encode it in `Base64` format
        - Concatenate  `baseUri + encodedFile`



3. **`BaseURI and Base64 conversion`**:
   - Convert directly in terminal
     **base64 -i image.svg > image.txt**

   - Use the online converter and store it in txt file

   -  Use **`Base64.sol && abi.encodePacked(args)`** this will encode our raw file to Base64
  

- Use above any method to encode **raw file to base64 format**

- Our toktenURI and ImageURI will look like this after storing them on-chain!!!
**data:image/svg+xml;base64,vhsdhvyfYFUYFYUFdcg4758....73248YUDTRTRXGHCyucxjc==**



**BaseURI**
```bash
# This is the format of base uri.
data:<media-type>;base64,

<media-types> : application/json , image/svg+xml , text/plain , video/mp4

data:application/json;base64,
data:image/svg+xml;base64,
```



### HARDHAT️‍🔥

- **artifacts** folder in our root directory contains our smart contract abi array.
- Hardhat comes built-in with Hardhat Network, a local Ethereum network designed for development.
- It allows you to deploy your contracts, run your tests and debug your code, all within the confines of your local machine

#### INSTALLING HARDHAT AND INITIALLIZING PROJECT

```js
npm init
npm install --save-dev hardhat
npx hardhat init
npm i --save @openzeppelin/contracts
npm install --save-dev @nomicfoundation/hardhat-toolbox
```

#### Compiling contracts

- Start by creating a new directory called **contracts** and create a file inside the directory called **Web3.sol**

```js
npx hardhat compile
```

#### Testing contracts

**Note : Hardhat will run every \*.js file in `test/`**

- Start the testing using following command :

```js
npx hardhat test
```

- We will use **Ether.js and Mocha-Chai** for our testing.
- **Mocha-Chai is popular JavaScript assertion library**

```js
// installing ether.js and mocha
npm install ethers
npm install --save-dev mocha
```

- Create a new directory called **test** inside our project root directory and create a new file in there called **web3test.js**
- To test our contract, we are going to use Hardhat Network, a local Ethereum network designed for development.

```js
//  test/web3test.cjs
const { expect } = require("chai");
const { ethers } = require("hardhat");
const assert = require("assert");

describe("Token contract", function () {
  // first test check
  it("Deployment should assign the total supply of tokens to the owner", async function () {
    // RETURNS THE ETHEREUM ACCOUNT.
    // And, this account will execute the deployment
    const [owner, addr1, addr2] = await ethers.getSigners();

    // start the deployment of our token contract
    // return a Promise that resolves to a Contract
    // This is the contract intance that has a method for each of your smart contract functions.
    const token = await ethers.deployContract("Web3");

    // Once contract is deployed, we can call contract methods using contract instance(token).
    // the account in the owner variable executed the deployment,
    const ownerBalance = await token.balanceOf(owner.address);

    // Here, the token's supply amount and we're checking that it's equal to ownerBalance, as it should be.
    // We have used expect(...) function from Mocha-chai to compare
    expect(await token.totalSupply()).to.equal(ownerBalance);

    //   either we can use expect(...) method or assert.equal(...) method
    assert.equal(await toke.totalSupply(), ownerBalance);
  });
});
```

- Above, we can use either use **expect(...) or assert.equal(...) method**




##### Reusing common test setups with fixtures

- This setup could involve multiple deployments and other transactions.
- Doing that in every test means a lot of code duplication.
- Plus, executing many transactions at the beginning of each test can make the test suite much slower.

- To can avoid code duplication and improve the performance of your test suite we can use **fixtures**
- A fixture is a setup function that is run only the first time it's invoked.
- On every invocationshardhat will reset the state of networks.

```js
const {
  loadFixture,
} = require("@nomicfoundation/hardhat-toolbox/network-helpers");
const { expect } = require("chai");
const assert = require("assert");
const { ethers } = require("hardhat");

describe("Token contract", function () {
  // deploy token fixtures
  async function deployTokenFixture() {
    const [owner, addr1, addr2] = await ethers.getSigners();

    const token = await ethers.deployContract("Token");
    await token.waitForDeployment();

    // Fixtures can return anything you consider useful for your tests
    return { token, owner, addr1, addr2 };
  }

  // first test check
  it("Deployment should assign the total supply of tokens to the owner", async function () {
    // for every test now we can use fixture instead of redepolying contract.
    const { token, owner } = await loadFixture(deployTokenFixture);

    const ownerBalance = await token.balanceOf(owner.address);
    expect(await token.totalSupply()).to.equal(ownerBalance);
    assert.equal(await token.name(), "ERC721");
  });

  // second test check
  it("Test function", async function () {
    const { token, owner } = await loadFixture(deployTokenFixture);
    // ...rest of code
  });
});
```

**Note : To know more testing methods read hardhat testing docs (you know!!!)**





#### Debugging with Hardhat Network

- For debugging we will use **console.log()** in soilidity similar to JS.
- you can print logging messages and contract variables from your Solidity code.

```js
// contract/Web3.sol
import "hardhat/console.sol";

contract TestContract {
    // some code ...
    function publicMint() public payable{
        console.log("Amount transfer :", msg.value);
        // rest of code...
    }
}
```

- Lastly, run **npx hardhat test** to seee the result of debugging in terminal.




#### Deploying to a live network

- To run deploy our smart contract use following code:

```js
// THIS INITITALIZE AN RPC SERVER
npx hardhat node

// DEPLOYING ON LOCALHOST
npx hardhat ignition deploy ./ignition/modules/deploy.cjs --network localhost

// DEPLOYING ON TESTNET
npx hardhat ignition deploy ./ignition/modules/deploy.cjs --network sepolia
```

- In Hardhat, deployments are defined through **Ignition Modules.**
- Ignition modules are written inside **./ignition/modules directory.**



```js
// ./ignition/modules/deploy.js
const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

const TokenModule = buildModule("TokenModule", (m) => {
    // constructor params
    const entranceFee = 1_000_000_000n; // 0.01 ETH
    const interval = 30; // 30 seconds
    const initialOwner = "0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266"; 

    const token = m.contract("Web3",[entranceFee,interval,initialOwner]);

  return { token };
});

module.exports = TokenModule;
```

- Now to deploy our smart contract we will initialize an RPC server locally in our terminal(port:8545)
- We need to modify our **hardhat.config.js** file.

```js
// hardhat.config.js

require("@nomicfoundation/hardhat-toolbox");
const { vars } = require("hardhat/config");

// SET YOUR API KEY IN VARS AND NOT IN .ENV
// npx hardhat vars set API_KEY_NAME

const INFURA_API_KEY = vars.get("INFURA_API_KEY");
const PRIVATE_KEY = vars.get("PRIVATE_KEY");

module.exports = {
  solidity: "0.8.27",
  networks: {
    sepolia: {
      url: `https://sepolia.infura.io/v3/${INFURA_API_KEY}`,
      accounts: [PRIVATE_KEY],
    },
  },
  etherscan: {
    apiKey: vars.get("ETHERSCAN_ID"),
  },
  sourcify: {
    enabled: true,
  },
};
```

- Here, we are using **Infura blockchain node provider**





#### Store your API_KEY

- We will store our API_KEY, private_key and seed-phrase in **var** and not in **.env/.env.local**

```js
// RUN THE FOLLOWING COMMAND TO STORE THE KEY IN VAR
npx hardhat vars set API_KEY_NAME


// hardhat.config.cjs
const { vars } = require("hardhat/config");
const INFURA_API_KEY = vars.get("INFURA_API_KEY");
const PRIVATE_KEY = vars.get("PRIVATE_KEY");
```




#### Verify Smart Contract on etherscan

```js
// 1.
npx hardhat verify --network sepolia DEPLOYED_CONTRACT_ADDRESS
// 2.
npx hardhat ignition verify sepolia-deployment
```





#### SENDING ETH FROM FRONTEND (web3.utils)

- On frontend, `if we need to send ether to contract` :

```js
await lottery.methods.sendSomeEthToContract().send({
    from:account,
    value:web3.utils.toWei('0.001','ether'),
    gas:"300000",
    gasPrice:undefined
});
```

- Always, the balance is returned in wei(10^18). `To convert in ETH`:

```js
// this will convert wei -> eth
import Web3 from "web3";
const web3 = new Web3();
const weiToEth = web3.utils.toWei('0.01','ether');
```





### FOUNDRY AND FORGE️‍ 🔥

- Foundry totally written on solidity.

**Note : dependencies are added as git-submodules and not as npm or nodejs modules**

- **src folder** : All our main smart contracts
- **test folder** : All the test are written here.
- **scripts folder** : To interact with smart contract we will write scripting file in soilidity
- Project is configured using the **foundry.toml** file
- **lib folder** : Dependencies are stored as git-submodules in lib/

- After compiling/deploying the smart contract **abi array will be in out/ folder in contract name file**

#### INSTALLATION

```solidity
// only once
curl -L https://foundry.paradigm.xyz | bash
source ~/.bashrc 
foundryup
// to initialize project
forge init ProjectName
forge install openzeppelin/openzeppelin-contracts
```

**forge** : the build, test, debug, deploy smart contracts
**anvil** :  the foundry equivalent of Ganache
**cast** : low level access to smart contracts (a bit of a truffle console equivalent)

#### Compile smart contract

```solidity
forge build
```

#### .env and foundry.toml file

```solidity
// .env
SEPOLIA_RPC_URL=
PRIVATE_KEY=
ETHERSCAN_API_KEY=


// foundry.toml
[rpc_endpoints]
sepolia = "${SEPOLIA_RPC_URL}"

[etherscan]
sepolia = { key = "${ETHERSCAN_API_KEY}"}


// This loads in the private key from our .env file
uint256 privateKey = vm.envUint("ANVIL_PRIVATE_KEY");
```



#### SOLIDITY SCRIPTING

- Written in solidity
- they are run on the fast Foundry EVM backend, **which provides dry-run capabilities.**
- **By default, scripts are executed by calling the function named `run`, our entrypoint.**

- Pass all the constructor params in contract instance.
- **We will use `HelperConfig.s.sol and Intraction.s.sol` file in our `Deploy.s.sol`**




#### DEPLOYING SMART CONTRACT (COMMANDS)

```solidity
// Scripting with Arguments(Passing params from command line) OPTIONAL
forge script --chain sepolia script/Deploy.s.sol:MyScript "NFT tutorial" TUT baseUri --sig 'run(string,string,string)' --rpc-url $SEPOLIA_RPC_URL --broadcast --verify -vvvv


// using anvil
anvil
forge script script/Deploy.s.sol:MyScript --fork-url http://localhost:8545 --broadcast
forge script script/Deploy.s.sol:MyScript --fork-url http://localhost:8545 --account <account_name> --sender <address> --broadcast


// on testnet sepolia
forge script script/Deploy.s.sol:MyScript --rpc-url $SEPOLIA_RPC_URL --broadcast --verify -vvvv
forge script script/Deploy.s.sol:MyScript --rpc-url $SEPOLIA_RPC_URL --account <account_name> --sender <address> --broadcast --verify -vvvv
forge script script/Deploy.s.sol:MyScript --rpc-url $SEPOLIA_RPC_URL --private-key $PRIVATE_KEY --broadcast --verify -vvvv
```



#### STORE YOUR PRIVATE KEY IN KEYSTORE (CAST)

- Here, we will not store our private key in dotenv file. Rather, we will store it in **KeyStore** provided by foundry.
- Once we have stored it in keystore we can used it in any project.
**Note** : This is useful when we need to submit our private key in an terminal.

```solidity
cast wallet import privateKey --interactive
cast wallet list
```


##### DEPLOYING ON TESTNET, ANVIL and ROLLUPS BLOCKCHAIN

- deploy our Smart Contract using Foundry scripts.
- We will write the deploy code in the **script** folder in solidity.



**By default, scripts are executed by calling the function named run, our entrypoint.**



**script/Deploy.s.sol**
```solidity
import {Script} from "forge-std/Script.sol";
import {TestContract} from "../src/Web3.sol";

contract MyScript is Script{
    
    // BY DEFAULT forge script EXECUTES THE 'run' FUNCTION DURING DEPLOYMENT
    function setUp() external returns(TestContract){
        // This loads in the private key from our .env file
        uint256 privateKey = vm.envUint("ANVIL_PRIVATE_KEY");

        // contract creations made by our main script contract.
        // private key is passed to instruct to use that key for signing the transactions. 
        vm.startBroadcast(privateKey);
        
        // If we have constructor then passed the value in the function as params.
        // CREATED A NEW CONTRACT INSTANCE.
        TestContract token = new TestContract("Token Name","ETH", "base_URL");

        vm.stopBroadcast();
        return token;
    }

    function run() external returns(TestContract){
        return setUp();
    }
}
```




#### DEPLOY SCRIPT CONTRACT || HELPERCONFIG FILE || INTERACTION FILE

- In  **`HelperConfig.s.sol`** file we will declare all the `params, function and variables` we need to pass in constructor during deployment.


**HelperConfig.s.sol**
```solidity
contract HelperConfig is Script{
    // ERROR
    error HelperConfig__InvalidChainId();

    // TYPES (pass all the constructor params here)
    struct NetworkConfig {
        uint priceFeed;
    }

    // STATE VARIABLES
    // Local network state variables
    NetworkConfig public localNetworkConfig;
    mapping(uint256 chainId => NetworkConfig) public networkConfigs;

    // FUNCTIONS
    constructor(){
        networkConfigs[ETH_SEPOLIA_CHAIN_ID] = getSepoliaETHConfig();
        networkConfigs[ZKSYNC_SEPOLIA_CHAIN_ID] = getL2ChainConfig();
        networkConfigs[LOCAL_CHAIN_ID] = getAnvilETHConfig();
    }

    function getConfig() public view returns(NetworkConfig memory){
        return getConfigByChainId(block.chainid);
    }

    function getConfigByChainId(uint256 chainId) public view returns(NetworkConfig memory){
        if(networkConfigs[chainId].VRFCoordinator != address(0)){
            return networkConfigs[chainId];
        } else if(chainId == LOCAL_CHAIN_ID){
            return networkConfigs[chainId];
        }else{
            revert HelperConfig__InvalidChainId();
        }
    }

    // CONFIGS FOR SEPOLIA AND L2 CHAINS
    function getSepoliaETHConfig() public pure returns(NetworkConfig memory){
        return NetworkConfig({priceFeed:200});
    }

    function getL2ChainConfig() public view returns(NetworkConfig memory){
        return NetworkConfig({priceFeed:200});
    }

    // LOCAL CONFIG (Local testing using a Mock contract)
    // Here, we will write the mock script smart contract on local network  
    function getAnvilETHConfig() public returns(NetworkConfig memory){
        // Check to see if we set an active network config
        if(localNetworkConfig.VRFCoordinator != address(0)){
            return localNetworkConfig;
        }

        // DEPLOY MOCK SMART CONTRACT
        vm.startBroadcast();
        VRFCoordinatorV2_5Mock mockVRFcontract = new VRFCoordinatorV2_5Mock(MOCK_BASEPRICE);
        vm.stopBroadcast();

        localNetworkConfig = NetworkConfig({priceFeed:200});
        return localNetworkConfig;
    }

}
```

- In `Interaction.s.sol` we will create functions from which our `on-chain data interacts with off-chain data`
- Example : chainlink VRF, chainlink automation, Data feeds and chainlink functions.




**Interaction.s.sol**
```solidity
import {Lottery} from "src/Lottery.sol";
import {HelperConfig, CodeConstants} from "./HelperConfig.s.sol";


contract FundSubscription is Script{

    function fundSubscriptionWithConfig() public {
        HelperConfig helperConfig = new HelperConfig();
        uint subId = helperConfig.getConfig().subscriptionId;
        fundSubscription(subId);
    }

    function fundSubscription(uint256 subId) public {
        uint amount = 0.01 ether;
        vm.startBroadcast();
        MockContract(contractAddress).topUpSubscription(amount);
        vm.stopBroadcast();
    }

    function run() public {
        fundSubscriptionWithConfig();
    }
}

contract AddConsumer is Script{

    function addConsumerWithConfig() public {
        HelperConfig helperConfig = new HelperConfig();
        addConsumer();
    }

    function addConsumer() public {
        vm.startBroadcast();
        MockContract(contractAddress).addConsumers(address(0));
        vm.stopBroadcast();
    }

    function run() public {
        addConsumerWithConfig();
    }
}
```


- This is the basic structure of writing **HelperConfig and Interaction** file.



**By default, scripts are executed by calling the function named run, our entrypoint.**

- This is the `pattern and best practice` we should followed!!!


**Deploy.s.sol**
```solidity
import {Contract} from "../src/Contract.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
import {FundSubscription, AddConsumer} from "./Interaction.s.sol";

contract MyScript is Script {

    function setUp() public returns (Contract, HelperConfig){
        // CREATED NEW HELPERNETWORK CONFIG INSTANCE
        HelperConfig helperConfig = new HelperConfig();
        HelperConfig.NetworkConfig memory config = helperConfig.getConfig();

        // If for some valid condition we need to call the interaction.s.sol
        if(condition){
            // funding subscription
            FundSubscription fundSubscription = new FundSubscription();

            // add consumer after deployment
            AddConsumer addConsumer = new AddConsumer();
        }


        vm.startBroadcast();
        // pass all the constructor params here...
        Contract token = new Contract(
            config.priceFedd,
            config.DataFeed,
        );
        vm.stopBroadcast();

        return {token,helperConfig};
    }

    // BY DEFAULT forge script EXECUTES THE 'run' FUNCTION DURING DEPLOYMENT
    function run() external returns(Contract,HelperConfig) {
        return setUp();
    }
}
```



**change the .env and foundry.toml file**

**.env**
```js
# SEPOLIA TESTNET
SEPOLIA_RPC_URL=https://sepolia.infura.io/v3/{INFURA_KEY}
ETHERSCAN_API_KEY=
PRIVATE_KEY=

# ANVIL LOCALLY
LOCALLY_RPC_URL=http://localhost:8545
ANVIL_PRIVATE_KEY=
```

**foundry.toml**
```js
[profile.default]
src = "src"
out = "out"
libs = ["lib"]
remappings = [
                '@chainlink/contracts@1.2.0/=lib/chainlink-brownie-contracts/contracts',
                'forge-std/=lib/forge-std/src/',
                '@solmate/=lib/solmate/src'
                ]

solc = "0.8.26"
via_ir = true
fs_permissions = [
    { access = "read", path = "./broadcast" },
    { access = "read", path = "./reports" },
]
[fuzz]
runs=256
```




#### INTERACTING WITH SC USING CAST

- After deploying sc we can interact (send/call) the functions using **cast**

```bash
cast send <address> "setName(string)" "anurag" --rpc-url <rpc_url> --private-key <private_key>
cast call <address> "getName()"
cast to-base 0x7717 dec

# returns function selector/functionID/methodID
cast sig "transfer(address,uint256)"
# To check params with HEX data before TNX
cast --calldata-decode "transfer(address,uint256)" HEXData
```



#### TO USE L2, ROLLUPS BLOCKCHAIN TECH. (EX: ZKSYNC)

```js
// to use vanilla-foundry
foundryup

// to use L2/ROLLUPS
foundry-zksync
```

- For L2 and rollups you can refer there docs for more clearance
- **--zksync** refers that we are running on L2/rollups blockchain





#### TESTING IN FOUNDRY

- The tests in Foundry are written in Solidity.
- If the test function reverts, the test fails, otherwise it passes.
- We will use **VM Cheatcodes.**
- contract name starting with **test** are considered as a good practice in foundry

- Forge Standard Library -> forge-std

1. **UNIT TESTING** - TESTING A SPECIFIC PARTs OF OUR CODE.
2. **INTEGRATION TEST** - TESTING THE INTERACTIONS PART OF OUR SMART CONTRACT
3. **FORKED TEST** - TESTING OUR CODE ON A SIMULATED REAL ENVIRONMENT(Sepolia or Rollups)
4. **STAGING TEST** - TESTING OUR CODE IN TESTNET/MAINNET. EX:- SEPOLIA, ANVIL LOCAL TESTING

5. **FUZZ TESTING** -  identify vulnerabilities in a smart contract by systematically inputting random data values
   - Stateful fuzz
   - stateless fuzz
   - formal verification



#### FORK TESTING/UNIT TESTING (COMMANDS)   

- Forge supports testing in a forked environment
- To run all tests in a forked environment, such as a forked Ethereum mainnet, pass an RPC URL via the --fork-url flag

- Sometimes we need to run test from scratch. Before running test again remove the **cache directory**/**forge clean**

```solidity
// TO LOAD THE .env CONTENT
source .env
echo $RPC_URL

// TESTING SC
forge test -vvv
forge test --fork-url $RPC_URL -vvvv

// TO RUN THE SINGLE TEST
forge test --mt testFunctionName
forge test --mt testBalance -vvv --fork-url $RPC_URL


// DEBUGGING SC
forge debug --debug src/Web3.sol:TestContract --sig "function(argu)" "arguValue"


// Verifiying smart contract on etherscan
forge test --fork-url <your_rpc_url> --etherscan-api-key <your_etherscan_api_key>
```




#### Forge Standard Library

- **Vm.sol**: Up-to-date cheatcodes interface
- **console.sol and console2.sol**: Hardhat-style logging functionality
- **Script.sol**: Basic utilities for Solidity scripting
- **Test.sol**: A superset of DSTest containing standard libraries, a cheatcodes instance (vm), and Hardhat console





#### Some best practices to follow!!!

1. **`vm.prank(address(0))`** 
   - simulate a TNX to be sent from given specific address.

2. **`vm.deal(address(this), 1 ether)`** 
   - Used to give the test contract Ether to work with.
   - We also can send Ether to specific address for test!!!

3. **`vm.expectRevert()`**
   - Agar mera call/send function revert ho gaya, Toh mera test pass ho jayega.
   - Else, test fail ho jayega.

4. **`vm.expectRevert(Contract.CustomError.selector)`**    
   - import the error from contract with 'selector'

5. **`vm.expectRevert(abi.enocodeSelector(Contract.CustomError.selector, params1, params2))`**

6. **test_FunctionName**
   - Functions prefixed with 'test' are run as a test case by forge.

7. **For, testFail** 
   - A good practice is to use the pattern **test_Revert[If|When]_Condition** in combination with the **expectRevert** cheatcode

    ```solidity
        function test_RevertCannotSubtract43() public {
            vm.expectRevert(stdError.arithmeticError);
            testNumber -= 43;
        }
    ```

8. **Test functions must have either **external or public** visibility.**


9. **type aliases(enum, struct, array,errors,events) can be call using main contract(Lottery) only.**
    ```solidity
    function test_GetRaffleState() public view {
        assert(lottery.getLotteryStatus() == Lottery.LotteryStatus.Open);
    }
    ```


10.  **functions(call/send) can be called by our instance(lottery)**
    ```solidity
    function test_CheckEntranceFee() public view {
        assertEq(lottery.getEntryFeeAmount(), 0.01 ether);
    }
    ```


11.  **To Transfer some value during calling or Transact eth to SC**

    ```solidity
    function test_LotteryCheckIfUserIsAdded() external {
        vm.prank(USER);
        // by this method we pass some eth to our user.
        lottery.enterLottery{value:_entranceFee}();
        }
    ```


12. **`vm.expectEmit()`** : 
    -  a specific log is emitted during the next call.

    ```solidity
    function test_LotteryEntranceFeeEvents() external{
        vm.prank(USER);
        // for indexed params we will set it true 
        vm.expectEmit(true, false, false,false , address(lottery));
        emit EnteredUser(USER);
        lottery.enterLottery{value:_entranceFee}();
    }
    ```



13. **`vm.warp() || vm.roll()`**
    - Sets block.timestamp.
    - Sets block.timestamp.

    ```solidity
    function test_UserNotAllowedToEnterLotteryWhenClosed() external {
        vm.prank(USER);
        lottery.enterLottery{value:_entranceFee}();
        vm.warp(block.timestamp + _interval + 1);
        vm.roll(block.timestamp + 1);
    }
    ``` 


14. **`vm.recordLogs() || vm.getRecordedLogs()`**
    - Tells the VM to start recording all the emitted events.
    - To access them, use `getRecordedLogs`  

    ```solidity
    function test_GetEventsLogs() public {
        vm.recordLogs();
        lottery.performUpkeep("");
        Vm.Log[] memory logs = vm.getRecordedLogs();
        bytes32 value = logs[1].topics[1];
        assert(uint256(value) > 0);
    }
    ``` 


15. **`vm.readFile(path)`**
    - This cheatcode is used for `filesystem manipulation operations`.
    - We can read different file(svg,json,text).

    **foundry.toml**
    ```solidity
    fs_permissions = [{ access = "read", path = "./"}]
    ``` 
    **Use vm.readFile(path)**
    ```solidity
    string memory SVG = vm.readFile('img/monkey.svg');
    ```



16. **During testing with foundry, keep some point for best practices:**
    - Never make a variable public which contain imp. keys.
    - Write `getterFunctions` 
    - Only main contract can call `errors,events,structs,enums,types aliases`
    - Contract instance can call/send `getter n write functions`
    - continue...




#### WRITING UNIT/FORK TEST

- For, advance testing we will use `HelperConfig, MainContract and Deploy` file.
- Follow, `Best practices and vm cheatcodes above for advance and better testing`.


**Contract.t.sol**
```solidity
import {Contract} from "src/Contract.sol";
import {ContractScript} from "script/Deploy.s.sol";
import {HelperConfig,CodeConstants} from "script/HelperConfig.s.sol";


contract ContractTest is Test {
    Contract contracts;
    HelperConfig helperConfig;

    // all constructor params and used variables
    uint params1;
    uint params2;
    uint params3;

    // events : Copy all events from contract to be used

    /**
       * here we will use our deploy script contract instance
       * our deploy script setUp() returns 'Main contract' and 'HelperConfig contract'
       * provide some eth to user for testing
    */

    function setUp() public {
        ContractScript contractScript = new ContractScript();
        (contracts,helperConfig) = contractScript.setUp();
        HelperConfig.NetworkConfig memory config = helperConfig.getConfig();
        _param1 = config.param1;
        _param2 = config.param2;
        _param3 = config.param3;

        // provide some eth to user for testing
        vm.deal(address(0),1e18);
    }

    function test_GetContractStatus() public {
        assert(contracts.getStatus() == Open);
    }

    function test_SomeChecks() external {
        assert(contracts.getSomeVar() == 1 ether);
    }

}
```






#### Remapping dependencies

- Before running the forge remapping command we need to store the path in **toml**
- Forge can remap dependencies to make them easier to import. Forge will automatically try to deduce some remappings for you:


```js
remapping = ['@chainlink/contracts/=lib/chainlink-brownie-contracts/contracts']
```

- **@chainlink/contracts** now is equal to the actual path of contract

```solidity
forge remappings
```




#### FOUNDRY COVERAGE

- Displays which parts of your code are covered by tests.

```solidity
// View summarized coverage:
forge coverage

// Create lcov file with coverage data:
forge coverage --report lcov

// This will create a .txt file that will give us the parts of our contracts cover:
forge coverage --report debug > coverage.txt
```





### Advanced EVM - Opcodes, Calling and low-level instructions🔥

- **The EVM basically represents all the instructions a computer needs to be able to read.**
- Any language that can compile down to bytecode with these opcodes is considered `EVM compatible`


1. **Data in Transactions**:
    - When we send a transaction, it is `compiled` down to bytecode
    - The EVM processes this data to determine which function to call and what inputs to provide.

2. **Bytecode**:
   - When a contract is deployed, it is compiled into `bytecode understood by the EVM.` 
   - This `bytecode` represents exactly the `low level instructions` to make our contract happen.
   - This **bytecode consist of opcodes**

3. **Opcodes**:
   - Each opcode is a 2-character hexadecimal, represents some special instruction
   - This opcode reader is sometimes abstractly called the `EVM`   
  
4. **Encoding Data**:
    - Now, `ABI encoding will convert data into bytes `
    - **abi.encodePacked() || abi.encode()**

5. **Decoding data**:
    - Decoding is the process of taking the raw bytes and reconstructing the original data
    - **abi.decode()**


6. **Low-Level call and staticcall**:
    1. **`call`** 
        - How we call functions to change the state variable of the blockchain

    2. **`staticcall`**
       - This is how (at a low level) we do our "view" or "pure" function calls  





#### Send TNX that call functions with just data field populated (EVM Signature Selector)

- In order to call a function using only the data field of call, we need to encode:
    - function name
    - parameters we want to add


- Now each contract assigns each function it has a **`function ID/Method ID`**:
    
    1. **`Function selector`** is the first 4 bytes of the function signature
    2. **`Function signature`** a string that defines the function name & parameters
                                `transfer(address,uint256)`




**send TNX by calling a function by populating the data field!!!**:  

- Lets assume, we need to call `transfer(address,uint256)` but by filling the data field


1. **`getFunctionSelector`**:

   ```solidity
    function getSelector() public pure returns (bytes4 selector) {
        selector = bytes4(keccak256(bytes("transfer(address,uint256)")));
    }
   ``` 


2. **`call Transfer Function with selector`**:
    
   - Will use **`abi.encodeWithSelector(bytes4 selector, args1, args2)`** 

    ```solidity
    function callTransferData(address _address, uint256 _amount) public returns (bytes4 ,bool) {
        (bool success, bytes memory data) = address(this).call(
            abi.encodeWithSelector(getSelector(), _address,_amount)
        );
        return (bytes4(data), success);
    }
    ```

3. **`call Transfer Function with signature`**:

    - Will use **`abi.encodeWithSignature(string functSignature, args1, args2)`**

    ```solidity
    function callTransferDataSig(address _address, uint256 _amount) public returns (bytes4 ,bool) {
        (bool success, bytes memory data) = address(this).call(
            abi.encodeWithSignature("transfer(address,uint256)", _address,_amount)
        );
        return (bytes4(data), success);
    }
    ```



#### Best practices to follow, to check the correct metamask TNX before TNX happens!!!

- The calls we discuss previously all our **`low-level calls`** that our used to omptimize our code.

1. **Check address**
2. **Check function selector(MethodID/FunctionID)**:
   - `cast sig "transfer(address,uint256)"` 
   - This will return the function selector

3. **Decode the call data to check params**:
   - `cast --calldata-decode "transfer(address,uint256)" HexData` 
   - This will return the params passed, before TNX
   - **HexData** will be available in metamask TNX pop-up!!!







### FOUNDRY-DEVOPS🔥

#### foundry-devops

A repo to get the most recent deployment from a given environment in foundry. This way, you can do scripting off previous deployments in solidity.

It will look through your `broadcast` folder at your most recent deployment.

#### Features

- Get the most recent deployment of a contract in foundry
- Checking if you're on a zkSync based chain

#### Getting Started

#### Installation

- Update forge-std to use newer FS cheatcodes

```bash
forge install Cyfrin/foundry-devops --no-commit

forge install foundry-rs/forge-std@v1.8.2 --no-commit
```

#### Usage - Getting the most recent deployment

**1. Update your `foundry.toml` to have read permissions on the `broadcast` folder.**

```solidity
fs_permissions = [
    { access = "read", path = "./broadcast" },
    { access = "read", path = "./reports" },
]
```

2. **Import the package, and call `DevOpsTools.get_most_recent_deployment("MyContract", chainid);`**

ie:

```solidity
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {MyContract} from "my-contract/MyContract.sol";
.
.
.
function interactWithPreviouslyDeployedContracts() public {
    address contractAddress = DevOpsTools.get_most_recent_deployment("MyContract", block.chainid);
    MyContract myContract = MyContract(contractAddress);
    myContract.doSomething();
}
```

#### Usage - zkSync Checker

#### Prerequisites

- [foundry-zksync](https://github.com/matter-labs/foundry-zksync)
  - You'll know you did it right if you can run `foundryup-zksync --help` and you see a response like:

```
The installer for Foundry-zksync.

Update or revert to a specific Foundry-zksync version with ease.
.
.
.
```

#### Usage - ZkSyncChainChecker

In your contract, you can import and inherit the abstract contract `ZkSyncChainChecker` to check if you are on a zkSync based chain. And add the `skipZkSync` modifier to any function you want to skip if you are on a zkSync based chain.

It will check both the precompiles or the `chainid` to determine if you are on a zkSync based chain.

```javascript
import {ZkSyncChainChecker} from "lib/foundry-devops/src/ZkSyncChainChecker.sol";

contract MyContract is ZkSyncChainChecker {

  function doStuff() skipZkSync {
```

#### ZkSyncChainChecker modifiers

- `skipZkSync`: Skips the function if you are on a zkSync based chain.
- `onlyZkSync`: Only allows the function if you are on a zkSync based chain.
  
#### ZkSyncChainChecker Functions

- `isZkSyncChain()`: Returns true if you are on a zkSync based chain.
- `isOnZkSyncPrecompiles()`: Returns true if you are on a zkSync based chain using the precompiles.
- `isOnZkSyncChainId()`: Returns true if you are on a zkSync based chain using the chainid.

#### Usage - FoundryZkSyncChecker

In your contract, you can import and inherit the abstract contract `FoundryZkSyncChecker` to check if you are on the `foundry-zksync` fork of `foundry`.

> !Important: Functions and modifiers in `FoundryZkSyncChecker` are only available if you run `foundry-zksync` with the `--zksync` flag.

```javascript
import {FoundryZkSyncChecker} from "lib/foundry-devops/src/FoundryZkSyncChecker.sol";

contract MyContract is FoundryZkSyncChecker {

  function doStuff() onlyFoundryZkSync {
```

You must also add `ffi = true` to your `foundry.toml` to use this feature.

#### FoundryZkSync modifiers

- `onlyFoundryZkSync`: Only allows the function if you are on `foundry-zksync`
- `onlyVanillaFoundry`: Only allows the function if you are on `foundry`

#### FoundryZkSync Functions

- `is_foundry_zksync`: Returns true if you are on `foundry-zksync`



### WEB3 FRONTEND CODE SNIPPETS🔥

- It contains some `code snippets for frontend` that are used repeatedly in frontend!!!



#### CONNECT WALLET BTN FUNCTION (FRONTEND)


```js
'use client';
import React from 'react'
import { ConnectWalletBtn } from '../components/ConnectWalletBtn';
import ToDoList from '../components/ToDoList';
import { Web3 } from 'web3';
import address from "../config";
import abi from "../abi";


const Home = () => {
  const [correctNet, setCorrectNet] = React.useState(false);
  const [loggedIn, setLoggedIn] = React.useState(false);
  const [currentAcc, setCurrentAcc] = React.useState('');
  const [input, setInput] = React.useState('');
  const [task,setTasks] = React.useState([]);
  const web3 = new Web3('https://sepolia.infura.io/v3/6e2aaaa2ff0c4e00995a96624cca8e7a');

  // INITIALIZE THE SMART CONTRACT  

  const token = new web3.eth.Contract(abi.abi, address.contractAddress);

  // CONNECT WALLET BTN FUNCTION
  const ConnectWallet = async ()=>{
    try {
      const {ethereum} = window;

      if(!ethereum){
        console.log("MetaMask not detected!!!");
        return;
      }
      
      const chainId = await ethereum.request({method:"eth_chainId"});
      console.log("connected to chain id : ", chainId);
      
      const sepoliaChainId = "0xaa36a7";
      if(chainId != sepoliaChainId){
          alert("You are not connected to sepolia test network!!!") 
          setCorrectNet(false);
          return;
      }
      setCorrectNet(true);

      const accounts = await ethereum.request({method:"eth_requestAccounts"});
      console.log("account address detected : ", accounts[0]);
      setLoggedIn(true);
      setCurrentAcc(accounts[0]);

    } catch (error) {
      console.log(error);
    }
  } 

  // ADD TASK FUNCTION
  const AddTask = async ()=>{
    try {
      const {ethereum} = window;
      if(ethereum){
          await token.methods.addTask(input).send({from:currentAcc})
          .then(res=>{
            setTasks(...task,task);
            console.log("Task added");
          })
          .catch(error =>{
            console.log(error);
          })
      } else{
        console.log("Eth does not exist");
        
      }
    } catch (error) {
      console.log(error);
    }
  }

  return (
    <div>
      <div>
        <h1 className='btn btn-primary m-4'>{currentAcc}</h1>
        {
          loggedIn ? <ToDoList setInput={setInput} AddTask={AddTask}></ToDoList> : <ConnectWalletBtn ConnectWallet={ConnectWallet} />
        }
      </div>
    </div>
  )
}

export default Home; 
```



# deploying on anvil using cast 
