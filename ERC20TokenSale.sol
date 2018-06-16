pragma solidity ^0.4.24;
interface ERC20Fragment
{
    function transfer(address, uint) returns (bool);
}
contract TokenSale
{
    address public creator;
    address public tokenContract;
    uint public tokenPrice; // in wei
    uint public deadline;
    constructor(address source)
    {
        creator = msg.sender;
        tokenContract = source;
    }
    function setPrice(uint price)
    {
        if (msg.sender == creator) tokenPrice = price;
    }
    function setDeadline(uint timestamp)
    {
        if (msg.sender == creator) deadline = timestamp;
    }
    function buyTokens(address beneficiary) payable
    {
        require(
            block.timestamp < deadline
            && tokenPrice > 0
            && ERC20Fragment(tokenContract).transfer(beneficiary, 1000000000000000000 * msg.value / tokenPrice));
    }
    function payout()
    {
        creator.transfer(this.balance);
    }
}