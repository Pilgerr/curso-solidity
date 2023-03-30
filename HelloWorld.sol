pragma solidity 0.5.3;

/* The SafeMath library does this and that...*/
library SafeMath {
  function sum(uint a, uint b) internal pure returns(uint) {
    uint c = a + b;
    require(c >= a, "Sum Overflow!");
    
    return c;
  }

  function sub(uint a, uint b) internal pure returns(uint) {
    require(b <=a, "Sub Underflow!");
    uint c = a - b;
    
    return c;
  }

  function mul(uint a, uint b) internal pure returns(uint) {
    if(a == 0) {
      return 0;
    }

    uint c = a * b;
    require(c / a == b, "Mul Overflow!");

    return c;
    
  }

  function div(uint a, uint b) internal pure returns(uint) {
    uint c = a / b;

    return c;
  }
}

/*
uint8   : 0 a 255
uint16  : 0 a 65.535 (65 mil...)
uint32  : 0 a 4.294.967.295 (4 bilhões...)
uint64  : ...
uint128 : ...
uint256 : ...

Tembém existe o tipo de varável int. Ele alcança METADE destes valores, porque podem ser negativos.
Portanto:

int8    : -128 a 127
uint16  : -32.768 a 32.767

E assim por diante...

*/

contract Ownable {
  address payable public owner;

  event OwnershipTransferred(address newOwner);

  constructor() public {
    owner = msg.sender;
  }

  modifier onlyOwner() { 
    require (msg.sender == owner, "You are not the owner!"); 
    _;
  }

  function transferOwnership(address payable newOwner) onlyOwner public {
    owner = newOwner;

    emit OwnershipTransferred(owner);
  }
}

contract HelloWorld is Ownable {
  using SafeMath for uint; /* previne que variáveis do tipo uint consigam utilizar as funções da
  biblioteca SafeMath*/

  address public owner;
  string public text;
  uint public number;
  address payable public userAddress;
  bool public answer;
  mapping (address => uint) public hasInteracted;
  mapping (address => uint) public balances;

  function setText (string memory myText) onlyOwner public {
    text = myText;
    setInteracted();
  }

  function setNumber (uint myNumber) public payable {
    require (msg.value >= 1 ether, "Insufficient ETH sent.");

    balances[msg.sender] = balances[msg.sender].sum(msg.value);
    number = myNumber;
    setInteracted(); 
  }

  function setUserAddress() public {
    userAddress = msg.sender;
    setInteracted();
  }

  function setAnswer(bool trueOrFalse) public {
    answer = trueOrFalse;
    setInteracted();
  }

  function setInteracted() private {
    hasInteracted[msg.sender] = hasInteracted[msg.sender].sum(1);
  }

  function sendETH (address payable targetAddress) public payable {
    targetAddress.transfer(msg.value);
  }
  
  function withdraw () public {
    require(balances[msg.sender] > 0, "Insufficient funds.");

    uint amount = balances[msg.sender];
    balances[msg.sender] = 0;
    msg.sender.transfer(amount); 
  }
  
  function sumStored(uint num1) public view returns(uint) {
    return num1.sum(number);
  }
  
}

