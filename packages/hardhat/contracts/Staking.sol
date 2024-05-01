// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./StakedToken.sol";
import "./Token.sol";
import "./Custodian.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract StakingContract is AccessControl {
	Token public token;
	StakedToken public stakedToken;
	Custodian public custodian;
	uint16 public constant YIELD_PERCENTAGE = 20;

	constructor(Token _token, StakedToken _stakedToken, Custodian _custodian) {
		token = _token;
		stakedToken = _stakedToken;
		custodian = _custodian;
		_grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
	}

	function stake(uint256 amount) external {
		require(
			token.transferFrom(msg.sender, address(custodian), amount),
			"Transfer failed"
		);
		stakedToken.mint(msg.sender, amount);
	}

	function unstake(uint256 amount) external {
		require(
			stakedToken.transferFrom(msg.sender, address(this), amount),
			"Transfer failed"
		);
		stakedToken.burn(address(this), amount);

		uint256 yieldAmount = (amount * YIELD_PERCENTAGE) / 100;
		uint256 totalAmount = amount + yieldAmount;

		require(
			token.balanceOf(address(custodian)) >= totalAmount,
			"Insufficient funds"
		);

		custodian.sendTokens(msg.sender, totalAmount);
	}
}
