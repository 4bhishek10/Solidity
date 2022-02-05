// SPDX-License-Identifier: MIT
pragma solidity >=0.6.6 <0.9.0;



import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";
import "@chainlink/contracts/src/v0.6/vendor/SafeMathChainlink.sol";



contract GST{
    using SafeMathChainlink for uint256;
    mapping(address => uint256) addressToAmountFunded;
    address[] public funders;
    address owner;
    address gov;

    constructor() public{
        owner = msg.sender;
    }

    function fund() public payable {
        addressToAmountFunded[msg.sender] += msg.value;
        funders.push(msg.sender);
    }

    function getConversionRate(uint256 ethAmount) view public returns(uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x9326BFA02ADD2366b30bacB125260Af641031331);
        (, int256 answer,,,) = priceFeed.latestRoundData();
        uint256 ethPrice = uint256(answer) * 10000000000;
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1000000000000000000;
        return ethAmountInUsd;
    }

    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }

    function displayBalance() public view returns(uint256){
        uint256 balance = address(this).balance;
        return balance;
    }
 

    function withdraw() public payable onlyOwner{
        uint256 gst = (address(this).balance * 18) / 100;
        payable(0x6CBc355cA0890b096A36aa83F842755f3558e667).transfer(gst);
        msg.sender.transfer(address(this).balance);
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);
    }
}