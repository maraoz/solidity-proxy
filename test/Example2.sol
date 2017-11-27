pragma solidity ^0.4.8;

import "../contracts/LibInterface.sol";

library Example2 {
  function getUint(LibInterface.S storage s) public constant returns (uint) {
    return s.i * 10;
  }

  function setUint(LibInterface.S storage s, uint i) public {
    s.i = i;
  }
}
