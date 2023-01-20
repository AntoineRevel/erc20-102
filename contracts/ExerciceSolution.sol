pragma solidity ^0.6.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./IExerciceSolution.sol";
import "./ERC20Claimable.sol";

contract ExerciceSolution is IExerciceSolution{

    ERC20Claimable claimableERC20;
    mapping(address => uint256) public balanceClaimToken;

    constructor(ERC20Claimable _claimableERC20) public {
        claimableERC20=_claimableERC20;
    }

    function claimTokensOnBehalf() external override{
        balanceClaimToken[msg.sender]+=claimableERC20.claimTokens();
    }

    function tokensInCustody(address callerAddress) external override returns (uint256){
        return balanceClaimToken[callerAddress];
    }

    function withdrawTokens(uint256 amountToWithdraw) external override returns (uint256){
        return 0;
    }

    function depositTokens(uint256 amountToWithdraw) external override returns (uint256){
        return 0;
    }

    function getERC20DepositAddress() external override returns (address){
        return address(0);
    }

}
