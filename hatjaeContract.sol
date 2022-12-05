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

//ㅡㅡㅡㅡㅡㅡㅡㅡㅡ가격 구하기 컨트랙트ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ

contract GetTokenPrice{
    //--------------------oETH-oUSDT--------------------
    OriginTokenContract public oUSDT;
    OriginTokenContract public oETH;

    // oETH-oUSDT 풀 주소
    address public oETH_oUSDT_address = 0x029e2A1B2bb91B66bd25027E1C211E5628dbcb93;
    
    constructor() {
        oUSDT = OriginTokenContract(0xceE8FAF64bB97a73bb51E115Aa89C17FfA8dD167);
        
        oETH = OriginTokenContract(0x34d21b1e550D73cee41151c77F3c73359527a396);
    }
    
    function getEthPrice() public view returns(uint){
        uint eth = oETH.balanceOf(oETH_oUSDT_address)/10**12;   // oETH의 decimals 18
        uint usdt = oUSDT.balanceOf(oETH_oUSDT_address);        // oUSDT의 decimals 6
        return usdt/eth;
    }
}


//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ메인 컨트랙트ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ

contract hatjaeContract{

// 수익률 계산 공식(uint말고 int로 해야할듯) : (현재가격 - 매수가격)/매수가격 * 100 

    // 컨트랙트 배포자
    address owner;

    // 토큰 가격의 소수점을 몇 자리까지 표현할 건지
    uint8 decimals

    // 티켓 가격
    uint ticketPrice = 1e17; // e18 = *10**17 ❗❗      // 1e17 == 0.1klay

    // 라운드 (1주일마다++)
    uint round = 0; // 0라운드부터 시작(?) (배열 인덱스랑 맞추려고)

    // 라운드 시작 시간 (월요일 00시)
    uint roundStartTime = 1670166000; // 12월 5일 월요일 00시

    // 라운드 진행 중 유저의 티켓 정보
    // 라운드 => 유저주소 => [ [코인순서], [코인순서], ... ]
    //                                        👇 코인 4개 선택 가능
    mapping (uint => mapping(address => string[4][])) ticketBox;

    // 레이싱 시작 시 스냅샷 찍어놓고 상승률 계산
    struct Snapshot {
        string btc;   // 비트코인
        string eth;   // 이더리움
        string xrp;   // 리플
        string wemix; // 위믹스
        string klay;  // 클레이
        string ksp;   // 클레이스왑
        string bora;  // 보라
        string orc;   // 오르빗체인
        string gala;  // 갈라
        string bnb;   // 바이낸스코인
    }
    Snapshot snapshot;

    // 라운드별 레이싱결과의 이력
    struct racingResult{
        address userAddress;
        uint prize;
        string[] coinRank;
        uint winner;
    }
    racingResult[] racingHistory;

//---------------modifier---------------

    modifier onlyOwner{
        require(msg.sender == owner, 'Your not owner!');
        _;
    }

//----------------함수-----------------

    // 티켓 사기
    function buyTicket(string memory first, string memory second, string memory third, string memory fourth) public payable{
        require(roundStartTime <= block.timestamp && block.timestamp < roundStartTime + 5 days, 'Tickets are only available during the week'); // 티켓은 주중에만 살 수 있다
        require(msg.value == ticketPrice, 'The ticket price should be the same as the amount you sent'); // 유저가 송금한 양은 정확히 티켓 가격이여야 한다
        require(msg.sender.balance >= ticketPrice, "You don't have as much as the ticket price"); // 유저가 티켓을 살 돈이 있는지 확인
        ticketBox[round][msg.sender].push([first,second,third,fourth]);
    }

    // 레이싱 시작 시 스냅샷
    function racingStart() public

}