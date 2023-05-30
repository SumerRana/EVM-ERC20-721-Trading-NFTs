// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

contract TokenSwap {
    address public token1;
    address public token2;
    address public token3;
    address public token4;

    constructor(
        address _token1,
        address _token2,
        address _token3,
        address _token4
    ) {
        token1 = _token1;
        token2 = _token2;
        token3 = _token3;
        token4 = _token4;
    }

    function transfer(
        uint256 amount1,
        uint256 amount2,
        uint256 amount3,
        uint256 amount4,
        address receiver
    ) public payable  {
        require(amount1 > 0 || amount2 > 0 || amount3 > 0 || amount4 > 0, "At least one token amount must be greater than 0");

        // Transfer token1 from the sender to this contract
        if (amount1 > 0) {
            require(IERC20(token1).transferFrom(msg.sender, receiver, amount1), "Transfer of token1 failed");
        }

        // Transfer token2 from the sender to this contract
        if (amount2 > 0) {
            require(IERC20(token2).transferFrom(msg.sender, receiver, amount2), "Transfer of token2 failed");
        }

        // Transfer token3 from the sender to this contract
        if (amount3 > 0) {
            require(IERC20(token3).transferFrom(msg.sender, receiver, amount3), "Transfer of token3 failed");
        }

        // Transfer token4 from the sender to this contract
        if (amount4 > 0) {
            require(IERC20(token4).transferFrom(msg.sender, receiver, amount4), "Transfer of token4 failed");
        }
    }
}
