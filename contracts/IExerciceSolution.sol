pragma solidity ^0.6.0;

import "./ExerciceSolutionToken.sol";

interface IExerciceSolution 
{

	function claimTokensOnBehalf() external;

	function tokensInCustody(address callerAddress) external returns (uint256);

	function withdrawTokens(uint256 amountToWithdraw) external returns (uint256); 

	function depositTokens(uint256 amountToWithdraw) external returns (uint256);

	function setERC20DepositAddress() external;

	function getERC20DepositAddress() external returns (address);


}
