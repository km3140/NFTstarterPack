// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.1;

// 오픈제플린에 UUPD라는 프록시 방식이 있다
// proxy를 통해 직접 구현하는 것 보다 그냥 가져다 쓰는 게 state collision이나 관리자 문제가 없다
// UUPS를 사용하여 배포하면 remix에서 자동으로 인식함, deploy 밑에 deploy with proxy, upgrade with proxy
  // deploy with proxy : 최초 배포할 때 (implement contract 배포, ERC1967 proxy contract 배포, 두가지 트렌잭션이 발생함)
  // upgrade with proxy : 프록시 업그레이드 할 때 (new implement contract 배포, new implement 주소로 proxy contract update, 두가지 트렌잭션이 발생함)
// UUPS 사용 시 기본적으로 구성할 것
  // Initializable, UUPSUpgradeable, OwnableUpgradeable 상속
  // initialize 함수 생성(안에 __ownable_init())
  // _authorizeUpgrade 함수 생성


import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract ProxyContractV1 is Initializable, UUPSUpgradeable, OwnableUpgradeable{
  uint256 public count;
  
  // constructor를 function으로 바꾼 형태 (배포 후 실행해줌)
  function initialize() public initializer{
    count = 10;
    __Ownable_init();
  }

  function _authorizeUpgrade(address) internal override onlyOwner {}

  //              👇 proxy contract에서 호출하기 때문에 붙여주는듯
  function inc() external {
    count++;
  }
}

// 빼기 함수를 추가
contract ProxyContractV2 is ProxyContractV1{
  function dec() external{
    count --;
  }
}