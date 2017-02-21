pragma solidity ^0.4.8;

contract Upgradeable {
    // mapping(bytes4 => uint32) _sizes;
    // address _dest;

    function replace(address target) {
        // _dest = target;
        // bool b = target.delegatecall(bytes4(sha3("initialize()")));
    }
}

contract Dispatcher is Upgradeable {
    function Dispatcher(address target) {
        replace(target);
    }

    function() {
      bytes4 sig;
      assembly { sig := calldataload(0) }
      var len = 32; //_sizes[sig];
      var target = 0x710db63a07b95dd04bc46d155d10148419aecbe5; // _dest;

      assembly {
        // return _dest.delegatecall(msg.data)
        calldatacopy(0x0, 0x0, calldatasize)
        let a := delegatecall(sub(gas, 10000), target, 0x0, calldatasize, 0, len)
        return(0, len)
      }
    }
}
