// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

// 상태 변수(State Variables) : 값이 storage에 영구적으로 저장되는 변수 

// 지역 변수(Local Variables) : 함수가 실행될 때까지 값이 존재하는 변수.

// 전역 변수(Global Variables ) : 블록체인에 관한 정보를 제공하는 미리 정의된 변수


contract DataType {
  uint public state_var;
  // 👆 상태변수
  function getResult() public view returns(uint){
    uint local_var = 1; // 👈 지역 변수
    return block.number + local_var; 
  }       // 👆 전역 변수
}