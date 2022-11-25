// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

/*
  storage : 대부분의 변수,함수들이 저장. 영속적으로 저장되어 가스비가 비쌈
  memory : 함수의 파라미터, 리턴값, 레퍼런스 타입이 주로 저장. storage보다 가스비가 싸다
  Calldata : 주로 external function의 파라미터에서 사용됨
  stack : EVM 에서 stack data를 관리할 때 쓰는 영역. 1024MB로 제한적
*/