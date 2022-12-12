
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
    function getBtc() internal view returns(uint){
        uint btc = oWBTC.balanceOf(oWBTC_oETH);                // oWBTC의 decimals = 8  
        uint eth = oETH.balanceOf(oWBTC_oETH)/10**(10-decimals); 
        uint ethPerBtc = eth/btc;
        uint dollarPerBtc = ethPerBtc * getEth() / 10**decimals;
        return dollarPerBtc;
    }

    // 이더리움 가격 구하기
    function getEth() internal view returns(uint){
        uint eth = oETH.balanceOf(oETH_oUSDT)/10**(12+decimals);   
        uint usdt = oUSDT.balanceOf(oETH_oUSDT);                   // oUSDT의 decimals = 6
        return usdt/eth;
    }

    // 클레이 가격 구하기
    function getKlay() internal view returns(uint){
        uint klay = KLAY_oUSDT.balance/10**(12+decimals);
        uint usdt = oUSDT.balanceOf(KLAY_oUSDT);
        return usdt/klay;
    }

    // 리플 가격 구하기
    function getXrp() internal view returns(uint){
        uint xrp = oXRP.balanceOf(oXRP_oUSDT)/10**(decimals); // oXRP의 decimals = 6
        uint usdt = oUSDT.balanceOf(oXRP_oUSDT);
        return usdt/xrp;
    }

    // 위믹스 가격 구하기
    function getWemix() internal view returns(uint){
        uint wemix = WEMIX.balanceOf(WEMIX_oUSDT)/10**(12+decimals);
        uint usdt = oUSDT.balanceOf(WEMIX_oUSDT);
        return usdt/wemix;
    }

    // 클레이스왑 가격 구하기
    function getKsp() internal view returns(uint){
        uint ksp = KSP.balanceOf(KSP_oUSDT)/10**(12+decimals);
        uint usdt = oUSDT.balanceOf(KSP_oUSDT);
        return usdt/ksp;
    }

    // 보라 가격 구하기
    function getBora() internal view returns(uint){
        uint bora = BORA.balanceOf(BORA_KLAY)/10**(decimals);
        uint klay = BORA_KLAY.balance;
        uint klayPerBora = klay/bora * getKlay() /10**(decimals);
        return klayPerBora;
    }

    // 오르빗 가격 구하기
    function getOrc() internal view returns(uint){
        uint orc = oORC.balanceOf(oORC_KLAY)/10**(decimals);
        uint klay = oORC_KLAY.balance;
        uint klayPerOrc = klay/orc * getKlay() /10**(decimals);
        return klayPerOrc;
    }

    // 마브렉스 가격 구하기
    function getMbx() internal view returns(uint){
        uint mbx = MBX.balanceOf(MBX_oUSDT)/10**(12+decimals);
        uint usdt = oUSDT.balanceOf(MBX_oUSDT);
        return usdt/mbx;
    }

    // bnb 가격 구하기 (busd추가해야함)
    function getBnb() internal view returns(uint){
        uint bnb = oBNB.balanceOf(oBNB_KLAY)/10**(decimals);
        uint klay = oBNB_KLAY.balance;
        uint klayPerBnb = klay/bnb * getKlay() /10**(decimals);
        return klayPerBnb;
    }

}

//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ메인 컨트랙트ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ

contract HatjaeContract is TokenPrice{

    // 컨트랙트 배포자
    address owner;

    // 배포 시 배포자 주소 owner 변수에 기입
    constructor(){
        owner = msg.sender;
    }

    // 티켓 가격
    uint TICKET_PRICE = 1e17; // e18 = *10**17 ❗❗      // 1e17 == 0.1klay

    // 당첨자 나올 시 수수료 ( n%라면 n입력 )
    uint FEE_FOR_DEV = 5;  

    // 라운드 (1주일마다++)
    uint round = 0; // 0라운드부터 시작(?) (배열 인덱스랑 맞추려고)

    // 라운드 시작 시간 (월요일 00시)
    uint currentRoundStartedTime = 1670166000 + 1 weeks * round; // 12월 5일 월요일 00시 부터 시작

    // 라운드 진행 중 유저의 티켓 정보
    // 라운드 => 유저주소 => [ [코인순서], [코인순서], ... ]
    //                                        👇 코인 4개 선택 가능
    mapping (uint => mapping(address => string[4][])) ticketBox;

    // 스냅샷 재촬영 방지
    mapping (uint => bool) isTaked;

    // 참가자들의 주소 (당첨자 색출에 사용)
    // 라운드 => [ 유저주소, 유저주소, ... ]
    mapping (uint => address[]) buyers;

    // 현재 라운드의 티켓 수
    mapping( uint => uint ) ticketCount;

    // 토요일 00시에 찍을 스냅샷
    struct Snapshot {
        uint btc;   // 비트코인
        uint eth;   // 이더리움
        uint xrp;   // 리플
        uint klay;  // 클레이튼
        uint wemix; // 위믹스
        uint ksp;   // 클레이스왑
        uint bora;  // 보라
        uint orc;   // 오르빗체인
        uint mbx;   // 마브렉스
        uint bnb;   // 바이낸스코인
    }
    Snapshot snapshot;

    // 상승률 반환용 구조체 (getCurrentRank의 로컬변수로 사용)
    struct Token{
        string symbol;
        int rate; 
    }

    // 라운드별 레이싱결과의 이력
    mapping( uint => RacingResult ) racingHistory;
    struct RacingResult{
        address[] winners;
        string[] orderOfWinners;
        uint prizePerWinner;
    }
    RacingResult[] racingResult;

    // 당첨금 전송 성공여부 이벤트
    event transferSuccessful(bool _success, string _to);

//---------------modifier---------------

    modifier onlyOwner{
        require(msg.sender == owner, 'Your not owner!');
        _;
    }

    modifier isWeekdays{
        require(
        currentRoundStartedTime <= block.timestamp && block.timestamp < currentRoundStartedTime + 5 days,
        "It's not the weekdays now"
        );
        _;
    }

    modifier isWeekend{
        require(
        currentRoundStartedTime + 5 days <= block.timestamp && block.timestamp < currentRoundStartedTime + 1 weeks,
        "It's not the weekend now"
        );
        _;
    }

//---------------main function---------------

    // 티켓 사기 
    function buyTicket (
        string memory _first,
        string memory _second,
        string memory _third,
        string memory _fourth
        ) public isWeekdays payable{
        require(msg.value == TICKET_PRICE, 'The ticket price should be the same as the amount you sent'); // 유저가 송금한 양은 정확히 티켓 가격이여야 한다
        require(msg.sender.balance >= TICKET_PRICE, "You don't have as much as the ticket price"); // 유저가 티켓을 살 돈이 있는지 확인

        // 티켓 구매가 처음이라면 참가자 주소 배열에 기록
        if (ticketBox[round][msg.sender].length == 0){
            buyers[round].push(msg.sender);
        }
        // 티켓 지급(?)
        ticketBox[round][msg.sender].push([_first, _second, _third, _fourth]); // 라운드 -> 지불한 사람의 주소 -> [ [_first, _second, _third, _fourth] ]
        // 현재 라운드 티켓 수 count
        ticketCount[round]++;
    }


    // 레이싱 시작 시 스냅샷
    function takeSnapshot() public isWeekend onlyOwner {
        require(isTaked[round] == false, "Snapshots can only be taken once per round"); // 중복 촬영 방지
        snapshot.btc= TokenPrice.getBtc();
        snapshot.eth= TokenPrice.getEth();
        snapshot.xrp= TokenPrice.getXrp();
        snapshot.wemix= TokenPrice.getWemix();
        snapshot.klay= TokenPrice.getKlay();
        snapshot.ksp= TokenPrice.getKsp();
        snapshot.bora= TokenPrice.getBora();
        snapshot.orc= TokenPrice.getOrc();
        snapshot.mbx= TokenPrice.getMbx();
        snapshot.bnb= TokenPrice.getBnb();
        isTaked[round]=true; // 중복 촬영 방지
    }


    // 당첨자 추첨
    //                        🤔 👇함수, 송금주소에 payable 적용 안 해도 call은 작동됨
    function lottery() public isWeekdays onlyOwner payable{
        // 당첨번호 추출
        Token[10] memory rank = getCurrentRank();
        racingHistory[round].orderOfWinners = [rank[0].symbol, rank[1].symbol, rank[2].symbol, rank[3].symbol];

        // 당첨자 색출
        for(uint i=0 ; i < buyers[round].length ; i++){
            for(uint j=0 ; j < ticketBox[round][buyers[round][i]].length ; j++){
                if(
                    keccak256(abi.encodePacked((ticketBox[round][buyers[round][i]][j][0]))) ==
                    keccak256(abi.encodePacked((rank[0].symbol)))
                    // &&
                    // keccak256(abi.encodePacked((ticketBox[round][buyers[round][i]][j][1]))) ==
                    // keccak256(abi.encodePacked((rank[1].symbol)))
                    // &&
                    // keccak256(abi.encodePacked((ticketBox[round][buyers[round][i]][j][2]))) ==
                    // keccak256(abi.encodePacked((rank[2].symbol)))
                    // &&
                    // keccak256(abi.encodePacked((ticketBox[round][buyers[round][i]][j][3]))) ==
                    // keccak256(abi.encodePacked((rank[3].symbol)))
                ){
                    racingHistory[round].winners.push(buyers[round][i]);
                }    
            }
        }

        // 이번 라운드 상금 기록 후 당첨금 인출
        if (racingHistory[round].winners.length == 0){
            racingHistory[round].prizePerWinner == 0;
        }else{
            racingHistory[round].prizePerWinner = address(this).balance * (100-FEE_FOR_DEV)/100 / racingHistory[round].winners.length;
            // 당첨자에게 송금
            for(uint i=0 ; i < racingHistory[round].winners.length ; i++){
                (bool successW,) = payable(racingHistory[round].winners[i]).call{value:racingHistory[round].prizePerWinner}("");
                emit transferSuccessful(successW, "to winner");
            }
            // owner에게 잔금(수수료) 송금
            (bool successO,) = payable(owner).call{value: address(this).balance}("");
            emit transferSuccessful(successO, "to owner");
        }

        // 다음 라운드로
        round++;
    }

//----------------view function----------------

    // 토큰들의 현재 랭킹 집계
    function getCurrentRank() public view isWeekend returns(Token[10] memory){
        // 토큰 심볼과 상승률로 구성된 코인별 구조체
        // 각 토큰 수익률 계산 : [ (현재가격 - 매수가격) * 10^(나타낼 소수점 자리 수) / 매수가격 * 100 ] 
        Token memory btc = Token("btc",(int(TokenPrice.getBtc()) - int(snapshot.btc))*int(10**decimals) / int(snapshot.btc) * 100);
        Token memory eth = Token("eth",(int(TokenPrice.getEth()) - int(snapshot.eth))*int(10**decimals) / int(snapshot.eth) * 100);
        Token memory xrp = Token("xrp",(int(TokenPrice.getXrp()) - int(snapshot.xrp))*int(10**decimals) / int(snapshot.xrp) * 100);
        Token memory wemix = Token("wemix",(int(TokenPrice.getKlay()) - int(snapshot.klay))*int(10**decimals) / int(snapshot.klay) * 100);
        Token memory klay = Token("klay",(int(TokenPrice.getWemix()) - int(snapshot.wemix))*int(10**decimals) / int(snapshot.wemix) * 100);
        Token memory ksp = Token("ksp",(int(TokenPrice.getKsp()) - int(snapshot.ksp))*int(10**decimals) / int(snapshot.ksp) * 100);
        Token memory bora = Token("bora",(int(TokenPrice.getBora()) - int(snapshot.bora))*int(10**decimals) / int(snapshot.bora) * 100);
        Token memory orc = Token("orc",(int(TokenPrice.getOrc()) - int(snapshot.orc))*int(10**decimals) / int(snapshot.orc) * 100);
        Token memory mbx = Token("mbx",(int(TokenPrice.getMbx()) - int(snapshot.mbx))*int(10**decimals) / int(snapshot.mbx) * 100);
        Token memory bnb = Token("bnb",(int(TokenPrice.getBnb()) - int(snapshot.bnb))*int(10**decimals) / int(snapshot.bnb) * 100);

        // 배열에 넣은 후
        Token[10] memory tempRank = [btc,eth,xrp,klay,wemix,ksp,bora,orc,mbx,bnb];

        // 내림차순 삽입정렬
        for(uint i = 1; i < tempRank.length; i++){
        Token memory temp = tempRank[i];
        int aux = int(i)-1;
        while(aux >= 0 && tempRank[uint(aux)].rate < temp.rate){
            tempRank[uint(aux+1)] = tempRank[uint(aux)];
            aux--;
        }
        tempRank[uint(aux+1)]=temp;
        }
        return tempRank;
    }

    // 현재 라운드의 자신의 티켓들 보기
    function checkMyTickets() public view returns(string[4][] memory){ 
        return ticketBox[round][msg.sender];
    }
    
    // 현재 라운드의 참가자 수 보기
    function getNumberOfBuyer() public view returns(uint){
        return buyers[round].length;
    }

    // 현재 라운드의 티켓 수 보기
    function getNumberOfTicket() public view returns(uint){
        return ticketCount[round];
    }

    //------------------forTest------------------

    function getCurrentRound() public view returns(uint){
        return round;
    }

    function getBuyers() public view returns(address[] memory){
        return buyers[round];
    }

    function istaked() public view returns(bool){
        return isTaked[round];
    }

    function getWinners(uint _round) public view returns(address[] memory){
        return racingHistory[_round].winners;
    }

    function getPrizePerWinner(uint _round) public view returns(uint){
        return racingHistory[_round].prizePerWinner;
    }
}