// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Counters.sol";

interface IERC20 {
    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    function transfer(address recipient, uint256 amount)
        external
        returns (bool);

    function allowance(address owner, address spender)
        external
        view
        returns (uint256);

    function approve(address spender, uint256 amount) external returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}

contract tradeOffer {
    using Counters for Counters.Counter;

    address public token1;
    address public token2;
    address public token3;
    address public token4;
    address public token5;

    address private offeror;
    address private acceptor;

    struct Stake {
        uint256 amount1;
        uint256 amount2;
        uint256 amount3;
        uint256 amount4;
        uint256 amount5;
    }

    mapping(address => Stake) stakeMapping;
    mapping(uint256 => bool) offerStatus;
    mapping(uint256 => uint256) offerTimestamp;

    Counters.Counter private offerCounter;

    constructor(
        address _token1,
        address _token2,
        address _token3,
        address _token4,
        address _token5
    ) {
        token1 = _token1;
        token2 = _token2;
        token3 = _token3;
        token4 = _token4;
        token4 = _token5;
    }

    function makeOffer(
        uint256 _amount1,
        uint256 _amount2,
        uint256 _amount3,
        uint256 _amount4,
        uint256 _amount5
    ) public payable {
        require(
            _amount1 > 0 ||
                _amount2 > 0 ||
                _amount3 > 0 ||
                _amount4 > 0 ||
                _amount5 > 0,
            "At least one token amount must be greater than 0"
        );

        // Transfer token1 from the sender to this contract
        if (_amount1 > 0) {
            require(
                IERC20(token1).transferFrom(
                    msg.sender,
                    address(this),
                    _amount1
                ),
                "Transfer of token1 failed"
            );
            stakeMapping[msg.sender].amount1 += _amount1;
        }

        // Transfer token2 from the sender to this contract
        if (_amount2 > 0) {
            require(
                IERC20(token2).transferFrom(
                    msg.sender,
                    address(this),
                    _amount2
                ),
                "Transfer of token2 failed"
            );
            stakeMapping[msg.sender].amount2 += _amount2;
        }

        // Transfer token3 from the sender to this contract
        if (_amount3 > 0) {
            require(
                IERC20(token3).transferFrom(
                    msg.sender,
                    address(this),
                    _amount3
                ),
                "Transfer of token3 failed"
            );
            stakeMapping[msg.sender].amount3 += _amount3;
        }

        // Transfer token4 from the sender to this contract
        if (_amount4 > 0) {
            require(
                IERC20(token4).transferFrom(
                    msg.sender,
                    address(this),
                    _amount4
                ),
                "Transfer of token4 failed"
            );
            stakeMapping[msg.sender].amount4 += _amount4;
        }

        // Transfer token4 from the sender to this contract
        if (_amount5 > 0) {
            require(
                IERC20(token5).transferFrom(
                    msg.sender,
                    address(this),
                    _amount5
                ),
                "Transfer of token4 failed"
            );
            stakeMapping[msg.sender].amount5 += _amount5;
        }

        // Generate a new key using the offerCounter
        uint256 offerId = offerCounter.current();
        offerCounter.increment();

        // Update offerStatus mapping
        offerStatus[offerId] = true;

        //set Time Stamp to now
        offerTimestamp[offerId] = block.timestamp;
    }

    function acceptOffer(
        uint256 _offerCounter,
        uint256 _amount1,
        uint256 _amount2,
        uint256 _amount3,
        uint256 _amount4,
        uint256 _amount5
    ) public payable {
        require(_offerCounter > 0, "Offer does not exist");
        require(
            _amount1 > 0 ||
                _amount2 > 0 ||
                _amount3 > 0 ||
                _amount4 > 0 ||
                _amount5 > 0,
            "At least one token amount must be greater than 0"
        );

        // Transfer token1 from the sender to this contract
        if (_amount1 > 0) {
            require(
                IERC20(token1).transferFrom(
                    address(this),
                    msg.sender,
                    _amount1
                ),
                "Transfer of token1 failed"
            );
            stakeMapping[msg.sender].amount1 -= _amount1;
        }

        // Transfer token2 from the sender to this contract
        if (_amount2 > 0) {
            require(
                IERC20(token2).transferFrom(
                    address(this),
                    msg.sender,
                    _amount2
                ),
                "Transfer of token2 failed"
            );

            stakeMapping[msg.sender].amount2 -= _amount2;
        }

        // Transfer token3 from the sender to this contract
        if (_amount3 > 0) {
            require(
                IERC20(token3).transferFrom(
                    address(this),
                    msg.sender,
                    _amount3
                ),
                "Transfer of token3 failed"
            );
            stakeMapping[msg.sender].amount3 -= _amount3;
        }

        // Transfer token4 from the sender to this contract
        if (_amount4 > 0) {
            require(
                IERC20(token4).transferFrom(
                    address(this),
                    msg.sender,
                    _amount4
                ),
                "Transfer of token4 failed"
            );
            stakeMapping[msg.sender].amount4 -= _amount4;
        }

        if (_amount5 > 0) {
            require(
                IERC20(token5).transferFrom(
                    address(this),
                    msg.sender,
                    _amount5
                ),
                "Transfer of token4 failed"
            );
            stakeMapping[msg.sender].amount5 -= _amount5;
        }

        offerStatus[_offerCounter] = false;
    }

    function withdraw(uint256 _offerCounter) public payable {
        if (block.timestamp > offerTimestamp[_offerCounter] + (86400 * 2)) {
            require(_offerCounter > 0, "Offer does not exist");
            require(
                stakeMapping[msg.sender].amount1 > 0 ||
                    stakeMapping[msg.sender].amount2 > 0 ||
                    stakeMapping[msg.sender].amount3 > 0 ||
                    stakeMapping[msg.sender].amount4 > 0 ||
                    stakeMapping[msg.sender].amount5 > 0,
                "At least one token amount must be greater than 0"
            );

            if (stakeMapping[msg.sender].amount1 > 0) {
                require(
                    IERC20(token1).transferFrom(
                        address(this),
                        msg.sender,
                        stakeMapping[msg.sender].amount1
                    ),
                    "Transfer of token1 failed"
                );
                stakeMapping[msg.sender].amount1 -= stakeMapping[msg.sender]
                    .amount1;
            }

            if (stakeMapping[msg.sender].amount2 > 0) {
                require(
                    IERC20(token2).transferFrom(
                        address(this),
                        msg.sender,
                        stakeMapping[msg.sender].amount2
                    ),
                    "Transfer of token2 failed"
                );

                stakeMapping[msg.sender].amount2 -= stakeMapping[msg.sender]
                    .amount2;
            }

            if (stakeMapping[msg.sender].amount3 > 0) {
                require(
                    IERC20(token3).transferFrom(
                        address(this),
                        msg.sender,
                        stakeMapping[msg.sender].amount3
                    ),
                    "Transfer of token3 failed"
                );
                stakeMapping[msg.sender].amount3 -= stakeMapping[msg.sender]
                    .amount3;
            }

            if (stakeMapping[msg.sender].amount4 > 0) {
                require(
                    IERC20(token4).transferFrom(
                        address(this),
                        msg.sender,
                        stakeMapping[msg.sender].amount4
                    ),
                    "Transfer of token4 failed"
                );
                stakeMapping[msg.sender].amount4 -= stakeMapping[msg.sender]
                    .amount4;
            }

            if (stakeMapping[msg.sender].amount5 > 0) {
                require(
                    IERC20(token5).transferFrom(
                        address(this),
                        msg.sender,
                        stakeMapping[msg.sender].amount5
                    ),
                    "Transfer of token4 failed"
                );
                stakeMapping[msg.sender].amount5 -= stakeMapping[msg.sender]
                    .amount5;
            }

            offerStatus[_offerCounter] = false;
        }
    }
}
