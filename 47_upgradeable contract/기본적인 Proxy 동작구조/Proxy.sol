// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.1;

// 진행과정
  // 모두 배포
  // setImplementation으로 v1설정
  // v1의 함수 실행 => input값 copy
  // proxy에 calldata로 복사한 input값 전달
  // proxy에 fallback에서 _delegate 실행 => v1호출
  // setImplementation으로 v2설정
  // v2의 함수 실행 => input값 copy
  // proxy에 calldata로 복사한 input값 전달
  // proxy에 fallback에서 _delegate 실행 => v2호출

// 오픈제플린의 proxy와 같음

contract Proxy{
  // 업그레이드할 컨트랙 주소
  address public implementation; 

  uint public x;


  // 호출할 컨트랙트 변경하기 (업그레이드)
  function setImplementation(address _implementation) external{
    implementation = _implementation;
  }

  // implement 호출
  function _delegate(address _implementation) internal{
    assembly{
      calldatacopy(0,0, calldatasize())

      let result := delegatecall(gas(), _implementation, 0, calldatasize(), 0, 0)

      returndatacopy(0, 0, returndatasize())
      switch result
      case 0{
        revert(0, returndatasize())
      }
      default{
        return (0, returndatasize())
      }
    }
  }

  // fallback => _delegate
  fallback() external payable{
    _delegate(implementation);
  }
}