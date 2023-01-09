// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.1;

//ㅡㅡㅡㅡㅡㅡㅡㅡoUSDT와 oETH 컨트랙트의 일부ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ 
abstract contract IKIP7{
    function balanceOf(address account) public view virtual returns (uint256);
}

contract OriginTokenContract is IKIP7 {

    mapping (address => uint256) private _balances;

    function balanceOf(address account) public view override returns (uint256) {
        return _balances[account];
    }

}


//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ풀의 balance 구하기ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ

contract MyContract{
    OriginTokenContract public oUSDT;
    OriginTokenContract public oETH;

    // oETH-oUSDT 풀 주소
    address public oETH_oUSDT_address = 0x029e2A1B2bb91B66bd25027E1C211E5628dbcb93;
    
    // MyContract 배포 시 각 변수에 토큰 컨트랙트 주소 넣어줌
    constructor() {
        oUSDT = OriginTokenContract(0xceE8FAF64bB97a73bb51E115Aa89C17FfA8dD167);
        oETH = OriginTokenContract(0x34d21b1e550D73cee41151c77F3c73359527a396);
    }

    // oETH-oUSDT풀에 대한 각 토큰의 balance 구하기
    function getOusdtBalance() public view returns(uint){
        return oUSDT.balanceOf(oETH_oUSDT_address);
    } 
    function getOethBalance() public view returns(uint){
        return oETH.balanceOf(oETH_oUSDT_address);
    } 
    
	// balance끼리 나눠서 이더의 현재 달러가격 구하기
    function dollarPerEth() public view returns(uint){
        //              oUSDT의 decimal(6)에 oETH를 맞춤 👇
        uint eth = oETH.balanceOf(oETH_oUSDT_address)/10**12;
        uint usdt = oUSDT.balanceOf(oETH_oUSDT_address); 
        return usdt/eth;
    }
}



// + 다른 방법
contract TokenPrice2{

    address oUSDT = 0xceE8FAF64bB97a73bb51E115Aa89C17FfA8dD167;
    address oETH = 0x34d21b1e550D73cee41151c77F3c73359527a396;

    address oETH_oUSDT = 0x029e2A1B2bb91B66bd25027E1C211E5628dbcb93;

    function dollarPerEth() public view returns(uint){
        uint eth = OriginTokenContract(oETH).balanceOf(oETH_oUSDT)/10**12;   
        uint usdt = OriginTokenContract(oUSDT).balanceOf(oETH_oUSDT);          
        return usdt/eth;

    }



// 방법2 call 쓰기 (view 함수로 사용할 수 없음)
contract TokenPrice3{
address oUSDT = 0xceE8FAF64bB97a73bb51E115Aa89C17FfA8dD167;

address poolAdr = 0x029e2A1B2bb91B66bd25027E1C211E5628dbcb93;

// oUSDT의 balance만 가져옴
function bytesToUint() public returns (uint256){
    bytes memory callFuncBytes = abi.encodeWithSignature("balanceOf(address)",poolAdr);
    (, bytes memory balance) = usdt.call(callFuncBytes);
    uint256 number;
    // 바이트 결과값을 정수로
    for(uint i=0;i<balance.length;i++){
    number = number + uint8(balance[i])*(2**(8*(balance.length-(i+1))));
    }
    return number;
}
}

// 방법3 체인링크 사용하기


}