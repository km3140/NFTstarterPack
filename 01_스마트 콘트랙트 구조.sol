// SPDX-License-Identifier: GPL-3.0
// 👆 0.6.8 부터 도입
//    오픈되어있는 소스코드의 저작권 문제를 해결하기 위해 명시
//    없으면 오류가 나지만 컴파일러가 라이센서를 확인하지는 않음 => UNLICENSE 부분에 아무거나 써도 에러 안 남

pragma solidity 0.8.17;
// 👆 컴파일러 버전 명시

contract HelloWorld { // 👈 JS의 class와 비슷하다
  
  string public text; 

  constructor() { // 👈 constructor 또한 JS와 비슷
                  //     콘트랙트 생성 시 한 번만 실행, 다시 호출할 수 없음
                  //     주로 초기화 할 때 사용
    text = "Hello, World!";
  }

  function setName(string memory _text) public{ // 👈 트랜젝션이 발생함 (가스피 있음)
    text = _text;
  }

  function run() public view returns(string memory){ // 👈 조회만 하는 함수 (가스피 없음)
    return text;                         // 👆 참조 타입의 특성을 갖는 데이터를 전달하거나 반환할 때는 어디에 저장할지 명시해야 함
  }
}



//+ GPL-3.0
// 자유 소프트웨어 재단(FSF)과 이 재단의 GNU 프로젝트에 의해 배포되며 GNU 소프트웨어에 적용되는 공개 소프트웨어의 대표적인 라이선스 체계. GNU GPL이라고도 하며, 저작권(copyright)의 반대라는 의미로 카피레프트(copyleft)라고도 한다. 라이선스 사용료나 사용상의 제약 조건을 자유롭게 하여 소프트웨어 유통을 활성화하기 위한 의도에서 출발한 것으로 GNU 소프트웨어로 공개되는 원시 부호는 누구나 변경 또는 일반 공중 라이선스(GPL)로 재배포하고, 이를 이용하여 상업적 웹 사이트를 구축할 수도 있다. 그렇다고 저작권의 완전한 포기를 의미하는 것은 아니어서 GPL의 기본 원칙과 공개하는 측이 정의한 바를 충실하게 따르도록 되어 있다. 1990년대에 마련된 GPL V2.0에 이어 2005년에 V3.0이 발표되었다.
// GPL 버전 3은 2007년 6월 29일에 발표되었다.
// 2005년 후반에 자유 소프트웨어 재단에서 GPL의 세번째 판을 개발할 것이라고 발표했다
// 바뀐 점 중에서 가장 중요한 4가지를 말하자면, 소프트웨어 특허에 대처하는 것, 다른 라이선스와의 호환성, 어떤 부분의 원시 코드와 무엇이 GPL이 포함되어야 하는 원시 코드를 구성하는지와 디지털 제한 관리(Digital Restrictions Management)에 신경을 썼다.