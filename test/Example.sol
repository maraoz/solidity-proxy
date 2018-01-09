pragma solidity ^0.4.8;

import "../contracts/LibInterface.sol";

library Example {
  function getUint(LibInterface.S storage s) public constant returns (uint) {
    return s.i;
  }
  function setUint(LibInterface.S storage s, uint i) public {
    s.i = i;
  }
}
