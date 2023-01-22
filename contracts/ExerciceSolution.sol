pragma solidity ^0.6.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./IExerciceSolution.sol";
import "./ERC20Claimable.sol";
import "./ExerciceSolutionToken.sol";

contract ExerciceSolution is IExerciceSolution{

    ERC20Claimable claimableERC20;
    address solutionToken;

    mapping(address => uint256) public claimTokenBalances;
    event Withdrawal(address indexed user, uint256 amount);

    constructor(ERC20Claimable _claimableERC20) public {
        claimableERC20=_claimableERC20;

        claimableERC20.claimTokens();
    }

    function claimTokensOnBehalf() external override{
        claimTokenBalances[msg.sender]+=claimableERC20.claimTokens();
    }

    function tokensInCustody(address callerAddress) external override returns (uint256){
        return claimTokenBalances[callerAddress];
    }

    function withdrawTokens(uint256 amountToWithdraw) external override returns (uint256){
        require(amountToWithdraw > 0, "Amount to withdraw must be greater than 0");
        address payable user = msg.sender;
        require(claimTokenBalances[user] >= amountToWithdraw, "Insufficient token balance");
        claimTokenBalances[user] -= amountToWithdraw;
        claimableERC20.transfer(user,amountToWithdraw);
        emit Withdrawal(user, amountToWithdraw);
        return amountToWithdraw;
    }

    function depositTokens(uint256 amountToWithdraw) external override returns (uint256){
        address user = msg.sender;
        require(claimableERC20.transferFrom(user, address(this), amountToWithdraw), "transferFrom failed");
        claimTokenBalances[user] += amountToWithdraw;
        // claimTokenBalances[address(this)]-=amountToWithdraw; ??
        ExerciceSolutionToken(solutionToken).mint(user,amountToWithdraw);



        return amountToWithdraw;
    }

    function setERC20DepositAddress() external override {
        solutionToken=msg.sender;
    }

    function getERC20DepositAddress() external override returns (address){
        return solutionToken;
    }

}
