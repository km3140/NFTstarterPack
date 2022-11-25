// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

// 이더리움 yellow paper 26p에 무엇을 썼을 때 가스가 얼마 드는지 명시되어있음

// 1 ether = 10^9 Gwei = 10^18 wei
// 0.00000000000000001 ether = 1^-18 ether = 1 wei

contract Gas{
  uint public value1 = 1 ether; // 1000000000000000000
  uint public value2 = 1 gwei;  // 1000000000
  uint public value3 = 1 wei;   // 1
}
//solidity에서 ether, gwei, wei 키워드를 지원함