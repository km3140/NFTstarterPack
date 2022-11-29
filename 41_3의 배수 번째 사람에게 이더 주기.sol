// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

/*
  1. 1이더만 내야한다
  2. 중복 참여 불가 (단, 누군가 적립금을 수령하면 초기화)
  3. 관리자만 적립된 이더를 볼 수 있다.
  4. 3의 배수 번째 사람에게만 적립된 이더를 준다.
*/

contract MoneyBox{
  event WhoPaid(address indexed sender, uint256 payment);

  address owner;

  mapping (uint256 => mapping(address => bool)) paidMemberList; // 👈 이중 매핑
                                              // 👆 라운드관리(누군가 적립금을 수령하면 초기화)를 위한 장치
  mapping (address => bool) paidMemberList2;
                          // 👆 중복참여를 막기 위한 장치
  uint256 round = 1;

  constructor() {
    owner = msg.sender; // 👈 처음 컨트랙트의 배포자를 owner로 설정
  }

  receive() external payable{
    require(msg.value == 1 ether, "Must be 1 ether."); // 👈 1. 1이더만 내야한다
    require(paidMemberList[round][msg.sender] == false, "Must be a new player in each game."); // 👈 2-1. 중복 참여 불가 
    paidMemberList[round][msg.sender] = true; // 👈 중복참여하지 못하게 위 조건을 통과했으면 true로 바꿔줌 (boolean기본값 false)
    emit WhoPaid(msg.sender,msg.value);
    if(address(this).balance == 3 ether){ // 👈 4. 3의 배수 번째 사람에게만 적립된 이더를 준다.
      (bool sent,) = payable(msg.sender).call{value:address(this).balance}("");
                  // 👆 3의 배수 번째 이더 송신자가 이더를 받을 수 있게 msg.sender를 payable화
      require(sent, "Failed to pay");
      round++; // 👈 2-2. 단, 누군가 적립금을 수령하면 초기화
    }
  }

  function checkRound() public view returns(uint256){
    return round;
  }

  function checkValue() public view returns(uint256){
    require(msg.sender == owner, "Only Owner can check the value"); // 👈 3. 관리자만 적립된 이더를 볼 수 있다.
    return address(this).balance;
  }       // 👆 스마트 컨트랙의 주소화, address(this) = 주소추출(현재컨트랙의인스턴스)

}


/*
  Goerli 테스트넷에 배포해보기 (입금 이더는 0.0001eth로 조정함)
  https://goerli.etherscan.io/address/0x408054eAFa571cF2c4555BC05d8f27ab5414DcB9
*/