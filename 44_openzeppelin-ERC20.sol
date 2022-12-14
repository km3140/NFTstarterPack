// SPDX-License-Identifier: MIT

pragma solidity ^0.8.1;

// 오픈제플린을 통해 ERC-20 토큰 발행하기

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract myToken is ERC20{
//            👇 발행할 토큰 이름  👇 발행할 토큰 심볼    👇erc20 contract의 constructor
  constructor(string memory name, string memory symbol) ERC20(name, symbol){
  //                  👇 10000개 발행
    _mint(msg.sender, 10000 * (10**18));
  // 👆erc20의 함수 실행        👆 decimals
  }
}