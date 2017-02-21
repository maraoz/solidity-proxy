const Example = artifacts.require("./Example.sol")
const Example2 = artifacts.require("./Example2.sol");
const Dispatcher = artifacts.require("Dispatcher.sol");
const TheContract = artifacts.require("TheContract.sol");

contract('TestProxyLibrary', () => {
  describe('test', () => {
    it('works', () => {
      Example.new()
        .then(example => Dispatcher.new(example.address))
        .then(d => {
          dispatcher = d
          TheContract.link('LibInterface', dispatcher.address)
          return TheContract.new()
        })
        .then(c => {
          thecontract = c
          return thecontract.get.call()
        })
        .then(x => {
          console.log(x.toNumber())
          return Example2.new()
        })
        .then(newExample => dispatcher.replace(newExample.address))
        .then(() => thecontract.get.call())
        .then(x => console.log(x.toNumber()))
    })
  })
})
