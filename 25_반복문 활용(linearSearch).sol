// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

contract LinearSearch{
  event CountryIndexName(uint256 indexed _index, string _name);
  string[] private countryList = ['south korea','north korea', 'usa', 'china', 'japan'];

  function linearSearch(string memory _search) public view returns(uint256, string memory){
    for(uint i; i < countryList.length ; i++){
      if(keccak256(bytes(_search)) == keccak256(bytes(countryList[i]))){ // 👈 솔리디티에서는 다른 언어들 처럼 string을 비교하지 못함
        return (i,countryList[i]);                                       //     각 string을 byte화 후 해시 해 준 다음 비교해야 함
      }
    }
    return(0,'Not Found');
  }

}
