// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

contract IfForWhileDowhile{
  // 1.조건문
    function isEven(uint a) public pure returns(bool){
      if (a % 2 == 0) {
        // 👆 조건
        return true; // 나머지가 0 (짝수)면 실행
      }else if(a == 99){
        return true; //a=99면 실행
      } else{
        return false;// 짝수도 아니고 99도 아니면 실행
      }
    }

  // 2.반복문
    function forSum(uint maxNum) public pure returns(uint){
      uint _sum = 0;
      for (uint i = 0 ; i <= maxNum ; i++){
        // 👆 (i를 uint로 선언 ; i가 maxNum 이하이면 실행 ; 매 실행 끝에 i에 +1)
        _sum += i;
      }
      return _sum; // 0 + 1 + 2 + ... + maxNum-1 + maxNum
    }

    function whileSum(uint maxNum) public pure returns(uint){
      uint _sum = 0;
      uint i = 0;
      while( i <= maxNum){
        _sum += i; // 👆 조건에 맞으면 계속 반복
        i++;
      }
      return _sum;
    }

    function doWhileSum(uint maxNum) public pure returns(uint){
      uint _sum = 0;
      uint i = 0;
      do{
        _sum += i;  // 👈 조건 확인 전에 함수 몸체 한 번 실행
        i++;        //
      }while( i <= maxNum);
      return _sum;
    }

    // 조건문의 모든 함수는 똑같은 결과가 나온다
}