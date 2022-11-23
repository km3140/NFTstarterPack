// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

contract returnName{
  
  // 함수 리턴값(변수)의 이름을 명시해 줄 수 있다
  // 리턴값이 많아질 때 구분하기 유용하다
  
  // 리턴명이 없을 때
  function add(uint256 _num1, uint256 _num2) public pure returns(uint256){
    uint256 total = _num1 + _num2;
    return total;
  }
  
  //리턴명이 있을 때
  function add2(uint256 _num1, uint256 _num2) public pure returns(uint256 total){
    total = _num1 + _num2;
    return total;
  }
}