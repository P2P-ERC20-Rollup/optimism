// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Votes.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TestERC20 is ERC20Burnable, ERC20Votes, Ownable {
    constructor() ERC20("TestERC20", "TST") ERC20Permit("TestERC20") {}

    /**
     * @notice Allows anyone to mint tokens.
     *
     * @param _account The account receiving minted tokens.
     * @param _amount  The amount of tokens to mint.
     */
    function mint(address _account, uint256 _amount) public {
        _mint(_account, _amount);
    }

    /**
     * @notice Allows anyone to burn tokens.
     *
     * @param _account The account receiving minted tokens.
     * @param _amount  The amount of tokens to mint.
     */
    function burn(address _account, uint256 _amount) public {
        _burn(_account, _amount);
    }

    /**
     * @notice Callback called after a token transfer.
     *
     * @param from   The account sending tokens.
     * @param to     The account receiving tokens.
     * @param amount The amount of tokens being transfered.
     */
    function _afterTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal override(ERC20, ERC20Votes) {
        super._afterTokenTransfer(from, to, amount);
    }

    /**
     * @notice Internal mint function.
     *
     * @param to     The account receiving minted tokens.
     * @param amount The amount of tokens to mint.
     */
    function _mint(address to, uint256 amount) internal override(ERC20, ERC20Votes) {
        super._mint(to, amount);
    }

    /**
     * @notice Internal burn function.
     *
     * @param account The account that tokens will be burned from.
     * @param amount  The amount of tokens that will be burned.
     */
    function _burn(address account, uint256 amount) internal override(ERC20, ERC20Votes) {
        super._burn(account, amount);
    }
}
