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



contract evidenceContract is Ownable{     

    uint256  public rate = 1;  // how much time we give for 1 wei or ether     
    address public myAddress = this;
    //mapping (address => bool) public isMember;
    address[] private userIndex;
    
  

    event Newuser(address indexed who, uint256 indexed timelimit, uint index);
    event LogUpdateTimelimit(address indexed who, uint256 indexed timelimit, uint index);

    

  struct UserRecord {
      
      bytes32 md5sum; // hash md5sum to check the url sent by the user
      bytes32 _hash; // we get from the server/archivum, its also the name of the object in the storage
      uint256 timelimit; // when we want to hold the datas in the storage
      uint256 index;
  }

  struct Member {
    UserRecord userrecord;
     }

  mapping(address => Member) members;
 

   function isMember(address user_address)
    public 
    constant
    returns(bool isIndeed) 
  {
    if(userIndex.length == 0) return false;
    return (userIndex[Member[user_address].index] == user_address);
    return (userIndex[userStructs[userAddress].index] == userAddress);
  }
  
 

  function addMember(address user_address, bytes32 md5sum, bytes32 _hash, uint timelimit) onlyOwner public returns(uint index) {
   
    require (user_address != 0x0 || user_address != myAddress);
    require (timelimit > now);
    
    members[user_address].userrecord.md5sum = md5sum;
    members[user_address].userrecord._hash = _hash;
    members[user_address].userrecord.timelimit = timelimit;
    //isMember[user_address] = true;    
    Newuser(user_address,timelimit, index );    
    return userIndex.length-1;
  }

  function getMember(address user_address) public constant returns(bytes32 md5sum, bytes32 _hash, uint timelimit, uint index) {
    return(
    members[user_address].userrecord.md5sum,
    members[user_address].userrecord._hash,
    members[user_address].userrecord.timelimit,
    members[user_address].userrecord.index );
  }   
 function updateTimelimit(address user_address, uint timelimit, uint index) 
    public
    returns(bool success) 
  {
    //require(isMember[user_address]); 
    members[user_address].userrecord.timelimit = timelimit;
    LogUpdateTimelimit(user_address,timelimit, index);
    return true;
  }

  function getUserCount() 
    public
    constant
    returns(uint count)
  {
    return userIndex.length;
  }
 

  function evidenceContract() public {             
    }    

//  

 modifier onlyMember() {
    require(isMember[msg.sender]);
       _;
  }
 

}