pragma solidity ^0.6.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./IExerciceSolution.sol";
import "./ERC20Claimable.sol";

contract ExerciceSolution is IExerciceSolution{

    ERC20Claimable claimableERC20;
    mapping(address => uint256) public claimTokenBalances;
    event Withdrawal(address indexed user, uint256 amount);

    constructor(ERC20Claimable _claimableERC20) public {
        claimableERC20=_claimableERC20;
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
        user.transfer(amountToWithdraw);
        emit Withdrawal(user, amountToWithdraw);
        return amountToWithdraw;
    }

    function depositTokens(uint256 amountToWithdraw) external override returns (uint256){
        return 0;
    }

    function getERC20DepositAddress() external override returns (address){
        return address(0);
    }

}
