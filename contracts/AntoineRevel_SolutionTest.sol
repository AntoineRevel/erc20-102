pragma solidity ^0.6.0;

import "./Evaluator.sol";
import "./ERC20TD.sol";
import "./ERC20Claimable.sol";

contract AntoineRevel_SolutionTest {
    Evaluator evaluator;
    ERC20TD tdToken;
    ERC20Claimable claimableToken;

    IExerciceSolution solution;
    
    constructor(IExerciceSolution _solution,Evaluator _evaluator,ERC20TD _tdToken,ERC20Claimable _claimableERC20) public{
        evaluator=_evaluator;
        tdToken=_tdToken;
        claimableToken=_claimableERC20;
        solution=_solution;

        submitExercice();
    }

    function startClaimPoint() public{
        start_ex1();
        evaluator.ex2_claimedFromContract();
    }

    function start_ex1() private {
        claimableToken.claimTokens();
        evaluator.ex1_claimedPoints();
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
