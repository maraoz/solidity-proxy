pragma solidity ^0.4.8;

import "./DispatcherStorage.sol";

contract Dispatcher {
  function() {
    DispatcherStorage dispatcherStorage = DispatcherStorage(0x1111222233334444555566667777888899990000);
    uint32 len = dispatcherStorage.sizes(msg.sig);
    address target = dispatcherStorage.lib();

    assembly {
      calldatacopy(0x0, 0x0, calldatasize)
      let a := delegatecall(sub(gas, 10000), target, 0x0, calldatasize, 0, len)
      return(0, len)
    }
  }
}
