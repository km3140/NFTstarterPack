// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.17;

contract operator {
  // 1.산술연산자
  // 2.논리연산자
  // 3.비교연산자
  // 4.비트연산자 
  // ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
  // 1. 산술연산자
  //   +,-,*,/ : 사칙연산
  //   % : 나머지 계산

  // 2. 논리연산자
  //   ! : not (논리 부정, 반전시켜줌)
  //   && : AND (논리곱)
  //   || : OR (논리합)
  //   == : equal
  //   != : not equal

  // 3. 비교연산자
  //   <=,<,==,!=,>=,>
  //   생략

  // ❗ 4. 비트연산자
  //   & : AND
  //   | : OR
  //   ^ : XOR
  //   << : 왼쪽 시프트 연산자 (*2^n)
  //   >> : 오른쪽 시프트 연산자 (/2^n)

  //   ex) AND 비트연산 예시
  //     1 & 10
  //     1과 10을 비트연산

  //     1 & 10 => 0001 & 1010
  //     비트연산을 하기 위해 2진수로 변환

  //     0 & 1 = 0
  //     0 & 0 = 0
  //     0 & 1 = 0
  //     1 & 0 = 0
  //     각 자리 숫자끼리 연산

  //     1 & 10 = 0

  //   ex2) 시프트 연산 예시
  //     x * (2 ** y) => x << y
  //     x / (2 ** y) => x >> y
  //     2의 거듭제곱의 곱셈과 나눗셈을 시프트 연산으로 효율적인 표현 가능
}