pragma solidity ^0.4.4;

import "truffle/Assert.sol";

contract SampleLib {
  function doThrow() {
    throw;
  }

  function doNoThrow() {
    //
  }

  function foo() returns (uint) {
    return 42;
  }
}

contract SampleLib2 {
  address target;

  function foo() returns(uint){
    return 42;
  }
}


contract ProxyV1 {
  address public target;
  bytes data;

  function ProxyV1(address _target) {
    target = _target;
  }    

  function () {
    data = msg.data;
  }

  function execute() returns (bool) {
    return target.call(data);
  }
}



contract ProxyV2 {
  address target;
  
  function ProxyV2(address a){
    target = a;
  }

  function (){
    address _t = target;
    assembly {
      // return _dest.delegatecall(msg.data)
      calldatacopy(0x0, 0x0, calldatasize)
      delegatecall(sub(gas, 10000), _t, 0x0, calldatasize, 0, len)
      return(0, 32)
    }
  }
}


contract ProxyV3 {
  address target;
  
  function ProxyV3(address a){
    target = a;
  }

  function (){
  //Adds 185 in costs with no return value.
  //Adds 208 in gas with 32byte return value
    assembly{

      //gas needs to be `uint`ed
      let g := and(gas,0xEFFFFFFF)
      let o_code := mload(0x40) //Memory end
      //Address also needs to be masked
      //Also, important, storage location must be correct
      // sload(0) is dependant on the order of declaration above
      let addr := and(sload(0),0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF) //Dest address
      //Get call data (method sig & params)
      calldatacopy(o_code, 0, calldatasize)

      //callcode or delegatecall or call
      let retval := call(g
          , addr //address
          , 0 //value
          , o_code //mem in
          , calldatasize //mem_insz
          , o_code //reuse mem
          , 32) //Hardcoded to 32 b return value
          
      // Check return value
      // 0 == it threw, so we do aswell by jumping to 
      // bad destination (02)
      jumpi(0x02,iszero(retval))

      // return(p,s) : end execution, return data mem[p..(p+s))
      return(o_code,32)
    }
  }
}


contract TestProxyLibrary {
  function testThrow() {
    SampleLib lib = new SampleLib();
    ProxyV1 proxy = new ProxyV1(lib); 

    SampleLib(proxy).doThrow();
    bool rf = proxy.execute.gas(200000)();
    Assert.isFalse(rf, "Should be false, as it should throw");
  }

  function testReturn() {
    SampleLib2 lib = new SampleLib2();
    ProxyV2 proxy = new ProxyV2(lib); 

    uint ret = SampleLib2(proxy).foo();
    Assert.equal(ret, 42, "Should be 42");
  }

  function testReturn2() {
    SampleLib2 lib = new SampleLib2();
    ProxyV3 proxy = new ProxyV3(lib); 

    uint ret = SampleLib2(proxy).foo();
    Assert.equal(ret, 42, "Should be 42");
  }
}

