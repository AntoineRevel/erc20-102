var ExerciceSolution = artifacts.require("ExerciceSolution.sol");
var ExerciceSolutionTest = artifacts.require("AntoineRevel_SolutionTest.sol")

module.exports = (deployer, network, accounts) => {
    deployer.then(async () => {
        await deployExerciceSolution(deployer, network, accounts);
        await deployRecap(deployer, network, accounts);
        await printPoint("Before :");
        await myTest.startClaimPoint();
        await printPoint("After :");
    });
};

async function deployExerciceSolution() {
    mySolution= await ExerciceSolution.new();
    myTest= await ExerciceSolutionTest.new(mySolution.address);
}

async function deployRecap() {
    console.log("mySolution " + mySolution.address);
    console.log("myTest " + myTest.address);
}

async function printPoint(time){
    myBalance = await myTest.getBalancePointToken.call();
    myClaimableBalance = await myTest.getBalanceClaimableToken.call();

    result="My balance : " + myBalance + " | My ClaimableToken balance : " + myClaimableBalance

    console.log(time);
    console.log(result)
}
