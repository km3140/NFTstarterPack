// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

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
  }                             // 👇 덮어쓰기 당할 함수에 virtual
  function getMoney() view public virtual returns(uint256){
    return money;
  }
}

contract Son is Father("Jung"){

  uint256 public earning = 100;
                               // 👇 덮어 쓸 함수에 override 키워드
  function getMoney() view public override returns(uint256){
    return  money + earning; // 👈 200
  }

}


// virtual에 override