import { DeployFunction } from 'hardhat-deploy/dist/types'

import { assertContractVariable, deploy } from '../src/deploy-utils'

const deployFn: DeployFunction = async (hre) => {
  const { deployer } = await hre.getNamedAccounts()

  await deploy({
    hre,
    name: 'TestERC20',
    contract: 'TestERC20',
    args: [],
  })
}

deployFn.tags = ['erc20']

export default deployFn
