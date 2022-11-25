// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

//솔리디티는 변수1에 변수2를 할당할 때 변수의 참조값을 넣지 않고, 할당 당시 변수2의 상태를 캡쳐한 값을 할당함 


// 참조 타입

contract Ref{

  uint256 num = 1;
  mapping(uint256 => uint256) numMap;
  uint256[] numArray;

  function changeNum(uint256 _num) public{
    num = _num;
  }
  function showNum() public view returns(uint256){
    return num;
  }

  function numMapAdd() public {
    numMap[0]=num; // 👈 맵에 num을 추가
  }
  function showNumMap() public view returns(uint256){
    return numMap[0];
  }

  function NumArrayAdd() public {
    numArray.push(num); // 👈 배열에 num을 추가
  }
  function showNumArray() public view returns(uint256){
    return numArray[0];
  }

  // changeNum()으로 Num을 바꾼다음에 showNumMap(),showNumArray()를 하면 그대로 1이 나옴
}


// 값 타입도 마찬가지

contract Value{

    uint public num=1;
    uint public receiver;

    function numCheck() view public returns(uint){
        return num;
    }
    function input() public {
        receiver = num;
    }
    function changeNum() public{
        num=2; 
    }
    
    // input을 하고 changeNum을 해도 receiver는 1이다

}