// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.17;

contract IfAndFor{
  // 1.조건문
    function isEven(uint a) public pure returns(bool){
      if (a % 2 == 0) {
        // 👆 조건
        return true; // 나머지가 0 (짝수)면 실행
      }else {
        return false;// 나머지가 1 (홀수)면 실행
      }
    }

  // 2.반복문
    function sum(uint maxNum) public pure returns(uint){
      uint _sum = 0;
      for (uint i = 0 ; i <= maxNum ; i++){
        // 👆 (i를 uint로 선언 ; i가 maxNum 이하이면 실행 ; 매 실행 끝에 i에 +1)
        _sum += i;
      }
      return _sum; // 0 + 1 + 2 + ... + maxNum-1 + maxNum
    }

    // for 로도 while의 역할을 할 수 있어서 대부분 for로 대체하는 것 같다
}