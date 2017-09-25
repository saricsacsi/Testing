pragma solidity ^0.4.4;

contract Befogadas {

    address[16] public befogadok;

function befogad(uint petId) public returns (uint) {
    require(petId >= 0 && petId <= 15);

    befogadok[petId] = msg.sender;

    return petId;
}

function getBefogado() public returns (address[16]) {
  return befogadok;
}

}