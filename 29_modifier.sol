// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

//   modifier 키워드로 생성한 함수를 함수변경자라고 함
//   modifier를 정의하고 다른 함수에 적용한다 (이름 처럼 모듈같은 느낌인 듯)
//   modifier정의 단계에서 _; 를 통해 modifier를 적용한 함수 몸체의 시작점을 설정할 수 있다
//   modifier를 쓰면 해당 modifier를 적용하는 여러 함수에 한번에 변경사항을 적용할 수 있다


// 인자가 없을 때
contract Modifier{
                  // 👇 modifier에 필요한 인자가 없다면 소괄호 생략
  modifier checkAdults{
    revert("You are not allowed to pay for it");
    _; // 👈 이 modifier를 적용하는 함수가 시작하는 부분, 없으면 오류
  }


// function buyCigarette() pure public checkAdults returns(string memory) {
//   revert("You are not allowed to pay for it");
//   return "Here is Cigarette";
// }  
// 👆👇 위아래 같음
  function buyCigarette() pure public checkAdults returns(string memory) {
    return "Here is Cigarette";
  }                                 // 👇👆 여러곳에 적용
  function buyBeer() pure public checkAdults returns(string memory) {
    return "Here is Beer";
  }
}

// 인자가 있을 때
contract Modifier2{

  modifier checkAdults(uint _age){
    require(_age>19,"You are not allowed to pay for it");
    _;
  }

  function buyCigarette(uint _age) pure public checkAdults(_age) returns(string memory) {
    return "Here is Cigarette";                           // 👆 modifier의 인자
  }                                                 // 👇 modifier의 인자
  function buyBeer(uint _age) pure public checkAdults(_age) returns(string memory) {
    return "Here is Beer";
  }
}
