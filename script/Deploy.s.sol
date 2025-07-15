// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "forge-std/Script.sol";
import "../src/Registry.sol";

// Nethermind: Modify the script to use the private key and configuration from env file
contract DeployScript is Script {
    modifier broadcast() {
        uint256 privateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(privateKey);
        _;
        vm.stopBroadcast();
    }

    function run() external broadcast {
        // Nethermind: Read the configuration from the env file
        uint256 minCollateralWei = vm.envUint("MIN_COLLATERAL_WEI");
        uint256 fraudProofWindow = vm.envUint("FRAUD_PROOF_WINDOW");
        uint256 unregistrationDelay = vm.envUint("UNREGISTRATION_DELAY");
        uint256 slashWindow = vm.envUint("SLASH_WINDOW");
        uint256 optInDelay = vm.envUint("OPT_IN_DELAY");

        // Nethermind: Create the configuration for the Registry contract using the new variables
        IRegistry.Config memory config = IRegistry.Config({
            minCollateralWei: uint80(minCollateralWei),
            fraudProofWindow: uint32(fraudProofWindow),
            unregistrationDelay: uint32(unregistrationDelay),
            slashWindow: uint32(slashWindow),
            optInDelay: uint32(optInDelay)
        });

        // Deploy the Registry contract
        Registry registry = new Registry(config);

        // Log the deployed address
        console.log("Registry deployed to:", address(registry));
    }
}
