pragma solidity ^0.4.4;

import "truffle/Assert.sol";

contract LibraryProxy {
  address public target;
  bytes data;

  function LibraryProxy(address _target) {
    target = _target;
  }    

  //prime the data using the fallback function.
  function() {
    data = msg.data;
  }

  function execute() returns (bool) {
    return target.call(data);
  }
}

// Contract you're testing
contract SampleLib {
  function doThrow() {
    throw;
  }

  function doNoThrow() {
    //
  }
}


contract TestProxyLibrary {
  function testThrow() {
    SampleLib lib = new SampleLib();
    LibraryProxy proxy = new LibraryProxy(lib); 

    SampleLib(proxy).doThrow();
    bool rf = proxy.execute.gas(200000)();
    Assert.isFalse(rf, "Should be false, as it should throw");

  }
}

