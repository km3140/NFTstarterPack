// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

// continue : 실행 중단하고 다음 반복문 실행
// break : loop를 끝냄 (탈출)

contract ConBrek{
  event CountryIndexName(uint256 indexed _index, string _name);
  string[] private countryList = ['south korea','north korea', 'usa', 'china', 'japan'];

  function useContinue() public{
    for(uint i; i < countryList.length; i++){
      if(i % 2 == 1){ // 👈 is odd?
        continue; // 👈 홀수는 출력 안하고 넘김
      }
      emit CountryIndexName(i, countryList[i]);
    }
  }

  function useBreak() public{
    for(uint i; i < countryList.length; i++){
      if(i == 3){ // 👈 i가 3일 때
        break; // 👈 for문 탈출 => usa까지 출력됨
      }
      emit CountryIndexName(i, countryList[i]);
    }
  }

}