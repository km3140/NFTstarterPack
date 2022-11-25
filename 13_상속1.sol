// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

// 상속 하는 법 : contract 상속 받을 컨트랙트 is 상속해 줄 컨트랙트

contract Father{
  string public familyName = "Kim";
  string public givenName = "Ill";
  uint256 public money = 100;
  constructor(string memory _givenName) {
    givenName = _givenName;
  }

  function getFamilyName() public view returns(string memory){
    return familyName;
  }
  function getGivenName() view public returns(string memory){
    return givenName;
  }
  function getMoney() view public returns(uint256){
    return money;
  }
}
          // 👇is키워드   👇 Father constructor의 argument
contract Son is Father("Jung"){

  //getGivenName() => Jung

}
// ==     (위와 같음)
contract Son2 is Father{

  constructor() Father("Jung"){

  }

}