// SPDX-License-Identifier: UNLICENSED
// 👆 0.6.8 부터 도입
//    오픈되어있는 소스코드의 저작권 문제를 해결하기 위해 명시
//    없으면 오류가 나지만 컴파일러가 라이센서를 확인하지는 않음

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