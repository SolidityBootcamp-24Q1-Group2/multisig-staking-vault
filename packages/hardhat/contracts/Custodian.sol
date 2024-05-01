// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./Token.sol";

contract Custodian {
	Token public token;

	constructor(Token _token) {
		token = _token;
	}

	function sendTokens(address recipient, uint256 amount) external {
		require(token.transfer(recipient, amount), "Transfer failed");
	}
}
