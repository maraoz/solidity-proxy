'use strict';

const Example = artifacts.require('./Example.sol');
const Example2 = artifacts.require('./Example2.sol');
const Dispatcher = artifacts.require('Dispatcher.sol');
const DispatcherStorage = artifacts.require('DispatcherStorage.sol');
const TheContract = artifacts.require('TheContract.sol');

contract('TestProxyLibrary', () => {
  describe('test', () => {
    it('works', async () => {
      const example = await Example.new()
      const dispatcherStorage = await DispatcherStorage.new(example.address)
      Dispatcher.unlinked_binary = Dispatcher.unlinked_binary
          .replace('1111222233334444555566667777888899990000',
              dispatcherStorage.address.slice(2))
      const dispatcher = await Dispatcher.new()
      TheContract.link('LibInterface', dispatcher.address);
      const thecontract = await TheContract.new()
      await thecontract.set(10)
      const x = await thecontract.get()
      assert.equal(x.toNumber(), 10)// Example return not multiplies

      const example2 = await Example2.new()
      await dispatcherStorage.replace(example2.address)
      const x2 = await thecontract.get()
      assert.equal(x2.toNumber(), 10 * 10);// Example2 return 10 multiplies
    });
    it('measure gas costs', (done) => {
      done();
    });
  });
})
;
