pragma solidity ^0.6.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./IExerciceSolution.sol";
import "./ERC20Claimable.sol";
import "./ExerciceSolutionToken.sol";

//Solution of TD ERC20 102 by Leo Trotin and Antoine Revel
//ESILV FinTech 2022-2023

contract ExerciceSolution is IExerciceSolution {

    ERC20Claimable claimableERC20;
    ExerciceSolutionToken solutionToken;

    mapping(address => uint256) public claimTokenBalances;

    event Withdrawal(address indexed user, uint256 amount);

    constructor(ERC20Claimable _claimableERC20, ExerciceSolutionToken _solutionToken) public {
        claimableERC20 = _claimableERC20;
        claimableERC20.claimTokens();
        solutionToken = _solutionToken;
    }

    function claimTokensOnBehalf() external override {
        address payable user = msg.sender;
        uint256 claimedTokens = claimableERC20.claimTokens();
        claimTokenBalances[user] += claimedTokens;
        solutionToken.mint(user, claimedTokens);
    }

    function tokensInCustody(address callerAddress) external override returns (uint256){
        return claimTokenBalances[callerAddress];
    }

    function withdrawTokens(uint256 amountToWithdraw) external override returns (uint256){
        require(amountToWithdraw > 0, "Amount to withdraw must be greater than 0");
        address payable user = msg.sender;
        require(claimTokenBalances[user] >= amountToWithdraw, "Insufficient token balance");
        claimTokenBalances[user] -= amountToWithdraw;
        claimableERC20.transfer(user, amountToWithdraw);
        emit Withdrawal(user, amountToWithdraw);
        solutionToken.burn(user, amountToWithdraw);
        return amountToWithdraw;
    }

    function depositTokens(uint256 amountToWithdraw) external override returns (uint256){
        address user = msg.sender;
        require(claimableERC20.transferFrom(user, address(this), amountToWithdraw), "transferFrom failed");
        claimTokenBalances[user] += amountToWithdraw;
        solutionToken.mint(user, amountToWithdraw);
        return amountToWithdraw;
    }

    function setERC20DepositAddress() external override {
        solutionToken = ExerciceSolutionToken(msg.sender);
    }

    function getERC20DepositAddress() external override returns (address){
        return address(solutionToken);
    }

}
