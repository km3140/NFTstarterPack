// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.5.0;

//ㅡㅡㅡㅡㅡㅡㅡㅡoUSDT와 oETH 컨트랙트의 일부ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ 
contract IKIP7{
    function balanceOf(address account) public view returns (uint256);
}

contract OriginTokenContract is IKIP7 {

    mapping (address => uint256) private _balances;

    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }

}
