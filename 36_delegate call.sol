// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

//  Call vs Delegate call

/*
  Delegate call 특징
    1. msg.sender가 본래의 스마트컨트랙 사용자(EOA)를 나타낸다
    2. delegate call이 정의된 스마트 컨트랙(즉, caller)이 외부 컨트랙의 함수들을 마치 자신의 것 처럼 사용(실질적인 값을 caller에 저장)
  
  Delegate call 사용조건
    외부 스마트컨트랙과 caller 스마트컨트랙은 같은 변수를 갖고 있어야 한다.
    
  Delegate call이 왜 필요한가?
    스마트 컨트랙을 upgradable하게 작성할 수 있기 때문!
    변경사항이 있을 때 컨트랙을 항상 새로 쓸 수 없기 때문에 한 컨트랙에 중요한 데이터를 모두 저장하고, 다른 컨트랙에 함수를 작성해서 delegate call을 쓴다
*/

contract add{
  uint256 public num = 0; // 👈 callNow를 실행했을 때 1이 늘어남
  event Info(address _addr, uint256 _num);

  function plusOne() public {
    num = num + 1;
    emit Info(msg.sender,num);
  }         // 👆 callNow를 실행했을 때 : CA의 주소
            //    delegateCallNow를 실행했을 때 : EOA의 주소
}

contract caller{
  uint256 public num = 0; // 👈 delegateCallNow를 실행했을 때 1이 늘어남

  function callNow(address _contractAddr) public payable{
    (bool success,) = _contractAddr.call(abi.encodeWithSignature("plusOne()"));
    require(success,"failed to transfer ether");
  }
  function delegateCallNow(address _contractAddr) public payable{
    (bool success,) = _contractAddr.delegatecall(abi.encodeWithSignature("plusOne()"));
    require(success,"failed to transfer ether");
  }
}
