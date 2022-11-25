// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

contract MobileBanking{

  // (address).balance = 해당 주소의 이더 잔액
  // msg.sender = 컨트랙을 실행하는 사람의 주소
  // msg.sender.balance = 컨트랙을 실행하는 사람의 이더잔액

  event SendInfo(address _msgSender, uint256 _currentValue);
  event MyCurrentValue(address _msgSender, uint256 _value);
  event CurrentValueOfSomeone(address _msgSender, address _to, uint256 _value);

  function sendEther(address payable _to) public payable{
    require(msg.sender.balance>=msg.value, "Your balance is not enough");
    //       👆 컨트랙을 실행하는 사람(송금자)의 잔액이 기입한 이더량보다 큰지 검사
    _to.transfer(msg.value);
    emit SendInfo(msg.sender,msg.sender.balance);
  }// 👆 송금자의 주소, 송금자의 잔액 로그

  function checkValueNow() public{
    emit MyCurrentValue(msg.sender, msg.sender.balance);
  }// 👆 컨트랙을 실행하는 사람의 주소와 잔액 로그

  function checkUserMoney(address _to) public{
    emit CurrentValueOfSomeone(msg.sender, _to, _to.balance);
  }// 👆 컨트랙을 실행하는 사람의 주소, 잔액 확인할 주소, 확인할 주소의 잔액 로그
}


