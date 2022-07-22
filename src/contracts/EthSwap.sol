pragma solidity ^0.5.14;

import "./Token.sol";

contract EthSwap{
    string public name = "EthSwap Instant Exchange";
    Token public token; //keep track of Token in contract
    uint public rate = 100; // Value of 1 eth

    event TokenPurchased(
        address account,
        address token,
        uint amount,
        uint rate
    );

    constructor(Token _token) public{
        token = _token;
    }

    function buyTokens() public payable{
        uint tokenAmount = msg.value * rate; // number of token for msg.value eth

        //stops execution if condition fails
        require(token.balanceOf(address(this))>=tokenAmount);
        token.transfer(msg.sender, tokenAmount);

        //Emit an event
        emit TokenPurchased(msg.sender, address(token), tokenAmount, rate);
    }

    function sellTokens(uint _amount) public {
        uint etherAmount = _amount / rate; // amount of ether to receive

        //transfer token from investor address to token address
        token.transferFrom(msg.sender, address(this), _amount);

        //transfer ether amount from token address to investor
        msg.sender.transfer(etherAmount);

    }
}