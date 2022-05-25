const treeCoinContractAddress = "0x6F6621EA05E7c2C5af925fc9Df015584E220aE2a";

async function main() {
    const [deployer] = await ethers.getSigners();

    console.log("Deploying contracts with the account:", deployer.address);

    const weiAmount = (await deployer.getBalance()).toString();

    console.log("Account balance:", (await ethers.utils.formatEther(weiAmount)));

    const SimpleStakingProtocol = await ethers.getContractFactory("SimpleStaking");
    const contract = await SimpleStakingProtocol.deploy(treeCoinContractAddress);

    console.log("Simple Staking Protocol contract address:", contract.address);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });