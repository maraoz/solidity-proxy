pragma solidity ^0.4.8;

contract DispatcherStorage {
  address public lib;
  mapping(bytes4 => uint32) public sizes;

  function DispatcherStorage(address newLib) public {
    sizes[bytes4(keccak256("getUint(LibInterface.S storage)"))] = 32;
    replace(newLib);
  }

  function replace(address newLib) internal /* onlyDAO */ {
    lib = newLib;
  }
}
