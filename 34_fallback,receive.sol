// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

/*
  0.6이전의 fallback

  fallback 함수 (대비책 함수)

  특징
    1. 무기명 함수, 이름이 없는 함수이다
    2. external 필수, 외부에 의해서만 실행되는 함수임
    3. payable, 이더를 받을 때

  사용이유
    1. 컨트랙트가 이더를 받을 수 있게 한다.
    2. 이더를 받고 난 뒤 대비책을 취할 수 있게 한다.
    3. call 함수로 없는 함수가 불려질 때, 대비책을 취하게 할 수 있다.
    //  👆 call에 대한 설명은 추후 자세하게
*/

/*
  0.6이전 fallback
  function external payable{

  }

  0.6 이후 fallback
    fallback은 0.6이후 receive와 fallback 두 가지의 형태로 나뉘게 되었음

    receive는 순수하게 이더만 받을 때 작동
    fallback은 call에서 함수를 실행하면서 이더를 보낼 때, call로 불려진 함수가 없을 때 대비책으로 작동
    
    send,transfer,함수를 부르지 않은 call 으로 다른 컨트랙트에 이더를 보낼 때 => 받은 컨트랙트에서 receive 실행
    없는 함수를 부른 call => fallback
    함수를 부르고 이더를 보낸 call => payable fallback
    
    fallback 기본형 : 불려진 함수가 컨트랙에 없을 때 발동
    fallback() external{

    }

    payable 적용 시 : 이더를 받고 없는 함수가 불려졌을 때
    fallback external payable {

    }

    이더를 전송 받았을 때 발동되기 때문에 receive는 항상 payable
    receive() external payable{

    }
*/

// +) fallback, receive는 컨트랙트당 하나만 가능

// 예제는 35_call과 함께