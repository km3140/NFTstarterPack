// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

contract Father{
  uint256 public fatherMoney = 100;
  function getFatherName() public pure returns(string memory){
    return "KimIll";
  }                              // 👇 중복된 함수
  function getMoney() public view virtual returns(uint256){
    return fatherMoney;
  }
}

contract Mother{
  uint256 public motherMoney = 500;
  function getMotherName() public pure returns(string memory){
    return "Leesol";
  }                              // 👇 중복된 함수
  function getMoney() public view virtual returns(uint256){
    return motherMoney;
  }
}

// contract Son is Father,Mother{

// }
//    👆 위 상태로는 에러가 남, Father와 Mother가 겹치는 함수가 있기 때문에 override로 에러를 해결해줘야한다

contract Son is Father,Mother{            // 👇 겹친 contract들을 인자로 넣어줌
  function getMoney() public view override(Father,Mother) returns(uint256){
    return motherMoney + fatherMoney; // 👈 600
  }
}