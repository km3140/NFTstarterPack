// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

/*
  call : 로우레벨 함수

  call 사용법
    0.7 이전
    컨트랙트주소.call.value(msg.value).gas(지정할가스값)
    0.7 이후
    (bool 성공여부, bytes memory 부른함수의byte화된return값) = 컨트랙트주소.call{value: msg.value, gas: 지정할가스량}(abi.encodeWithSignature("부를함수이름(인자타입1,인자타입2)", 인자값1,인자값2))

  call 특징
    1. 송금할 때 씀
    2. 외부 스마트 컨트랙 함수를 부를 때 씀
    3. 가변적인 gas
    4. 이스탄불 하드포크 이후 gas 가격 상승에 따른 call 사용 권장 / send transfer는 max 2300
    5. 재진입 공격 위험이 있기에 Checks_Effects_Interactions_pattern을 사용
*/

contract add{
  event JustFallback(string _str);
  event JustReceive(string _str);
  function addNumber(uint256 _num1, uint256 _num2) public pure returns(uint256){
    return _num1+_num2;
  }
  fallback() external payable{
    emit JustFallback("JustFallback is called");
  }
  receive() external payable{
    emit JustReceive("JustReceive is called");
  }
}

contract caller{
  event calledFunction(bool _success, bytes _output);

  // 1. 송금하기
  function transferEther(address payable _to) public payable{
    (bool success,) = _to.call{value: msg.value}("");
    require(success,"failed to transfer ether");//👆 ("") 생략하면 안됨
  }

  // 2. 외부 스마트 컨트랙 함수 부르기 
  function callMethod(address _contractAddr, uint256 _num1, uint256 _num2) public {                             // 👇 uint(x) uint256(o) 256 명시!
    (bool success, bytes memory outputFromCalledFunction) = _contractAddr.call(abi.encodeWithSignature("addNumber(uint256,uint256)", _num1, _num2));
                                                                            // 👆  ABI란?
                                                                            //      이더리움 환경 안에서 스마트 컨트랙을 상호작용 시키는 표준
                                                                            //      abi.encodeWithSignature() 외부 컨트랙의 function을 부른다
    require(success, "failed to transfer ether");
    emit calledFunction(success, outputFromCalledFunction);
  }

  // 3. 외부 스마트 컨트랙트에 없는 함수 부르면서 이더 보내기 
  function callMethod2(address _contractAddr) public payable {
    (bool success, bytes memory outputFromCalledFunction) = _contractAddr.call{value:msg.value}(abi.encodeWithSignature("Nothing()")); // 👈 없는 함수를 불렀기 때문에 add 컨트랙트의 fallback이 발동됨!
    require(success, "failed to transfer ether");
    emit calledFunction(success, outputFromCalledFunction);
  }

  // 4. 외부 스마트 컨트랙트에 이더만 보내기
  function callMethod3(address _contractAddr) public payable {
    (bool success,) = _contractAddr.call{value:msg.value}(""); // 👈 이더만 보냈기 때문에 add 컨트랙트의 receive 발동
    require(success, "failed to transfer ether");
    emit calledFunction(success, bytes("404"));
  }
  // 4번처럼 함수 써서 보내는 것 말고도 remix에 Low level interactions 부분을 써서 account로 이더를 보낼 수 있다
}

