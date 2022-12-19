// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.1;

contract ImpleV1{
  address public implementation; // 순서를 proxy와
  uint public x; // 같게 해줘야함
  // 스토리지는 슬롯 단위로 데이터를 관리하는데, 선언된 순서로 슬롯 번호가 주어진다
  // 순서를 같게 하지 않으면 proxy의 implement에 ImpleV1의 x가 저장되는 상황이 발생함 (storage collision)

  function inc() external{
    x += 1;
  }
}