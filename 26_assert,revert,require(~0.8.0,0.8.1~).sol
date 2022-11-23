// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.7.0 <=0.9.0;

//콘트랙트 개발을 하다보면 라이브러리를 쓰는 일이 많은데, 구버전의 라이브러리도 쓸 수 있기에 구버전도 알아둬야함.


contract ErrorHandler{
  /*
    0.4.22~0.7.x
    assert : gas를 소비한 후, 작성한 조건문에 부합하지 않으면 (false일 때) 에러를 발생
    revert : 조건없이 에러를 발생시키고, gas를 환불해줌. 에러메세지 설정 가능
    require : 작성한 조건문에 부합하지 않으면 (false일 때) 에러를 발생시키고, gas를 환불 시켜줌. 에러메세지 설정 가능
  */

  function assertNow() pure public {
    assert(false);  // 👈 3000000gas 소모
  }                 // gas가 많이 들기 때문에 truffle에서 test용도로 쓰임

  function revertNow() pure public {
    revert("error message"); // 👈 21322gas 소모
  }                          // if 와 같이 쓰거나 require를 쓴다 (require = if + revert)

  function requireNow() pure public {
    require(false,"error message of require"); // 👈 21338gas 소모
  }
}

contract ErrorHandlerNowdays{
  /*
    0.8.1~
    assert : gas 환불이 됨
             오직 내부적 에러 테스트 용도, 불변성 체크 용도.
             assert가 에러를 발생시키면, Panic(uint256) 이라는 에러타입의 에러 발생

    assert에러 종류 (Panic type error)
    https://docs.soliditylang.org/en/v0.8.17/control-structures.html#panic-via-assert-and-error-via-require
    0x00: Used for generic compiler inserted panics.
    0x01: If you call assert with an argument that evaluates to false.
    0x11: If an arithmetic operation results in underflow or overflow outside of an unchecked { ... } block.
    0x12; If you divide or modulo by zero (e.g. 5 / 0 or 23 % 0).
    0x21: If you convert a value that is too big or negative into an enum type.
    0x22: If you access a storage byte array that is incorrectly encoded.
    0x31: If you call .pop() on an empty array.
    0x32: If you access an array, bytesN or an array slice at an out-of-bounds or negative index (i.e. x[i] where i >= x.length or i < 0).
    0x41: If you allocate too much memory or create an array that is too large.
    0x51: If you call a zero-initialized variable of internal function type.
  */

  function assertNow() pure public {
    assert(false);  // 👈 21232gas 소모
  }                 // VM error: invalid opcode. => revert
}