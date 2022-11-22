// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

//  새로운 타입을 만들 때 사용

contract Struct{

  struct Person {
    string name;
    uint age;
  }
  // 👆 string 타입의 name, uint 타입의 age를 속성으로 가지는 Person이라는 새로운 타입(구조체)를 생성함

  Person p1; // person 타입의 p1 변수 선언

  function setP(string memory param1, uint param2) public{
    p1 = Person(param1,param2); // 순서대로 param1=>name, param2=>age 할당
  }

  function getP() public view returns(string memory, uint) {
    return (p1.name,p1.age); // p1의 이름과 나이를 반환
  }

  function getP2() public view returns(Person memory) {
    return p1; // p1 자체를 반환
  }

  Person[] public pArr;
  mapping (address=>Person) public pMap;
  // 👆 배열이나 매핑에도 사용 가능

}
