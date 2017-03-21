'use strict';

const Example = artifacts.require('./Example.sol');
const Example2 = artifacts.require('./Example2.sol');
const Dispatcher = artifacts.require('Dispatcher.sol');
const DispatcherStorage = artifacts.require('DispatcherStorage.sol');
const TheContract = artifacts.require('TheContract.sol');

contract('TestProxyLibrary', () => {
  describe('test', () => {
    it('works', () => {
      var thecontract, dispatcherStorage;
      Example.new()
        .then(example => DispatcherStorage.new(example.address))
        .then(d => {
          dispatcherStorage = d;
          Dispatcher.unlinked_binary = Dispatcher.unlinked_binary
            .replace('1111222233334444555566667777888899990000',
            dispatcherStorage.address.slice(2));
          return Dispatcher.new();
        })
        .then(dispatcher => {
          TheContract.link('LibInterface', dispatcher.address);
          return TheContract.new();
        })
        .then(c => {
          thecontract = c;
          return thecontract.set(10);
        })
        .then(() => Example2.new())
        .then(newExample => dispatcherStorage.replace(newExample.address))
        .then(() => thecontract.get())
        .then(x => assert.equal(x, 10 * 10)); // Example 2 getter multiplies
    });
    it.only('measure gas costs', () => {
    });
  });
});
