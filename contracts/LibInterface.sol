pragma solidity ^0.4.8;

library LibInterface {
  struct S { uint i; }

  function getUint(S storage s) returns (uint);
  function setUint(S storage s, uint i);
}
