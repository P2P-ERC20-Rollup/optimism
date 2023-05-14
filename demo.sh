//todo mudar localhost para l1 e l2
source packages/contracts-bedrock/.env

////1st step
cast balance $TESTER_ADDR --rpc-url $L1
cast call $ERC20 "balanceOf(address)(uint256)" $TESTER_ADDR --rpc-url $L1
cast balance $TESTER_ADDR --rpc-url $L2


// send funds to tester
//State changin
cast send $TESTER_ADDR --value 10ether --rpc-url $L1 --private-key $DEPLOYER_PK
cast send $ERC20 "approve(address,uint256)" $PORTAL_L1 10000000000000000000000000000 --rpc-url $L1 --private-key $TESTER_PK
cast send $PORTAL_L1 "depositTransaction(address,uint256,uint64,bool,bytes)" $TESTER_ADDR 10000000000000000000 1000000 false 0x00 --private-key $TESTER_PK

//view results
cast call $ERC20 "balanceOf(address)(uint256)" $TESTER_ADDR --rpc-url $L1
cast balance $TESTER_ADDR --rpc-url $L1
cast balance $TESTER_ADDR --rpc-url $L2


//2nd step
//state change
//verify trasnfers in l2
cast balance $TESTER_ADDR2 --rpc-url $L2
cast send $TESTER_ADDR2 --value 5000000000000000000 --rpc-url $L2 --private-key $TESTER_PK

//view results
cast balance $TESTER_ADDR --rpc-url $L2
cast balance $TESTER_ADDR2 --rpc-url $L2


//3rd step
cast call $ERC20 "balanceOf(address)(uint256)" $TESTER_ADDR2 --rpc-url $L1
# cast send $TESTER_ADDR2 --value somevalue --private-key $TESTER_PK --rpc-url $L2
cast send $PORTAL_L2 --value 4000000000000000000 --private-key $TESTER2_PK --rpc-url $L2

//
# cast balance $TESTER_ADDR --rpc-url $L2
cast balance $TESTER_ADDR2 --rpc-url $L2
cast call $ERC20 "balanceOf(address)(uint256)" $TESTER_ADDR2 --rpc-url $L1
# //todo set this portal
# cast send $PORTAL_L2 --value asjkfbsajkbfgkajslbfga --private-key $TESTER_PK



# cast balance $TESTER_ADDR2 --rpc-url $L2
# cast call $ERC20 "balanceOf(address)(uint256)" $TESTER_ADDR2 --rpc-url $L1
