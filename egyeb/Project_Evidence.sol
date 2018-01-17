pragma solidity ^0.4.16;


/**
 * @title Ownable
 * @dev The Ownable contract has an owner address, and provides basic authorization control
 * functions, this simplifies the implementation of "user permissions".
 */
contract Ownable {
  address public owner;
  /**
   * @dev The Ownable constructor sets the original `owner` of the contract to the sender
   * account.
   */
  function Ownable() public {
    owner = msg.sender;
  }
  /**
   * @dev Throws if called by any account other than the owner.
   */
  modifier onlyOwner(){
    require(msg.sender == owner);
    _;
  }
  /**
   * @dev Allows the current owner to transfer control of the contract to a newOwner.
   * @param newOwner The address to transfer ownership to.
   */
  function transferOwnership(address newOwner) onlyOwner public {
    if (newOwner != address(0)) {
      owner = newOwner;
    }
  }
}

/**
 * @title SafeMath
 * @dev Math operations with safety checks that throw on error
 */
library SafeMath {
  function mul(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a * b;
    assert(a == 0 || c / a == b);
    return c;
  }

  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    // assert(b > 0); // Solidity automatically throws when dividing by 0
    uint256 c = a / b;
    // assert(a == b * c + a % b); // There is no case in which this doesn't hold
    return c;
  }

  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    assert(b <= a);
    return a - b;
  }

  function add(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    assert(c >= a);
    return c;
  }
}



contract evidenceContract is Ownable{
    

    struct record {

      uint256 number;  // number of users
      string url; // url , sent by the user
      string _hash; // we get from the server/archivum, its also the nam of the object in the storage
      uint256 timestamp; // when we get the datas
      uint256 timelimit; // when we want to hold the datas in the storage


    }

    uint256  public rate;   // how much time we give for 1 wei or ether
    uint public number = 0;

    

    address public myAddress = this;

    mapping (address => record) public theList;

    function getCurrentTimestamp() internal returns (uint256) {
        return now;
    }
    
    function newUser(address user_address, uint user_value,  string url, string _hash) onlyOwner  {
     
     uint256 timestamp = now;
     uint256 timelimit;

     timelimit = user_value * rate;
     number++;
     

     theList[msg.sender] = record(number,_hash,url,timestamp,timelimit);

       
    }


    



   




    


 




    





}