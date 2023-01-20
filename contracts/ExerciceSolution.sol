pragma solidity ^0.6.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./IExerciceSolution.sol";

contract ExerciceSolution is IExerciceSolution{

    constructor() public {
    }

    function claimTokensOnBehalf() external override{

    }

    function tokensInCustody(address callerAddress) external override returns (uint256){
        return 0;
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
