const HammerNFT = artifacts.require("HammerNFT");
const LumberNFT = artifacts.require("LumberNFT");

const wood_address = "0x5620A72F18790CDcFcddD6B9Aad1f615a401227C";
const rock_address = "0x97242c25a9385AD17A3A697EbEFa2b937484b14C";

module.exports = function (deployer) {
  deployer.deploy(HammerNFT, wood_address, rock_address,1, 1)
    .then(() => deployer.deploy(LumberNFT, wood_address, 10));
};
