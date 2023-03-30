pragma solidity 0.5.3;

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

contract Challenge is Ownable {
  using SafeMath for uint;

  uint price = 25 finney; //se nao declara "uint public" a varável automaticamente assume a visibilidade como public internal (internal para variáveis e public para funções)
  mapping(address => uint) public balances;

  event NewPrice(uint newPrice);

  function whatAbout(uint myNumber) public payable returns(string memory) {
    require(myNumber <= 10, "Number out of range.");
    require (msg.value == price, "Wrong mesg.value!");
    
    balances[owner] = balances[owner].sum(msg.value);

    doublePrice();

    if(myNumber > 5) {
      return "É maior que cinco!";
    }

    return "É menor ou igual a cinco!";

  }

  function doublePrice() private {
    price = price.mul(2);   

    emit NewPrice(price);
  }

  function withdraw(uint myAmount) onlyOwner public {
    require(balances[owner] >= myAmount, "Insufficient funds.");

    balances[owner] = balances[owner].sub(myAmount);
    owner.transfer(myAmount);
  }
  
  
}