pragma solidity ^0.4.8;

import "../contracts/Dispatcher.sol";

contract Example is Upgradeable {
  uint _value = 10;

  function initialize() {
      _sizes[bytes4(sha3("getUint()"))] = 32;
  }

  function getUint() returns (uint) {
      return _value;
  }

  function setUint(uint value) {
      _value = value;
  }
}
