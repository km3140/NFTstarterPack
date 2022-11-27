// SPDX-License-Identifier: GPL-3.0 

pragma solidity ^0.8.17;

/*
  interface : 스마트컨트랙 내에서 정의되어야할 필요한 것 (go의 interface와 마찬가지인듯)
    1. interface 내에서 선언하는 함수는 external로 표시
    2. enum, structs 가능
    3. interface 내에서 변수, 생성자 사용 불가
*/

interface ItemInfo { // 👈 ItemInfo라는 interface를 생성
  struct item{
    string name;
    uint256 price;
  }                                                       // 👇 external 꼭 붙여줌
  function addItemInfo(string memory _name, uint256 _price) external; // 👈 함수 몸체 없이 선언 해둠 
  function getItemInfo(uint256 _index) external view returns(item memory);
}
                    // 👇 interface 적용
contract INTERFACE is ItemInfo{
  item[] public itemList; // 👈 자료형은 ItemInfo interface에서 미리 선언해두었기 때문에 바로 사용하면 됨
  function addItemInfo(string memory _name, uint256 _price) override public { // 👈 interface에 등록된 함수가 모두 있어야 함
    itemList.push(item(_name,_price));                    // 👆 인터페이스에 등록된 함수를 선언할 땐 꼭 override
  }
  function getItemInfo(uint256 _index) override public view returns(item memory){ // 👈 interface에 등록된 함수가 모두 있어야 함
    return itemList[_index];
  }
}