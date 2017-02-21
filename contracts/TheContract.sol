pragma solidity ^0.4.8;

import "./Dispatcher.sol";
import "./LibInterface.sol";

contract TheContract is Upgradeable {
  //LibInterface.S s;

  using LibInterface for uint;

  function get() returns (uint) {
    return LibInterface.getUint();
  }
}
