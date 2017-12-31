'use strict';

const lkTestHelpers = require('lk-test-helpers')
const {
  expectThrow
} = lkTestHelpers(web3)

const Example = artifacts.require('./Example.sol')
const ExampleReverts = artifacts.require('./ExampleReverts.sol')
const Example2 = artifacts.require('./Example2.sol')
const Dispatcher = artifacts.require('Dispatcher.sol')
const DispatcherStorage = artifacts.require('DispatcherStorage.sol')
const TheContract = artifacts.require('TheContract.sol')

contract('TestProxyLibrary', (accounts) => {
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

      const exampleReverts = await ExampleReverts.new()
      await dispatcherStorage.replace(exampleReverts.address)
      await expectThrow(thecontract.get())
    });
    it('measure gas costs', (done) => {
      done();
    });

    context('can call only owner', () => {
      let example, example2, dispatcherStorage, subject
      beforeEach(async () => {
        example = await Example.new()
        example2 = await Example2.new()
        dispatcherStorage = await DispatcherStorage.new(example.address, {from: accounts[0]})
        subject = (account) => dispatcherStorage.replace(example2.address, {from: account})
      })

      it('fail', async () => {
        await expectThrow(subject(accounts[1]))
      })
      it('success', async () => {
        const result = await subject(accounts[0])
        assert.isOk(result)
      })
    })
  });
})
;
