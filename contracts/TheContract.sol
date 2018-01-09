pragma solidity ^0.4.8;

import "./LibInterface.sol";

contract TheContract {
  LibInterface.S s;

  using LibInterface for LibInterface.S;

  function get() public constant returns (uint) {
    return s.getUint();
  }

  function set(uint i) public {
    return s.setUint(i);
  }
}
