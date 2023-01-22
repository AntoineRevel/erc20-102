pragma solidity ^0.6.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./IExerciceSolution.sol";

contract ExerciceSolutionToken is ERC20("AntoineRevel_SolutionToken","ARST"){

    mapping(address => bool) public allowMinters;

    constructor(IExerciceSolution solution) public{
        allowMinters[address(solution)] = true;
        solution.setERC20DepositAddress();
    }

    function isMinter(address minterAddress) external view returns (bool){
        return allowMinters[minterAddress];
    }

    function mint(address toAddress, uint256 amount) external {
        require(allowMinters[msg.sender], "You are not a minter");
        _mint(toAddress, amount);
    }

}
