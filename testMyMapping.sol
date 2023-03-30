pragma solidity 0.5.3;

contract TestMyMapping {
	mapping (address => uint) public mappingOf;

	event MappingSet(address from, uint myNumber);

	function setMyMapping(uint myNumber) public {
		mappingOf[msg.sender] = myNumber;

		emit MappingSet(msg.sender, myNumber);
	}
}

// TestMyMapping na Goerli:
// 0xf99EbFE22C31Cd7bd8064918f98624F64F0400bE
// https://goerli.etherscan.io/