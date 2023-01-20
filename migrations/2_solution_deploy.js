var ExerciceSolution = artifacts.require("ExerciceSolution.sol");
var ExerciceSolutionTest = artifacts.require("AntoineRevel_SolutionTest.sol")

module.exports = (deployer, network, accounts) => {
    deployer.then(async () => {
        await deployExerciceSolution(deployer, network, accounts);
        await deployRecap(deployer, network, accounts);
        await testSolution(deployer, network, accounts);
    });
};

async function deployRecap(deployer, network, accounts) {
    console.log("mySolution " + mySolution.address);
    console.log("myTest " + myTest.address);

}

async function deployExerciceSolution(deployer, network, accounts) {
    mySolution= await ExerciceSolution.new();
    myTest= await ExerciceSolutionTest.new(mySolution.address);
}

async function testSolution(deployer, network, accounts) {
    myBalance = await myTest.getBalanceToken.call();
    console.log("My balance : " + myBalance)
}

