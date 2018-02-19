var LibInterface = artifacts.require("./LibInterface.sol");
var DispatcherStorage = artifacts.require("./DispatcherStorage.sol");
var Dispatcher = artifacts.require("./Dispatcher.sol");
var TheContract = artifacts.require("./TheContract.sol");

module.exports = function(deployer) {
    deployer.deploy(LibInterface)
    .then(() => {
        return deployer.deploy(DispatcherStorage, LibInterface.address)})
    .then(() => {
    	Dispatcher.unlinked_binary = Dispatcher.unlinked_binary.replace(
    		'0x1111222233334444555566667777888899990000',
            DispatcherStorage.address
        );
        return deployer.deploy(Dispatcher)})
    .then(() => {
	    deployer.link(Dispatcher, TheContract).then(() => {
	    	return deployer.deploy(TheContract)})
    });
};