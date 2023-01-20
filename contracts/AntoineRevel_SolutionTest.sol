pragma solidity ^0.6.0;

import "./Evaluator.sol";
import "./ERC20TD.sol";
import "./ERC20Claimable.sol";

contract AntoineRevel_SolutionTest {
    Evaluator evaluator;
    ERC20TD tdToken;
    ERC20Claimable claimableToken;

    IExerciceSolution solution;
    
    constructor(IExerciceSolution _solution) public{
        evaluator=Evaluator(0x0F21621a753E072052F4E37eCc6d9c692e54F1C5);
        tdToken=ERC20TD(0x6084D43b9bE0234f5C67e3C768dAFf79dACB8e05);
        claimableToken=ERC20Claimable(0x6dFD61555D8AB8BD542787F0A52d9D1e5dc1e6b4);
        solution=_solution;

        submitExercice();
    }

    function startGetPoint() public{
        ex1_claimedPoints();
    }

    function ex1_claimedPoints() private {
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
