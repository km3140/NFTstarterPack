// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

contract A{

  uint256 public a =5;
  
  function change(uint256 _value) public {
    a = _value;
  }

}

contract B{

  A instanceName = new A(); // 👈 new 키워드로 A의 인스턴스(복제본)인 instanceName을 만듬

  function get_A() public view returns(uint256) {
    return instanceName.a(); // 👈 인스턴스 내에 있는 변수값을 읽을 땐 함수처럼 ()를 붙이는 것 같다
  }
  function change_A(uint256 _value) public {
    instanceName.change(_value);
  }

}

// A에서의 a와 instanceName.a는 다른 변수다


// 인스턴스화의 단점 :
// contract B에서 A를 인스턴스화 하면 contract B는 contract A자체를 복제해서 가져오는 것이기 때문에 가스비가 많이든다!
// 추가로 이더리움에서는 블록 당 가스의 최댓값이 정해져있어서 가스비가 블록의 제한량을 초과한다면 Error가 발생하고 배포를 실패하게 된다