var ExerciceSolution = artifacts.require("ExerciceSolution.sol");
var ExerciceSolutionTest = artifacts.require("AntoineRevel_SolutionTest.sol")

var TDErc20 = artifacts.require("ERC20TD.sol");
var ERC20Claimable = artifacts.require("ERC20Claimable.sol");
var evaluator = artifacts.require("Evaluator.sol");

var LocalTDToken="0x6084D43b9bE0234f5C67e3C768dAFf79dACB8e05";
var LocalClaimableToken="0x6dFD61555D8AB8BD542787F0A52d9D1e5dc1e6b4";
var LocalEvaluator="0x0F21621a753E072052F4E37eCc6d9c692e54F1C5";


module.exports = (deployer, network, accounts) => {
    deployer.then(async () => {
        if (network == "goerli") {
            await setStaticContracts();
            await deployExerciceSolution();
            await deployRecap();
            await myTest.startClaimPoint();
            await printPoint();
        } else if  (network == "ganache") {
            await deploylocalExerciceSolution();
            await deployRecap();
            await myTest.startClaimPoint();
            await printPoint();
        }
    });
};

async function setStaticContracts() {
    TDToken = await TDErc20.at("0xb79a94500EE323f15d76fF963CcE27cA3C9e32DF")
    ClaimableToken = await ERC20Claimable.at("0xE70AE39bDaB3c3Df5225E03032D31301E2E71B6b")
    Evaluator = await evaluator.at("0x16F3F705825294A55d40D3D34BAF9F91722d6143")
}

async function deployExerciceSolution() {
    mySolution= await ExerciceSolution.new(ClaimableToken.address);
    myTest= await ExerciceSolutionTest.new(mySolution.address,Evaluator.address,TDToken.address,ClaimableToken.address);
}

async function deploylocalExerciceSolution() {
    mySolution= await ExerciceSolution.new(LocalClaimableToken);
    myTest= await ExerciceSolutionTest.new(mySolution.address,LocalEvaluator,LocalTDToken,LocalClaimableToken);
}

async function deployRecap() {
    console.log("mySolution " + mySolution.address);
    console.log("myTest " + myTest.address);
}

async function printPoint(){
    myBalance = await myTest.getBalancePointToken.call();
    myClaimableBalance = await myTest.getBalanceClaimableToken.call();

    result="My balance : " + myBalance + " | My ClaimableToken balance : " + myClaimableBalance
    console.log(result)
}
