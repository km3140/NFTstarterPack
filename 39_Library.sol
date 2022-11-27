// SPDX-License-Identifier: GPL-3.0 

pragma solidity >=0.7.0 <0.9.0;

/*
  library: 기존에 만들던 스마트 컨트랙과 다른 종류의 스마트 컨트랙
  
  라이브러리를 사용함으로써 이점과 제한사항이 있다.
  이점
    1. 재사용: 블록체인에 라이브러리가 배포되면, 다른 스마트 컨트랙들에 적용가능.
    2. 가스 소비 감소: 라이브러리를 통해 코드의 재사용성을 높여줌으로써, 코드의 길이가 줄어들고 가스비를 아낄 수 있음
                      가스는 스마트 컨트랙의 사이즈/길이에 영향을 받기 때문
    3. 데이터 타입 적용: 라이브러리의 기능들은 데이터 타입에 적용할 수 있다, 간편하게 사용가능 (메소드처럼?)

  제한사항
    1. fallback 함수 불가: fallback 함수를 라이브러리 안에 정의할 수 없다, 즉 이더를 가질 수 없다
    2. 상속 불가
    3. payable 함수 정의 불가
*/

// overflow를 막아주는 함수(라이브러리)를 통한 예제
// 0.8 이전에는 overflow가 발생했었음
// 0.8 이후부터는 솔리디티에서 자체적으로 오류를 일으킴
library SafeMath{
  // 👆 라이브러리 선언
  function add(uint8 a, uint8 b) internal pure returns (uint8){
    require(a+b>=a, "SafeMath: addition overflow"); // 👈 overflow 체크 로직
    return a+b;
  }
}

contract LIBRARY{
  using SafeMath for uint8; // 👈 SafeMath 라이브러리 호출 후 uint8에 적용
  uint8 public a;

  function becomeOverflow(uint8 _num1, uint8 _num2) public {
    a = _num1.add(_num2); // 👈 a = SafeMath.add(_num1, _num2);
      // 👆 메소드처럼 사용, _num1이 자동으로 add함수의 첫번째 인자로 들어가는듯
  }
}