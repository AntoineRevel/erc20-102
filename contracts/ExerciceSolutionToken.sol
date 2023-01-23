pragma solidity ^0.6.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Burnable.sol";

import "./IExerciceSolution.sol";
import "./IERC20Mintable.sol";

contract ExerciceSolutionToken is ERC20("AntoineRevel_SolutionToken", "ARST"), ERC20Burnable, IERC20Mintable {

    mapping(address => bool) public allowMinters;

    constructor() public {
        allowMinters[msg.sender] = true;
    }

    function isMinter(address minterAddress) external override view returns (bool){
        return allowMinters[minterAddress];
    }

    function setMinter(address minterAddress, bool isMint) override external {
        require(allowMinters[msg.sender], "No permission");
        allowMinters[minterAddress] = isMint;
    }

    function mint(address toAddress, uint256 amount) override external {
        require(allowMinters[msg.sender], "You are not a minterrre");
        _mint(toAddress, amount);
    }

    function burn(address toAddress, uint256 amount) external {
        require(allowMinters[msg.sender], "You are not allow");
        _burn(toAddress, amount);
    }

}
