// SPDX-License-Identifier: GPL-3.0

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

  string[25] public class; // 👈 배열의 길이를 정할 수 있다 
                           // ❗❗❗ 크기가 정해진 배열은 push를 하면 오류가 난다!
                           // 예를 들어 크기가 3인 배열을 선언한다고 치면 내부적으로는 0->0 1->0 2->0 이런식으로 미리 기본값이 들어가는 식이다!, 여기에 push를 하면 배열 길이를 늘리는 셈이니 오류가 나는 건 당연!
}

// 배열의 iteration은 디도스 공격에 취약함, 배열 길이를 50으로 제한해서 사용하거나 매핑을 사용하는 것을 추천.



// +
// 이중배열 만드는 법? string[][]?
// 2차원 배열 시 다른 언어의 순서와 반대임 (예: array[1][2] → array[2][1]) ?
//   T[][k] x;  // k개의 T를 담을 수 있는 가변 배열 x선언
                // 일반 적인 언어에서는 T[k][] 한다.
//         👇바깥쪽배열
// string[][]
//       👆안쪽배열  