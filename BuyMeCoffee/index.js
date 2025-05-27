import { createWalletClient, custom, createPublicClient, formatEther, parseEther,defineChain} from 'https://esm.sh/viem'
import { abi, contractAddress } from './constant.js';


let connectBtn = document.getElementById('connectBtn');
let getBalanceBtn = document.getElementById('getBalanceBtn');
let withdrawBtn = document.getElementById('withdrawBtn');
let fundBtn = document.getElementById('fundBtn');
let ethAmountValue = document.getElementById('ethAmount');

let walletClient;
let publicClient;


// Connecting Wallet
async function connect() {
    if (typeof window.ethereum !== 'undefined') {
        try {
            walletClient = createWalletClient({
                transport: custom(window.ethereum)
            })
            await walletClient.requestAddresses();
            connectBtn.innerText = 'Connected';
        } catch (error) {
            console.error(error);
        }
    } else {
        console.error("Install metamask");
    }
}

// Reading Balance
async function getBalance() {
    if (typeof window.ethereum !== 'undefined') {
        try {
            publicClient = createPublicClient({
                transport: custom(window.ethereum)
            })
            const balance = await publicClient.getBalance({
                address: contractAddress
            })
            console.log(formatEther(balance));
        } catch (error) {
            console.error(error);
        }
    } else {
        console.error("Install metamask");
    }
}


// Sending TNX/amount and Interacting with conmtracts
async function fund() {
    let ethAmount = ethAmountValue.value;
    console.log(`Funding with ${ethAmount} ETH...`);


    if (typeof window.ethereum !== 'undefined') {
        try {
            walletClient = createWalletClient({
                transport: custom(window.ethereum)
            });
            const [address] = await walletClient.requestAddresses();
            const currentChain = await getCurrentChain(walletClient);

            publicClient = createPublicClient({
                transport: custom(window.ethereum)
            })
            const { request } = await publicClient.simulateContract({
                address: contractAddress,
                abi: abi,
                functionName: 'fund',
                account: address,
                chain: currentChain,
                value: parseEther(ethAmount)
            })
            const hash = await walletClient.writeContract(request);
            console.log(`Transaction hash: ${hash}`);

        } catch (error) {
            console.error(error);
        }
    } else {
        console.error("Install metamask");
    }
}


// Getting the current chain
async function getCurrentChain(walletClient) {
    const chainId = await walletClient.getChainId();
    const currentChain = defineChain({
        id: chainId,
        name: 'Custom Chain',
        nativeCurrency: {
            decimals: 18,
            name: 'Ether',
            symbol: 'ETH',
        },
        rpcUrls: {
            default: {
                http: ['http://localhost:8545']
            },
        }
    })
    return currentChain;
}


// Interacting with contract
async function withdraw(){
    console.log("Withdrawing...");


    if (typeof window.ethereum !== 'undefined') {
        try {
            walletClient = createWalletClient({
                transport: custom(window.ethereum)
            });
            const [address] = await walletClient.requestAddresses();
            const currentChain = await getCurrentChain(walletClient);

            publicClient = createPublicClient({
                transport: custom(window.ethereum)
            })
            const { request } = await publicClient.simulateContract({
                address: contractAddress,
                abi: abi,
                functionName: 'withdraw',
                account: address,
                chain: currentChain,
            })
            const hash = await walletClient.writeContract(request);
            console.log(`Transaction hash: ${hash}`);
        } catch (error) {
            console.error(error);
        }
    } else {
        console.error("Install metamask");
    }
}


connectBtn.onclick = connect;
getBalanceBtn.onclick = getBalance;
fundBtn.onclick = fund;
withdrawBtn.onclick = withdraw;