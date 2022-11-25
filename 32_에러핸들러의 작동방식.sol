// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

contract ABC{

  //정확하지 않음

  // CALL이나 델리게이트CALL 을 제외하고는 에러핸들러는 해당 범위 전체를 원상태로 되돌린다? (event emit이 되지 않은 이유?)
  // 에러핸들러가 있는 블록에 진입하면 위 코드가 어떻든 에러핸들러가 무조건 발동됨? 

  event afterUnderbar(string _message);

  modifier module{
    _;
    emit afterUnderbar('function not ended?');
    revert('ERROR!!');
  }

  function returnNow() public module returns(string memory) {
    return "FUNCTION RETURN";
  }

  // 함수 return이 먼저 되서 revert가 실행 안 될 거라고 생각했는데 실행이 됐음
  // returnNow를 실행했는데 이벤트가 emit이 안됨은 물론이고 revert가 떴음
}



