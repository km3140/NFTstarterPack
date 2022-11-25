// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;


contract Father{
  event FatherName(string name);
  function who() public virtual{
    emit FatherName("KimJungEun");
  }
}

contract Mother{
  event MotherName(string name);
  function who() public virtual{
    emit MotherName("LeeSolJu");
  }
}
//                      👇 중복 시 super.who()는 뒤에 나오는 콘트랙트로 결정됨 (덮어씀?)
contract Son is Father, Mother{
  event SonName(string name);
  function who() public override(Father,Mother){
    super.who(); // 👉 MotherName
  }
}
//                      👇 
contract Son2 is Mother, Father{
  event SonName(string name);
  function who() public override(Father,Mother){
    super.who(); // 👉 FatherName
  }
}
