pragma solidity ^0.4.8;

import "../contracts/LibInterface.sol";

library Example {
  function getUint(LibInterface.S storage s) returns (uint) {
    return s.i;
  }
  function setUint(LibInterface.S storage s, uint i) {
    s.i = i;
  }
}
