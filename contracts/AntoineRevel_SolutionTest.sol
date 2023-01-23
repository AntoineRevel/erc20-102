pragma solidity ^0.6.0;

import "./Evaluator.sol";
import "./ERC20TD.sol";
import "./ERC20Claimable.sol";
import "./ExerciceSolutionToken.sol";

contract AntoineRevel_SolutionTest {
    Evaluator evaluator;
    ERC20TD tdToken;
    ERC20Claimable claimableToken;
    ExerciceSolutionToken solutionToken;
    IExerciceSolution solution;

    constructor(IExerciceSolution _solution, Evaluator _evaluator, ERC20TD _tdToken, ERC20Claimable _claimableERC20, ExerciceSolutionToken _solutionToken) public {
        evaluator = _evaluator;
        tdToken = _tdToken;
        claimableToken = _claimableERC20;
        solution = _solution;
        solutionToken = _solutionToken;

        submitExercice();
    }

    function startClaimPoint() public {
        start_ex1();
        evaluator.ex2_claimedFromContract();
        evaluator.ex3_withdrawFromContract();
        start_ex4();
        start_ex5();
        evaluator.ex6_depositTokens();
        evaluator.ex7_createERC20();
        evaluator.ex8_depositAndMint();
        evaluator.ex9_withdrawAndBurn();
    }

    function start_ex1() private {
        claimableToken.claimTokens();
        evaluator.ex1_claimedPoints();
    }

    function start_ex4() private {
        claimableToken.approve(address(solution), 1000000000000000000);
        evaluator.ex4_approvedExerciceSolution();
    }

    function start_ex5() private {
        claimableToken.approve(address(solution), 0);
        evaluator.ex5_revokedExerciceSolution();
    }

    function submitExercice() private {
        evaluator.submitExercice(solution);
    }

    function getBalancePointToken() public view returns (uint256){
        return tdToken.balanceOf(address(this));
    }

    function getBalanceClaimableToken() public view returns (uint256){
        return claimableToken.balanceOf(address(this));
    }
}
