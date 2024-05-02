// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./Token.sol";

contract Custodian {
	Token public token;
	address public signers;
	mapping(address => bool) public isSigner;
	mapping(address => bool) public hasApprovedWithdrawal;

	uint256 public requiredSignatures;
	uint256 public approvedSignatures;

	modifier onlySigner() {
		require(isSigner[msg.sender], "Not a signer");
		_;
	}

	constructor(
		Token _token,
		address[] memory _signers,
		uint256 _requiredSignatures
	) {
		token = _token;
		requiredSignatures = _requiredSignatures;

		require(_signers.length > 0, "No signers");

		for (uint256 i = 0; i < _signers.length; i++) {
			require(_signers[i] != address(0), "Invalid signer");

			isSigner[_signers[i]] = true;
			hasApprovedWithdrawal[_signers[i]] = false;
			siigners.push(_signers[i]);
		}
	}

	function deposit(uint256 amount) external {
		require(
			token.transferFrom(msg.sender, address(this), amount),
			"Transfer failed"
		);
	}

	function approveWithdrawal(address recipient) external onlySigner {
		require(!hasApprovedWithdrawal[recipient], "Already approved");
		hasApprovedWithdrawal[recipient] = true;
		approvedSignatures++;
	}

	function sendTokens(address recipient, uint256 amount) external onlySigner {
		require(
			approvedSignatures >= requiredSignatures,
			"Insufficient signatures"
		);
		require(token.transfer(recipient, amount), "Transfer failed");

		approvedSignatures = 0;
		for (uint256 i = 0; i < signers.length; i++) {
			hasApprovedWithdrawal[signers[i]] = false;
		}
	}
}
