var ExerciceSolution = artifacts.require("ExerciceSolution.sol");
var ExerciceSolutionTest = artifacts.require("AntoineRevel_SolutionTest.sol")

var LocalTDToken="0x6084D43b9bE0234f5C67e3C768dAFf79dACB8e05";
var LocalClaimableToken="0x6dFD61555D8AB8BD542787F0A52d9D1e5dc1e6b4";
var LocalEvaluator="0x0F21621a753E072052F4E37eCc6d9c692e54F1C5";


module.exports = (deployer, network, accounts) => {
    deployer.then(async () => {
        await deployExerciceSolution(deployer, network, accounts);
        await deployRecap(deployer, network, accounts);
        await myTest.startClaimPoint();
        await printPoint();
    });
};

async function deployExerciceSolution() {
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
