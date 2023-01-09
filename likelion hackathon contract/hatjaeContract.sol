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

    // 가격을 구할 토큰이 원하는 decimals만큼 자릿수가 더 적어야한다 (토큰/가격을구할토큰)
    // ex ) eth-usdt에서 리턴값이 6decimals를 원할 때 : usdt가 decimals가 6만큼 더 많아야한다

    // 토큰 가격의 소수점을 몇 자리까지 표현할 건지
    uint8 decimals = 6; // 기본값 6

    OriginTokenContract oUSDT = OriginTokenContract(0xceE8FAF64bB97a73bb51E115Aa89C17FfA8dD167);
    OriginTokenContract oETH = OriginTokenContract(0x34d21b1e550D73cee41151c77F3c73359527a396);
    OriginTokenContract oWBTC = OriginTokenContract(0x16D0e1fBD024c600Ca0380A4C5D57Ee7a2eCBf9c);
    OriginTokenContract oXRP = OriginTokenContract(0x9eaeFb09fe4aABFbE6b1ca316a3c36aFC83A393F);
    OriginTokenContract WEMIX = OriginTokenContract(0x5096dB80B21Ef45230C9E423C373f1FC9C0198dd);
    OriginTokenContract KSP = OriginTokenContract(0xC6a2Ad8cC6e4A7E08FC37cC5954be07d499E7654);
    OriginTokenContract BORA = OriginTokenContract(0x02cbE46fB8A1F579254a9B485788f2D86Cad51aa);
    OriginTokenContract oORC = OriginTokenContract(0xFe41102f325dEaa9F303fDd9484Eb5911a7BA557);
    OriginTokenContract MBX = OriginTokenContract(0xD068c52d81f4409B9502dA926aCE3301cc41f623);
    OriginTokenContract oBNB = OriginTokenContract(0x574e9c26bDA8b95D7329505b4657103710EB32eA);
    OriginTokenContract oBUSD = OriginTokenContract(0x210bC03f49052169D5588A52C317f71cF2078b85);

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
    address oBNB_oETH = 0x8119f0CeC72a26fE23CA1aB076137Ea5D8a19d54; //3

//---------------------------가격 구하기----------------------------

    // 비트코인 (2,800,000$)
    function getBtc() internal view returns(uint){
        uint btc = oWBTC.balanceOf(oWBTC_oETH);                // oWBTC의 decimals = 8  
        uint eth = oETH.balanceOf(oWBTC_oETH)/10**(10-decimals); 
        uint btcFromEth = eth/btc * getEth() / 10**decimals;

        uint btcPrice = btcFromEth;
        return btcPrice;
    }

    // 이더리움 (4,100,000$)
    function getEth() internal view returns(uint){
        uint eth = oETH.balanceOf(oETH_oUSDT)/10**(12+decimals);   
        uint usdt = oUSDT.balanceOf(oETH_oUSDT);                   // oUSDT의 decimals = 6
        uint ethFromUsdt = usdt/eth;

        uint ethPrice = ethFromUsdt;
        return ethPrice;
    }

    // 클레이 (9,700,000$)
    function getKlay() internal view returns(uint){
        uint klay = KLAY_oUSDT.balance/10**(12+decimals);
        uint usdt = oUSDT.balanceOf(KLAY_oUSDT);
        uint klayFromUsdt = usdt/klay;

        uint klayPrice = klayFromUsdt;
        return klayPrice;
    }

    // 리플 (2,200,000$)
    function getXrp() internal view returns(uint){
        uint xrp = oXRP.balanceOf(oXRP_oUSDT)/10**(decimals); // oXRP의 decimals = 6
        uint usdt = oUSDT.balanceOf(oXRP_oUSDT);
        uint xrpFromUsdt = usdt/xrp;
    
        uint xrpPrice = xrpFromUsdt;
        return xrpPrice;
    }

    // 위믹스 (1,950,000$)
    function getWemix() internal view returns(uint){
        // WEMIX_oUSDT
        uint wemix = WEMIX.balanceOf(WEMIX_oUSDT)/10**(12+decimals);
        uint usdt = oUSDT.balanceOf(WEMIX_oUSDT);
        uint wemixFromUsdt = usdt/wemix;

        // WEMIX_KLAY
        uint wemix2 = WEMIX.balanceOf(WEMIX_oUSDT)/10**(decimals);
        uint klay = WEMIX_KLAY.balance;
        uint wemixFromKlay = klay/wemix2 * getKlay() /10**(decimals);

        uint wemixPrice = (wemixFromUsdt + wemixFromKlay)/2;
        return wemixPrice;
    }

    // 클레이스왑 (1,800,000$)
    function getKsp() internal view returns(uint){
        uint ksp = KSP.balanceOf(KSP_oUSDT)/10**(12+decimals);
        uint usdt = oUSDT.balanceOf(KSP_oUSDT);
        uint kspFromUsdt = usdt/ksp;
        
        uint kspPrice = kspFromUsdt;
        return kspPrice;
    }

    // 보라 (1,500,000$)
    function getBora() internal view returns(uint){
        uint bora = BORA.balanceOf(BORA_KLAY)/10**(decimals);
        uint klay = BORA_KLAY.balance;
        uint boraFromKlay = klay/bora * getKlay() /10**(decimals);

        uint boraPrice = boraFromKlay;
        return boraPrice;
    }

    // 오르빗 (1,600,000$)
    function getOrc() internal view returns(uint){
        uint orc = oORC.balanceOf(oORC_KLAY)/10**(decimals);
        uint klay = oORC_KLAY.balance;
        uint orcFromKlay = klay/orc * getKlay() /10**(decimals);

        uint orcPrice = orcFromKlay;
        return orcPrice;
    }

    // 마브렉스 (1,500,000$)
    function getMbx() internal view returns(uint){
        uint mbx = MBX.balanceOf(MBX_oUSDT)/10**(12+decimals);
        uint usdt = oUSDT.balanceOf(MBX_oUSDT);
        uint mbxFromUsdt = usdt/mbx;

        uint mbxPrice = mbxFromUsdt;
        return mbxPrice;
    }

    // bnb (500,000$)
    function getBnb() internal view returns(uint){
        // oBNB_KLAY
        uint bnb = oBNB.balanceOf(oBNB_KLAY)/10**(decimals);
        uint klay = oBNB_KLAY.balance;
        uint bnbFromKlay = klay/bnb * getKlay() /10**(decimals);

        // oBNB_oBUSD
        uint bnb2 = oBNB.balanceOf(oBNB_oBUSD)/10**(decimals);
        uint busd = oBUSD.balanceOf(oBNB_oBUSD);
        uint bnbFromBusd = busd/bnb2;
        
        // oBNB_oETH
        uint bnb3 = oBNB.balanceOf(oBNB_oETH)/10**(decimals);
        uint eth = oETH.balanceOf(oBNB_oETH);
        uint bnbFromEth = eth/bnb3 * getEth() / 10**(decimals);

        uint bnbPrice = (5*bnbFromKlay + 4*bnbFromBusd + 1*bnbFromEth) / 10;
        return bnbPrice;
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

    // 티켓 가격 (5 Klay)
    uint TICKET_PRICE = 5e18; // e17 = *10**17, 1e17peb == 0.1Klay

    // 당첨자 나올 시 수수료 ( n%라면 n입력 )
    uint FEE_FOR_DEV = 5;  

    // 라운드 (1주일마다++)
    uint round = 0; // 0라운드부터 시작(?) (배열 인덱스랑 맞추려고)

    // // 라운드 시작 시간 (월요일 00시)
    // uint currentRoundStartedTime = 1670166000 + 1 weeks * round; // 12월 5일 월요일 00시 부터 시작

    // 라운드별 유저의 티켓 정보
    mapping (uint => mapping(address => Ticket[])) ticketBox;
    struct Ticket{
        address buyer;  
        string[4] order; // 코인 4개 선택
        string said; // 했제 한마디     (❗string 길이 제한 추가하면 좋을 듯)
        uint round; // 티켓 구매 당시의 라운드
    }

    // 라운드별 스냅샷 (재촬영 방지)
    mapping (uint => bool) isTaked;

    // 라운드별 참가자들의 주소 (당첨자 색출에 사용)
    mapping (uint => address[]) buyers;

    // 라운드별 티켓 수 세기
    mapping(uint => uint) ticketCount;

    // 라운드별 스냅샷 (토요일 00시에 찍음)
    mapping(uint => Snapshot) snapshot;
    struct Snapshot { 
        uint btc;
        uint eth;
        uint xrp;
        uint klay;
        uint wemix;
        uint ksp;
        uint bora;
        uint orc;
        uint mbx;
        uint bnb;
    }

    // 라운드별 레이싱결과의 이력
    mapping( uint => Result ) result;
    struct Result{
        Ticket[] winningTickets; // 당첨 티켓들
        uint prizeAmount; // 수수료 뺀 총 상금
    }

    // 티켓 구매 완료 이벤트
    event ticketSold(address _who, string[4] _order, string _said);

    // 스냅샷 촬영 완료 이벤트
    event take(uint _round, Snapshot _snapshot);

    // 당첨금 전송 성공여부 이벤트
    event transferSuccessful(bool _success, string _to);

    // 상승률 반환용 구조체 (currentRank, lottery의 로컬변수로 사용)
    struct Token{
        string symbol;
        int rate; 
    }

//---------------modifier---------------

    modifier onlyOwner{
        require(msg.sender == owner, 'Your not owner!');
        _;
    }

    // // 주중인지 확인
    // modifier isWeekdays{
    //     require(
    //     currentRoundStartedTime <= block.timestamp && block.timestamp < currentRoundStartedTime + 5 days,
    //     "It's not the weekdays now"
    //     );
    //     _;
    // }

    // // 주말인지 확인
    // modifier isWeekend{
    //     require(
    //     currentRoundStartedTime + 5 days <= block.timestamp && block.timestamp < currentRoundStartedTime + 1 weeks,
    //     "It's not the weekend now"
    //     );
    //     _;
    // }
    
    // // view 함수들에 사용
    // modifier notStarted(uint _round){
    //     require(_round <= round, "This round has not started");
    //     _;
    // }
    // modifier notFinished(uint _round){
    //     require(_round < round, "It's not a finished round");
    //     _;
    // }

//---------------main function---------------

    // 티켓 사기 
    function buyTicket (
        string memory _first,
        string memory _second,
        string memory _third,
        string memory _fourth,
        string memory _said
        ) public payable{
        require(msg.value == TICKET_PRICE, 'The ticket price should be the same as the amount you sent'); // 유저가 송금한 양은 정확히 티켓 가격이여야 한다
        require(msg.sender.balance >= TICKET_PRICE, "You don't have as much as the ticket price"); // 유저가 티켓을 살 돈이 있는지 확인

        // 티켓 구매가 처음이라면 참가자 주소 배열에 기록
        if (ticketBox[round][msg.sender].length == 0){
            buyers[round].push(msg.sender);
        }

        // 티켓 지급(?)
        ticketBox[round][msg.sender].push(Ticket(msg.sender,  [_first, _second, _third, _fourth], _said, round));

        // 현재 라운드 티켓 수 count
        ticketCount[round]++;

        // 구매자 주소와 구매자가 선택한 순위 emit
        emit ticketSold(msg.sender,  [_first, _second, _third, _fourth], _said);
    }


    // 레이싱 시작 시 스냅샷
    function takeSnapshot() public onlyOwner {
        require(isTaked[round] == false, "Snapshots can only be taken once per round"); // 중복 촬영 방지
        snapshot[round].btc= TokenPrice.getBtc();
        snapshot[round].eth= TokenPrice.getEth();
        snapshot[round].xrp= TokenPrice.getXrp();
        snapshot[round].wemix= TokenPrice.getWemix();
        snapshot[round].klay= TokenPrice.getKlay();
        snapshot[round].ksp= TokenPrice.getKsp();
        snapshot[round].bora= TokenPrice.getBora();
        snapshot[round].orc= TokenPrice.getOrc();
        snapshot[round].mbx= TokenPrice.getMbx();
        snapshot[round].bnb= TokenPrice.getBnb();

         // 중복 촬영 방지
        isTaked[round]=true;

        // 촬영완료 이벤트
        emit take(round,snapshot[round]);
    }


    // 당첨자 추첨
    function lottery() public onlyOwner payable returns(Result memory){
        // // 스냅샷을 찍은 상태인지 확인
        // require(isTaked[round] == true, "Snapshots must be taken");

        // 당첨번호 추출
        Token[10] memory rank = currentRank();

        // 당첨자 색출
        for(uint i=0 ; i < buyers[round].length ; i++){
            for(uint j=0 ; j < ticketBox[round][buyers[round][i]].length ; j++){
                if(
                    keccak256(abi.encodePacked((ticketBox[round][buyers[round][i]][j].order[0]))) ==
                    keccak256(abi.encodePacked((rank[0].symbol)))
                    &&
                    keccak256(abi.encodePacked((ticketBox[round][buyers[round][i]][j].order[1]))) ==
                    keccak256(abi.encodePacked((rank[1].symbol)))
                    &&
                    keccak256(abi.encodePacked((ticketBox[round][buyers[round][i]][j].order[2]))) ==
                    keccak256(abi.encodePacked((rank[2].symbol)))
                    &&
                    keccak256(abi.encodePacked((ticketBox[round][buyers[round][i]][j].order[3]))) ==
                    keccak256(abi.encodePacked((rank[3].symbol)))
                ){
                    result[round].winningTickets.push(ticketBox[round][buyers[round][i]][j]);
                }    
            }
        }

        // 이번 라운드 상금 기록 후 당첨금 인출
        if (result[round].winningTickets.length == 0){
            result[round].prizeAmount == 0;
        }else{
            result[round].prizeAmount = address(this).balance * (100-FEE_FOR_DEV)/100;
            uint prizePerWinner = result[round].prizeAmount / result[round].winningTickets.length;

            // 당첨자에게 송금
            for(uint i=0 ; i < result[round].winningTickets.length ; i++){
                (bool success1,) = payable(result[round].winningTickets[i].buyer).call{value:prizePerWinner}("");
                emit transferSuccessful(success1, "to winner");
            }
    
            // owner에게 잔금(수수료) 송금
            (bool success2,) = payable(owner).call{value: address(this).balance}("");
            emit transferSuccessful(success2, "to owner");
        }

        // 다음 라운드로
        round++;

        return result[round-1];
    }

//----------------view function----------------

    // 토큰들의 현재 랭킹 집계
    function currentRank() public view returns(Token[10] memory tempRank){
        // 토큰 심볼과 상승률로 구성된 코인별 구조체
        // 각 토큰 수익률 계산 : [ (현재가격 - 매수가격) * 10^(나타낼 소수점 자리 수) / 매수가격 * 100 ] 
        Token memory btc = Token("btc",(int(TokenPrice.getBtc()) - int(snapshot[round].btc))*int(10**decimals) / int(snapshot[round].btc) * 100);
        Token memory eth = Token("eth",(int(TokenPrice.getEth()) - int(snapshot[round].eth))*int(10**decimals) / int(snapshot[round].eth) * 100);
        Token memory xrp = Token("xrp",(int(TokenPrice.getXrp()) - int(snapshot[round].xrp))*int(10**decimals) / int(snapshot[round].xrp) * 100);
        Token memory wemix = Token("wemix",(int(TokenPrice.getKlay()) - int(snapshot[round].klay))*int(10**decimals) / int(snapshot[round].klay) * 100);
        Token memory klay = Token("klay",(int(TokenPrice.getWemix()) - int(snapshot[round].wemix))*int(10**decimals) / int(snapshot[round].wemix) * 100);
        Token memory ksp = Token("ksp",(int(TokenPrice.getKsp()) - int(snapshot[round].ksp))*int(10**decimals) / int(snapshot[round].ksp) * 100);
        Token memory bora = Token("bora",(int(TokenPrice.getBora()) - int(snapshot[round].bora))*int(10**decimals) / int(snapshot[round].bora) * 100);
        Token memory orc = Token("orc",(int(TokenPrice.getOrc()) - int(snapshot[round].orc))*int(10**decimals) / int(snapshot[round].orc) * 100);
        Token memory mbx = Token("mbx",(int(TokenPrice.getMbx()) - int(snapshot[round].mbx))*int(10**decimals) / int(snapshot[round].mbx) * 100);
        Token memory bnb = Token("bnb",(int(TokenPrice.getBnb()) - int(snapshot[round].bnb))*int(10**decimals) / int(snapshot[round].bnb) * 100);

        // 배열에 넣은 후
        tempRank = [btc,eth,xrp,klay,wemix,ksp,bora,orc,mbx,bnb];

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

    // 현재 라운드 확인
    function currentRound() public view returns(uint){
        return round;
    }

    // 현재 라운드 스냅샷 촬영 여부 확인
    function snapshotIsTaked() public view returns(bool){
        return isTaked[round];
    }

    // 해당 라운드의 티켓 수 보기
    function numberOfTicket(uint _round) public view returns(uint){
        return ticketCount[_round];
    }

    // 해당 라운드의 참가자들 보기 (.length => 참가자 수)
    function getBuyers(uint _round) public view returns(address[] memory){
        return buyers[_round];
    }

    // 해당 라운드 당첨 티켓들 보기
    function winningTickets(uint _round) public view returns(Ticket[] memory){
        return result[_round].winningTickets;
    }

    // 해당 라운드 총 상금 보기 (인당 상금 = 총 상금 / winningTickets(_round).length)
    function prizeAmount(uint _round) public view returns(uint){
        return result[_round].prizeAmount;
    }

    // ㅡㅡㅡㅡㅡㅡㅡ+) 2023-01-08ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ

    // (_who)의 (_round)라운드 티켓들 반환
    function whoseTickets(uint _round, address _who) public view returns(Ticket[] memory) {
        return ticketBox[_round][_who];
    }

    // (_who)의 모든 라운드 티켓 반환 (라운드로 오름차순 정렬된 배열이 리턴)
    function allWhoseTickets(address _who) public view returns(Ticket[] memory allTickets){
        // (_who)의 모든 티켓 수 세기
        uint acc=0;
        for (uint i=0 ; i < round+1 ; i++){
            acc += ticketBox[i][_who].length;
        }

        // (_who)의 티켓 수 만큼 반환할 메모리 배열의 크기를 지정
        allTickets = new Ticket[](acc);
 
        // 루프를 돌려 인덱스별로 하나씩 넣어줌
        uint acc2 = 0;
        for (uint i=0 ; i < round+1 ; i++){
            for (uint j=0 ; j < ticketBox[i][_who].length ; j++){
                allTickets[acc2] = ticketBox[i][_who][j];
                acc2++;
            }
        }
        
        return allTickets;
    }
    
    // 예기치 못한 오류 발생 대비 모든 balance 인출 함수
    function emergency() public onlyOwner payable{
        (bool success,) = payable(owner).call{value: address(this).balance}(""); 
        emit transferSuccessful(success, "emergency occured, sent all the balance to the owner."); 
    }
}