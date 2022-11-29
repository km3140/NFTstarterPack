// SPDX-License-Identifier: GPL-3.0

pragma solidity <0.8.0;

/*
  다른 파일에 있는 컨트랙트를 불러와서 상속, 라이브러리, 인스턴스화 하고싶을 때

  기존 로컬 폴더에 있는 파일들을 불러오는 경우는 익숙하니까 생략
  import "./파일이름.sol";
  import "../폴더이름/파일이름.sol";
  등등
*/



/*
  깃허브 컨트랙트를 불러올 때

  import "깃헙주소"
*/
// openzeppelin의 safemath(0.8이전) 컨트랙트를 import하는 예시
import "https://github.com/ConsenSysMesh/openzeppelin-solidity/blob/master/contracts/math/SafeMath.sol";

contract IMPORT {
  using SafeMath for uint256;
  uint256 public a;
  uint256 public maximum = 2**256-1;
  function becomeOverflow(uint256 _num1, uint256 _num2) public {
    a = _num1.add(_num2); // 👈 maximum + 1 하면 오류 발생
  }
}