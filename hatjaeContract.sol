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
// -[ ] racing history 자료구조  :
// [ struct{ address : 0x000, prize : 0,  coinRank: [코인순서], winner: 0 }, … ]
// 월요일 00시에 사용하는 당첨자 선정 함수에서 기록

// - [ ]  라운드 진행중 유저의 티켓 자료구조: 라운드→유저주소→티켓배열[ 티켓정보배열[코인순서] ]
// ex) round → userAddress → tickets[ ticket[ bnb,eth,klay,ripple ], … ]
// (유저의 이름같은 세부정보를 넣는다면 티켓배열을 구조체로 만들 수 있을 듯?)
// 유저의 복권 개수는 티켓배열.length

// 이중배열 만드는 법? string[][]?
// 2차원 배열 시 다른 언어의 순서와 반대임 (예: array[1][2] → array[2][1]) ?
//   T[][k] x;  // k개의 T를 담을 수 있는 가변 배열 x선언
                // 일반 적인 언어에서는 T[k][] 한다.
//         👇바깥쪽배열
// string[][]
//       👆안쪽배열  

// 수익률 계산 공식(uint말고 int로 해야할듯) : (현재가격 - 매수가격)/매수가격 * 100 




    // 컨트랙 배포자
    address owner;

    //티켓 가격 (클레이)
    uint8 ticketPrice; 

    // 라운드 진행상황
    enum RoundStatus { 
        funding,
        racing
    }
    RoundStatus public roundStatus; 

    // 라운드 진행 중 유저의 티켓 정보           👇 코인 개수
    mapping (uint => mapping(address => string[10][])) ticketInfo;
    mapping (address => string[10][]) ticketInfo2;


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

    //
}