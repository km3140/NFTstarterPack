// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

// 스마트 콘트랙트에서 특정 상황을 디앱에 알려야 할 때 사용 (web3js)
// 솔리디티에는 print가 없음, event가 비슷한 역할을 함
// event로 값을 출력하면 그 값들은 블록 안에 저장


contract Event{
// 👇 event키워드 이벤트명(출력하고싶은 값들)   로 이벤트 선언
  event info(string name, uint256 money);

  function sendMoney() public{
    emit info("KimMinGwan",1000);
  }// 👆 emit키워드 이벤트명(인자)   로 이벤트 출력

}

// 👉 sendMoney 함수 실행 시 블록 내 logs에 아래와 같이 출력됨

    // "event": "info",
		// "args": {
		// 	"0": "KimMinGwan",
		// 	"1": "1000",
		// 	"name": "KimMinGwan",
		// 	"money": "1000"
		// }