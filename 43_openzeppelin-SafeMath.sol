// SPDX-License-Identifier: MIT

pragma solidity ^0.8.1;

// openzeppelin
//   오류, 해킹 등을 방지하기 위해 자주 사용하는 기능들을 안전한 코드로 모아놓은 라이브러리


import "@openzeppelin/contracts/utils/math/SafeMath.sol";
//                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ 오픈제플린 github 디렉토리 구조

contract Math{
  using SafeMath for uint256;
  //    👆 오픈제플린 safemath 라이브러리를 uint256에 할당
  // safemath는 0.8 이전 솔리디티에서는 오버/언더 플로우가 일어날 수 있어서 만들어진 라이브러리인데
  // 0.8 이후에서는 솔리디티에서 자동으로 오버/언더 플로우를 잡아줌, 그래서 ^0.8 safemath에서는 unchecked라는 게 추가가 되었음
  // unchecked의 중괄호 안에 있는 코드들은 오버/언더 플로우 검사를 하지 않음, 쓸모 없어보이지만 unchecked를 쓰면 가스비가 절약된다고 함
  uint public a = 5;
  uint public b = 5;
  uint public c = 7;
  uint public d = 0;
  function add() public view returns(uint){
    return a.add(b);
  }

  function sub() public view returns(uint){
    return a.sub(b);
  }

  function sub2() public view returns(uint){
    return a.sub(c); // 언더플로 에러 발생
  }

  function mul() public view returns(uint){
    return a.mul(b);
  }

  function div() public view returns(uint){
    return a.div(b); // devide 0 에러 발생
  }
}