pragma solidity ^0.4.4;

import "truffle/Assert.sol";

contract SampleLib {
  address target;

  function foo() returns(uint){
    return 42;
  }
}

contract Proxy {
  address target;
  
  function Proxy(address a){
    target = a;
  }

  function () {
    assembly {
      return(0, 0)
    }
  }
}

contract TestProxyLibrary {
  function testReturn() {
    SampleLib lib = new SampleLib();
    Proxy proxy = new Proxy(lib); 

    uint ret = SampleLib(proxy).foo();
    Assert.equal(ret, 42, "Should be 42");
  }

}

