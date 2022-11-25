// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

// constructor에 payable 적용해보기 => 배포 시 컨트랙트 주소에 이더 넣을 수 있음
contract MobileBanking{

  constructor() payable{ // 👈 배포할 때 msg.value 입력하면 컨트랙트 주소로 들어감!

  }

  event CurrentValueOfSomeone(address _msgSender, address _to, uint256 _value);

  //                      👇 컨트랙트 주소 넣고 실행해보면
  function checkUserMoney(address _to) public{
    emit CurrentValueOfSomeone(msg.sender, _to, _to.balance);
  } //                                          👆 배포할 때 넣은 msg.value가 컨트랙트의 잔액으로 나온다
}


// 배포한 사람의 권한 만들기
contract MobileBanking2{

  address owner;
  constructor() payable{ // 👈 최초 실행 될 때 owner에 배포하는 사람의 주소를 넣음 => 배포하는 사람이 owner
    owner = msg.sender;
  }

  event SendInfo(address _msgSender, uint256 _currentValue);
  event MyCurrentValue(address _msgSender, uint256 _value);
  event CurrentValueOfSomeone(address _msgSender, address _to, uint256 _value);

  modifier onlyOwner{ // 👈 권한 체크 로직을 모듈화 해서 모든 함수에 적용 => 모든 함수를 배포자만 사용할 수 있게 함
    require(msg.sender == owner, "Only Owner");
    _;
  }

  function sendEther(address payable _to) public payable onlyOwner{
    require(msg.sender.balance>=msg.value, "Your balance is not enough");
    _to.transfer(msg.value);
    emit SendInfo(msg.sender,msg.sender.balance);
  }

  function checkValueNow() public onlyOwner{
    emit MyCurrentValue(msg.sender, msg.sender.balance);
  }

  function checkUserMoney(address _to) public onlyOwner{
    emit CurrentValueOfSomeone(msg.sender, _to, _to.balance);
  }
}
