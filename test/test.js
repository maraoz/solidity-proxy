/*
contract TestProxyLibrary {
  function testReturn() {
    Example lib = new Example();
    Dispatcher dispatcher = new Dispatcher(address(lib));

    // uint ret = SampleLib(proxy).foo();
    Assert.equal(address(this), address(this), "Should be 42");
  }
}
*/

const Example = artifacts.require("./Example.sol")
const Example2 = artifacts.require("./Example2.sol");
const Dispatcher = artifacts.require("Dispatcher.sol");

contract('TestProxyLibrary', () => {
  describe('test', () => {
    it('works', () => {
      Example.new()
        .then(example => Dispatcher.new(example.address))
        .then(d => {
          dispatcher = d
          return Example.at(dispatcher.address).setUint(1010101)
        })
        .then(() => Example2.new())
        .then(newExample => dispatcher.replace(newExample.address))
        .then(() => Example.at(dispatcher.address).getUint.call())
        .then(console.log)
    })
  })
})
