pragma solidity ^0.4.8;

import "./LibInterface.sol";

contract TheContract {
  LibInterface.S s;
  int8 hola;

  using LibInterface for uint;

  function get() returns (uint) {
    return LibInterface.getUint();
  }
}
