
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

contract TokenPrice{

    // 가격이 작은 토큰이 원하는 decimals만큼 자릿수가 더 많아야한다
    // ex ) eth-usdt에서 리턴값이 7decimals를 원할 때 : usdt가 decimals가 7만큼 더 많아야한다

    // 토큰 가격의 소수점을 몇 자리까지 표현할 건지
    uint8 decimals = 6; // 기본값 6

    OriginTokenContract oUSDT;
    OriginTokenContract oETH;
    OriginTokenContract oWBTC;
    OriginTokenContract oXRP;
    OriginTokenContract WEMIX;
    OriginTokenContract KSP;
    OriginTokenContract BORA;
    OriginTokenContract oORC;
    OriginTokenContract MBX;
    OriginTokenContract oBNB;
    OriginTokenContract oBUSD;

    // 풀 주소
    address oETH_oUSDT = 0x029e2A1B2bb91B66bd25027E1C211E5628dbcb93;
    address KLAY_oUSDT = 0xD83f1B074D81869EFf2C46C530D7308FFEC18036;
    // address oWBTC_oUSDT = 0x9103Beb39283dA9C49B020D6546FD7C39f9bbc5b;
    address oWBTC_oETH = 0x2A6A4b0c96cA98eB691a5ddceE3c7b7788c1a8E3;
    address oXRP_oUSDT = 0xA2be534e5DD028288625bB376c81A9Eea3D9f0D5;
    address WEMIX_oUSDT = 0x2D803838Cb2D40EaCB0207ec4E567e2a8886b47F; //1
    address WEMIX_KLAY = 0x917EeD7ae9E7D3b0D875dd393Af93fFf3Fc301F8;  //2
    address KSP_oUSDT = 0xE75a6A3a800A2C5123e67e3bde911Ba761FE0705;
    address BORA_KLAY = 0xbbcA9B2D17987aCE3E98E376931c540270CE71bB;
    address oORC_KLAY = 0xe9ddb7A6994bD9cDF97CF11774A72894597D878B;
    address MBX_oUSDT = 0xE847e533C75b1832240c8142672CA295ac6de0cf;
    address oBNB_KLAY = 0xE20B9aeAcAC615Da0fdBEB05d4F75E16FA1F6B95; //1
    address oBNB_oBUSD = 0x5DA044864a2cbe03546810f6bb2f274a45edB8C6;//2
    
    constructor() {
        oUSDT = OriginTokenContract(0xceE8FAF64bB97a73bb51E115Aa89C17FfA8dD167);
        oETH = OriginTokenContract(0x34d21b1e550D73cee41151c77F3c73359527a396);
        oWBTC = OriginTokenContract(0x16D0e1fBD024c600Ca0380A4C5D57Ee7a2eCBf9c);
        oXRP = OriginTokenContract(0x9eaeFb09fe4aABFbE6b1ca316a3c36aFC83A393F);
        WEMIX = OriginTokenContract(0x5096dB80B21Ef45230C9E423C373f1FC9C0198dd);
        KSP = OriginTokenContract(0xC6a2Ad8cC6e4A7E08FC37cC5954be07d499E7654);
        BORA = OriginTokenContract(0x02cbE46fB8A1F579254a9B485788f2D86Cad51aa);
        oORC = OriginTokenContract(0xFe41102f325dEaa9F303fDd9484Eb5911a7BA557);
        MBX = OriginTokenContract(0xD068c52d81f4409B9502dA926aCE3301cc41f623);
        oBNB = OriginTokenContract(0x574e9c26bDA8b95D7329505b4657103710EB32eA);
        oBUSD = OriginTokenContract(0x210bC03f49052169D5588A52C317f71cF2078b85);
    }

//-----------아래 함수들의 return값인 토큰 가격의 소수점 자리수 = decimals----------------

    // 비트코인 가격 구하기
    function getBtc() public view returns(uint){
        uint btc = oWBTC.balanceOf(oWBTC_oETH);                // oWBTC의 decimals = 8  
        uint eth = oETH.balanceOf(oWBTC_oETH)/10**(10-decimals); 
        uint ethPerBtc = eth/btc;
        uint dollarPerBtc = ethPerBtc * getEth() / 10**decimals;
        return dollarPerBtc;
    }

    // 이더리움 가격 구하기
    function getEth() public view returns(uint){
        uint eth = oETH.balanceOf(oETH_oUSDT)/10**(12+decimals);   
        uint usdt = oUSDT.balanceOf(oETH_oUSDT);                   // oUSDT의 decimals = 6
        return usdt/eth;
    }

    // 클레이 가격 구하기
    function getKlay() public view returns(uint){
        uint klay = KLAY_oUSDT.balance/10**(12+decimals);
        uint usdt = oUSDT.balanceOf(KLAY_oUSDT);
        return usdt/klay;
    }

    // 리플 가격 구하기
    function getXrp() public view returns(uint){
        uint xrp = oXRP.balanceOf(oXRP_oUSDT)/10**(decimals); // oXRP의 decimals = 6
        uint usdt = oUSDT.balanceOf(oXRP_oUSDT);
        return usdt/xrp;
    }

    // 위믹스 가격 구하기
    function getWemix() public view returns(uint){
        uint wemix = WEMIX.balanceOf(WEMIX_oUSDT)/10**(12+decimals);
        uint usdt = oUSDT.balanceOf(WEMIX_oUSDT);
        return usdt/wemix;
    }

    // 클레이스왑 가격 구하기
    function getKsp() public view returns(uint){
        uint ksp = KSP.balanceOf(KSP_oUSDT)/10**(12+decimals);
        uint usdt = oUSDT.balanceOf(KSP_oUSDT);
        return usdt/ksp;
    }

    // 보라 가격 구하기
    function getBora() public view returns(uint){
        uint bora = BORA.balanceOf(BORA_KLAY)/10**(decimals);
        uint klay = BORA_KLAY.balance;
        uint klayPerBora = klay/bora * getKlay() /10**(decimals);
        return klayPerBora;
    }

    // 오르빗 가격 구하기
    function getOrc() public view returns(uint){
        uint orc = oORC.balanceOf(oORC_KLAY)/10**(decimals);
        uint klay = oORC_KLAY.balance;
        uint klayPerOrc = klay/orc * getKlay() /10**(decimals);
        return klayPerOrc;
    }

    // 마브렉스 가격 구하기
    function getMbx() public view returns(uint){
        uint mbx = MBX.balanceOf(MBX_oUSDT)/10**(12+decimals);
        uint usdt = oUSDT.balanceOf(MBX_oUSDT);
        return usdt/mbx;
    }

    // bnb 가격 구하기 (busd추가해야함)
    function getBnb() public view returns(uint){
        uint bnb = oBNB.balanceOf(oBNB_KLAY)/10**(decimals);
        uint klay = oBNB_KLAY.balance;
        uint klayPerBnb = klay/bnb * getKlay() /10**(decimals);
        return klayPerBnb;
    }

}



//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ메인 컨트랙트ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ

contract HatjaeContract is TokenPrice{

// 수익률 계산 공식(uint말고 int로 해야할듯) : (현재가격 - 매수가격)/매수가격 * 100 

    // 컨트랙트 배포자
    address owner;


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
        uint btc;   // 비트코인
        uint eth;   // 이더리움
        uint xrp;   // 리플
        uint wemix; // 위믹스
        uint klay;  // 클레이
        uint ksp;   // 클레이스왑
        uint bora;  // 보라
        uint orc;   // 오르빗체인
        uint mbx;   // 마브렉스
        uint bnb;   // 바이낸스코인
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
    function buyTicket(string memory _first, string memory _second, string memory _third, string memory _fourth) public payable{
        require(
            roundStartTime <= block.timestamp && block.timestamp < roundStartTime + 5 days,
            'Tickets are only available during the week'
            ); // 티켓은 주중에만 살 수 있다
        require(msg.value == ticketPrice, 'The ticket price should be the same as the amount you sent'); // 유저가 송금한 양은 정확히 티켓 가격이여야 한다
        require(msg.sender.balance >= ticketPrice, "You don't have as much as the ticket price"); // 유저가 티켓을 살 돈이 있는지 확인
        ticketBox[round][msg.sender].push([_first,_second,_third,_fourth]); // 라운드 -> 지불한 사람의 주소 -> [ [_first, _second, _third, _fourth] ]
    }

    // 레이싱 시작 시 스냅샷
    function takeSnapshot() public onlyOwner returns(Snapshot memory){
        require(
            roundStartTime + 5 days <= block.timestamp && block.timestamp < roundStartTime + 1 weeks, 
            'race starts as soon as Saturday comes'
            ); // 토요일 00시 이후에만 시작
        snapshot = Snapshot(
            TokenPrice.getBtc(),
            TokenPrice.getEth(),
            TokenPrice.getXrp(),
            TokenPrice.getWemix(),
            TokenPrice.getKlay(),
            TokenPrice.getKsp(),
            TokenPrice.getBora(),
            TokenPrice.getOrc(),
            TokenPrice.getMbx(),
            TokenPrice.getBnb()
        );
        return snapshot;
    }

    function currentRank() public returns() // bnbRank-> 상승률(int, decimals=6?) || CoinRank 구조체 안에 int bnb = 상승률 ...
    // 공통적으로 리턴할 것 : 상승률 순위 배열 (sorting?)

}