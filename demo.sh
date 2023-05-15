#!/bin/bash

source packages/contracts-bedrock/.env

# 1st step
# Initial State Viewing
echo "Initial State View:"
echo "Initial Tester Native Balance in Layer 1"
cast balance $TESTER_ADDR --rpc-url $L1
echo -e "\nInitial Tester ERC20 Balance in Layer 1"
cast call $ERC20 "balanceOf(address)(uint256)" $TESTER_ADDR --rpc-url $L1
echo -e "\nInitial Tester Native Balance in Layer 2"
cast balance $TESTER_ADDR --rpc-url $L2


# Send gas funds to tester, approve on erc20 and execute bridging
# State changing
echo -e "\nSetting approvals and sending gas eth"
cast send $TESTER_ADDR --value 10ether --rpc-url $L1 --private-key $DEPLOYER_PK
cast send $ERC20 "approve(address,uint256)" $PORTAL_L1 10000000000000000000000000000 --rpc-url $L1 --private-key $TESTER_PK
echo -e "\nBridging ERC20 to its native Rollup"
cast send $PORTAL_L1 "depositTransaction(address,uint256,uint64,bool,bytes)" $TESTER_ADDR 10000000000000000000 1000000 false 0x00 --private-key $TESTER_PK

# View results
echo -e "\nTester ERC20 Balance in Layer 1"
cast call $ERC20 "balanceOf(address)(uint256)" $TESTER_ADDR --rpc-url $L1
echo -e "\nNative tester balance in Layer 1"
cast balance $TESTER_ADDR --rpc-url $L1
echo -e "\nNative tester balance in Layer 2"
cast balance $TESTER_ADDR --rpc-url $L2


# 2nd step
# State change
# Verify tester2 balance
echo -e "\nNative Tester2 balance in Layer 2"
cast balance $TESTER_ADDR2 --rpc-url $L2
# Send balance From tester1 to tester2
echo -e "\nTransferring Native ERC20 token to Tester2 in Rollup"
cast send $TESTER_ADDR2 --value 5000000000000000000 --rpc-url $L2 --private-key $TESTER_PK

# View results
# View balance of both users on L2
echo -e "\nTester1 Layer 2 Balance:"
cast balance $TESTER_ADDR --rpc-url $L2
echo -e "\nTester2 Layer 2 Balance:"
cast balance $TESTER_ADDR2 --rpc-url $L2


# # 3rd step
# # Check Tester2's ERC balance on L1 and verify that it is 0
# cast call $ERC20 "balanceOf(address)(uint256)" $TESTER_ADDR2 --rpc-url $L1


# #### BRIDGE BACK TO PORTAL L2
# cast send $PORTAL_L2 --value 4000000000000000000 --private-key $TESTER2_PK --rpc-url $L2

# # View state changes and verify that tester2 No longer has L2 balance
# # And now has ERC20 balance instead
# cast balance $TESTER_ADDR2 --rpc-url $L2
# cast call $ERC20 "balanceOf(address)(uint256)" $TESTER_ADDR2 --rpc-url $L1
