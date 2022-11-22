// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

contract Father{
  string public familyName = "Kim";
  string public givenName = "Ill";
  uint256 public money = 100;
                                    // 👇 0.7 부터 public 안 붙어도 됨
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
                      // 👇 Father constructor의 argument
contract Son is Father("Jung"){

  //getGivenName() => Jung

}
// ==     (위와 같음)
contract Son2 is Father{

  constructor() Father("Jung"){

  }

}