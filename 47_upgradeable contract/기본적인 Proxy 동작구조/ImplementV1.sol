// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.1;

contract ImpleV1{
  address public implementation; // 순서를 proxy와
  uint public x; // 같게 해줘야함
  // 아니면 변수 값이 바뀌어서 들어간다고 함 (state collision?)

  function inc() external{
    x += 1;
  }
}