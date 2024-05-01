// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract MyToken is ERC20, AccessControl {
	bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

	constructor(
		address user_wallet
	)
		ERC20(
			"MYMONEYMOUNTAINMAMAMANMOOMILKMIRANDAMATRIXMULTIPLIERMINT",
			"MMMMMMMMMMM"
		)
	{
		_mint(user_wallet, 10 * 10 ** decimals());
		_grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
	}

	function mint(address to, uint256 amount) public onlyRole(MINTER_ROLE) {
		_mint(to, amount);
	}
}
