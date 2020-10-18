pragma solidity ^0.5.0;

import './UsingTellor.sol';

contract YourContract is UsingTellor{
 ...
    constructor(address _userContract) UsingTellor(_userContract) public{

    }   
    /**
    * @dev Allows the user to get the latest value for the requestId specified
    * @param _requestId is the requestId to look up the value for
    * @return bool true if it is able to retreive a value, the value, and the value's timestamp
    */
    function getLastValue(uint256 _requestId) public view returns (bool ifRetrieve, uint256 value, uint256 _timestampRetrieved) {
        return getCurrentValue(_requestId);
    }
 ...
}