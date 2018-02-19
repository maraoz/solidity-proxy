pragma solidity ^0.4.8;

contract DispatcherStorage {
  address public lib;

  function DispatcherStorage(address newLib) public {
    replace(newLib);
  }

  function replace(address newLib) public /* onlyDAO */ {
    lib = newLib;
  }
}
