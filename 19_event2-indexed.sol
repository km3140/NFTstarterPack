// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

// 웹 애플리케이션과 연동될 때 event 값을 웹으로 읽어올 수 있음
// event가 많으면 event를 필터링 하기 위해서 indexed를 사용함

contract Indexed{
                              //  참조타입은 함수 내부에서 사용할 시 저장공간을 명시해줘야함
                              //   memory로 저장하면 해당 값을 함수가 끝나기 전까지 잠시 저장하겠다는 뜻
                              // 👇 그러나 함수 외부 변수를 선언하면 타입 상관없이 storage에 저장하기 때문에 저장공간 지정 필요 X, 인자에 참조타입이라고 무조건 memory 붙이는 게 아님
  event numTracker(uint256 num, string str);
  event numTracker2(uint256 indexed num, string str);
                          // 👆 indexed
  uint256 num=0;
  function PushEvent(string memory _str) public{
    emit numTracker(num,_str);
    emit numTracker2(num,_str);
  }
// 👆 PushEvent 실행 시 remix로 확인해본 결과 log는 똑같이 나온다
//    하지만 웹 어플리케이션에서 numTracker2는 num을 통해 필터링을 할 수 있음
}