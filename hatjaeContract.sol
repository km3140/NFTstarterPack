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


//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ메인 컨트랙트ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ

contract hatjaeContract{

// 수익률 계산 공식(uint말고 int로 해야할듯) : (현재가격 - 매수가격)/매수가격 * 100 

    address owner;

    uint ticketPrice = 1e18; // e18 = *10**18 ❗❗

    uint round = 0; // 0라운드부터 시작(?) (배열 인덱스랑 맞추려고)

    // 라운드 진행상황
    enum RoundStatus { 
        funding,
        racing
    }
    RoundStatus public roundStatus; 

    // 라운드 진행 중 유저의 티켓 정보
    // 라운드 => 유저주소 => [ [코인순서], [코인순서], ... ]
    //                                        👇 코인 4개 선택 가능
    mapping (uint => mapping(address => string[4][])) ticketBox;
    mapping (address => string[4][]) ticketBox2;

    // 레이싱 시작 시 스냅샷 찍어놓고 상승률 계산
    struct snapshot {
        uint btc;   // 비트코인
        uint eth;   // 이더리움
        uint xrp;   // 리플
        uint wemix; // 위믹스
        uint klay;  // 클레이
        uint ksp;   // 클레이스왑
        uint bora;  // 보라
        uint orc;   // 오르빗체인
        uint gala;  // 갈라
        uint bnb;   // 바이낸스코인
    }

    // 라운드별 레이싱결과의 이력
    struct racingResult{
        address userAddress;
        uint prize;
        string[] coinRank;
        uint winner;
    }
    racingResult[] racingHistory;



}