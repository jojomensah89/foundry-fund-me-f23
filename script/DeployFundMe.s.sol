// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract DeployFundMe is Script {
    function run() external returns (FundMe,HelperConfig) {
        // deploy a new instance of the helper config contract before vm.startBroadcast (no gas will be used)
        // Not a Real tx
        HelperConfig helperConfig = new HelperConfig();
        address ethpriceFeed = helperConfig.activeNetworkConfig();

        // Real tx  after startBroadcast
        vm.startBroadcast();

        FundMe fundMe = new FundMe(ethpriceFeed);

        vm.stopBroadcast();

        // Return an instance of the FundMe.sol contract
        return (fundMe,helperConfig);
    }
}
