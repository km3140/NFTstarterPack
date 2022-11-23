// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

contract InitialValue{
  uint256 public amount;  // 👈 0
  string public str;      // 👈 ""
  bool public boo;        // 👈 false
  address public addr;    // 👈 0x0000000000000000000000000000000000000000
}
// solidity에서는 null이나 undefine과 같은 개념이 없다!
// 모든 변수는 값이 할당되어 있는 상태!


//+ 
contract defaultAccess{
  uint256 amount;  // 👈 접근 제한자를 생략하면 기본값은 internal!
}