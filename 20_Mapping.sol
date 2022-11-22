// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;


// 키와 키의 값을 쌍으로 저장하는 타입
// .length 사용 못함
// 몇 개의 키-값 쌍이 담겨 있는지 알 수 없으므로 별도의 변수를 만들어 관리해야함
// 존재하지 않는 키에 접근하면 0 반환

contract Mapping{

  mapping(address => uint) balance;
  // 👆 mapping(키의 타입 => 키 값의 타입)매핑이름;  으로 선언

  function setBalance(address _adr, uint _n) public{
    balance[_adr] = _n; // 👈 balance에 _arr=>_n 쌍 추가, _arr키가 이미 있다면 값 수정
  }

  function getBalance(address _adr) view public returns(uint256){
    return balance[_adr]; // 👈 _adr에 해당하는 uint 반환
  }
}
