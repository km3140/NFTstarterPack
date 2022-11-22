// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

// "같은 타입의" 데이터를 연속적으로 저장할 때 사용

contract Array{

  uint[] arrUint = [1,2,3];
  // 👆 arrUint라는 이름의 uint256으로 된 배열을 선언하고 1,2,3을 넣었음

  function add(uint _num) public{
    arrUint.push(_num); // 👈 num 값을 arrUint 배열의 마지막에 추가 / Length +1
  }

  function sub() public {
    arrUint.pop(); // 👈 arrUint 배열의 마지막 요소 제거
  }

  function get(uint _idx) public view returns(uint,uint){
    uint lastItem = arrUint[_idx]; // 👈 인덱스를 사용해서 arrUint 배열 값 가져오기
    return(lastItem,arrUint.length); // 👈 idx번째 값과 arrUint 배열 길이(3) 반환
  }

  function delMiddle() public {
    delete arrUint[1]; // 👈 0->1, 1->0, 2->3 / Length:3
  }

  function adjust(uint256 _idx, uint256 _num) public {
    arrUint[_idx] = _num; // 👈 배열의 _idx번째를 _num으로 수정 (단 _idx <=2, 3보다 크면 오류)
  }

  string[25] public class; // 👈 배열의 크기를 정할 수 있다, 26개 이상 push할 시 오류

}

// 배열의 iteration은 디도스 공격에 취약함, 배열 길이를 50으로 제한해서 사용하거나 매핑을 사용하는 것을 추천.

