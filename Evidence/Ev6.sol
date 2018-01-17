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
    using SafeMath for uint256;    

    uint256  public rate = 1;  // how much time we give for 1 wei or ether     
    address public myAddress = this;
    mapping (address => bool) public isMember;
    address[] private userIndex;
    uint256 public numberOfRecord = 0;
    address public multiSig = 0xCD1d44dBdBFdc24C6E25E53282727557a7142f1D; // test multisig1  
    
  
    event Newuser(uint256 number, address indexed who, uint256 indexed timelimit);
    event LogUpdateTimelimit(address indexed who, uint256 indexed timelimit);

    

  struct UserRecord {
      
      bytes32 md5sum; // hash md5sum to check the url sent by the user
      bytes32 _hash; // we get from the server/archivum, its also the name of the object in the storage
      uint256 timelimit; // when we want to hold the datas in the storage
  }

  struct Member {
    UserRecord[] userrecord;
     }

  mapping(address => Member) members;
  
 

   function addMember(address user_address, bytes32 md5sum, bytes32 _hash, uint timelimit) onlyOwner public returns(bool success) {
   
    require (user_address != 0x0 || user_address != myAddress);
    require (timelimit > now);
    
    members[user_address].userrecord[].md5sum = md5sum;
    members[user_address].userrecord[]._hash = _hash;
    members[user_address].userrecord[].timelimit = timelimit;
    isMember[user_address] = true;  
    numberOfRecord++;
    Newuser(numberOfRecord,user_address,timelimit);    
    return true;
  }

  function getMemberNumberofRecords(address user_address) public constant returns(uint numberofrecords) {
    return   members[user_address].userrecord.length;
  }   
   function getMember(address user_address) public constant returns(bytes32 md5sum, bytes32 _hash, uint timelimit) {
    return(
    members[user_address].userrecord[0].md5sum,
    members[user_address].userrecord[0]._hash,
    members[user_address].userrecord[0].timelimit );
  }   
 function updateTimelimit(address user_address, uint timelimit) 
    public
    returns(bool success) 
  {
    require(isMember[user_address]); 
    members[user_address].userrecord[0].timelimit = timelimit;
    LogUpdateTimelimit(user_address,timelimit);
    return true;
  }

  function evidenceContract() public { 
          
    }    

  function buy(address user_address, uint256 amount) onlyMember internal {
   
       // Calculate 
    uint256 timeUnit = amount.mul(rate);  
    //uint256 newtimelimit = now.add(timeUnit);

    members[user_address].userrecord[0].timelimit = 1510514275 +timeUnit;    
    multiSig.transfer(this.balance); // better in case any other ether ends up here
    }
  
  function () public payable {
    buy(msg.sender, msg.value);
 }

 modifier onlyMember() {
    require (isMember[msg.sender]);
       _;
  }
 

}