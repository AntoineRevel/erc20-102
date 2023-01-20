var ExerciceSolution = artifacts.require("ExerciceSolution.sol");
var ExerciceSolutionTest = artifacts.require("AntoineRevel_SolutionTest.sol")

module.exports = (deployer, network, accounts) => {
    deployer.then(async () => {
        await deployExerciceSolution(deployer, network, accounts);
        await deployRecap(deployer, network, accounts);
        await printPoint();
        await myTest.startGetPoint();
        await printPoint();
    });
};

async function deployExerciceSolution(deployer, network, accounts) {
    mySolution= await ExerciceSolution.new();
    myTest= await ExerciceSolutionTest.new(mySolution.address);
}

async function deployRecap(deployer, network, accounts) {
    console.log("mySolution " + mySolution.address);
    console.log("myTest " + myTest.address);
}

async function printPoint(){
    myBalance = await myTest.getBalancePointToken.call();
    console.log("My balance : " + myBalance);
    myClaimableBalance = await myTest.getBalanceClaimableToken.call();
    console.log("My ClaimableToken balance : " + myClaimableBalance);
}


