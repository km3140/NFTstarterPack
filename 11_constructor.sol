// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

contract A{

  string public name;
  uint256 public age;

  constructor(string memory _name, uint256 _age){ // 👈 콘트랙트가 최초 생성될 때 한 번 실행 (JS와 비슷)
    name = _name;
    age = _age;
  }
  function change(string memory _name, uint256 _age) public{
    name = _name;
    age = _age;
  }
}

contract B{

  A instance = new A("Kim",33); // 👈 constructor에 인자 전달

  function change(string memory _name, uint256 _age) public{
    instance.change(_name, _age);
  }
  function get() public view returns(string memory, uint256){
    return (instance.name(), instance.age());
  }
}