// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

contract Function{
  // 함수 선언 키워드
  //   function 함수명(매개변수) [public|private|external|internal] [view|pure] [payable] [modifier] [returns()] { }
  //                         //  👆 접근제어자                      👆상태제어자 👆payable제어자 👆함수변경자
  // ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
  
  // 1.접근제어자 [public|private|external|internal]
  //   가시성이란 함수 또는 변수를 호출할 수 있는 범위를 말하는데, 가시성을 지정할 때 사용하는 키워드임 (visibility modifier)
  //   함수에 없으면 오류남
  //   ▪ public : 모든 곳에서 호출 가능
  //   ▪ private : 함수를 정의한 콘트랙트 내에서만 호출 가능. 상속받은 콘트랙트에서 호출 불가
  //   ▪ internal : 함수를 정의한 콘트랙트와 상속받은 콘트랙트에서 모두 호출 가능
  //   ▪ external : 트랜젹션에 의한 외부 호출만 가능. 정의한 or 상속받은 콘트랙트에서 호출 불가
  //                 👆 this.함수이름(external인) 처럼 this.을 통해 내부에서도 호출 가능 (internal은 this로 호출 불가)
  //                 ❓ this : 호출이 이루어진 계약의 인스턴스. (동일한 계약의 여러 인스턴스를 가질 수 있음)
  //                     👆 this가 해당 콘트랙트의 instance이기 때문에 외부에서 호출되는 것 처럼 되는 건가??


  // 2.상태제어자 [view|pure]
  //   view 키워드와 pure 키워드가 있음
  //   이 키워드로 함수의 기능이 데이터 조회임을 명시, 반드시 return을 명시해주어야 함
  //   데이터의 상태를 변경하는 함수에 이 키워드를 사용하면 에러가 발생함
  //   pure하다 : 동일한 입력값을 주었을 때 항상 같은 값이 조회된다
  //     👆 함수에 상태변수를 사용하면 그 함수는 pure할 수 없게 됨, 그러므로
  //         view : 상태 접근 허용, pure : 상태 접근 불가능
    
  
  // 3.함수변경자 [modifier]
  //   modifier 키워드로 생성한 함수를 함수변경자라고 함
  //   modifier를 정의하고 다른 함수에 적용한다 (이름 처럼 모듈같은 느낌인 듯)
  //   modifier정의 단계에서 _; 를 통해 modifier를 적용한 함수의 시작점을 설정할 수 있다
  //   함수변경자는 에러핸들링을 이해한 후 제대로 사용할 수 있다고 하니 이후 구체적으로 다루겠습니다~

  // 4.payable 제어자
  //   가상화폐로의 접근을 가능하게 하는 키워드, 함수 이외에도 주소, 생성자에 붙여서 사용
  //   payable() 함수를 통해 일시적으로 payable하게 할 수도 있음

}