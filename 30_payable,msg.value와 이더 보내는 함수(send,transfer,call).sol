// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

contract Payable{
  //  payable은 이더/토큰과 상호작용 시 필요한 키워드
  //  send, transfer, call 을 이용하여 이더를 보낼 때 payable 키워드가 필요하다
  //  payable은 주로 함수, 주소, 생성자에 붙어서 사용됨

  //  msg.value는 송금 보낸 코인의 양을 나타내는 값

  /*
      이더를 보내는 3가지 함수
        1.send: 2300gas를 소비, 성공여부를 boolean으로 리턴
        2.transfer : 2300gas를 소비, 실패 시 에러를 발생
        3.call : 가변적인 gas 소비 (gas값 지정 가능), 성공여부를 boolean으로 리턴
                 재진입(reentrancy) 공격 위험성 있음, 그러므로 Check-Effects-Interactions pattern을 사용해서 보완함
    
        기존에는 transfer 사용을 추천했지만, 이스탄불 하드포크 이후 operation code의 가스비가 올라서 call 사용을 추천.
        ㄴ> 가스비가 유동적인 상황에서 send와 transfer를 쓰는 함수는 가스비가 2300을 넘어가게 되면 실패하게 됨.
  */

  event howMuch(uint256 _value); // 👈 성공 시 몇 이더가 전송됐는지 알려줄 event

//                 👇 전송 받을 주소에 payable    👇 전송하는 함수에도 payable
  function sendNow(address payable _to) public payable{
    // 👇 send는 성공여부를 boolean으로 반환함
    bool sent = _to.send(msg.value);
    //                    👆 보낼 이더의 양, 다른 인터페이스에서 입력하는 듯
    require(sent,"Failed to send either");
    //      👆 send는 자체적으로 오류를 낼 수 없어서 sent의 boolean값을 보고 오류를 따로 내줌
    emit howMuch(msg.value);
  }//      👆 성공 시 미리 지정해놓은 이벤트로 전송한 이더 수량을 담은 이벤트 발생

  function transferNow(address payable _to) public payable{
    _to.transfer(msg.value); // 👈 transfer는 실패 시 자체적으로 오류를 내주기 때문에 따로 require를 써주지 않음
    emit howMuch(msg.value);
  }

  function callNow(address payable _to) public payable{
    // ~ 0.7
    // (bool sent,) = _to.call.gas(1000).value(msg.value)("");
    // require(sent,"Failed to send either");


    // 0.7 ~
    // 👇 Distructuring Assignment인 듯                 👇 이후에 call은 따로 자세히 알아보자
    (bool sent,)=_to.call{value: msg.value, gas:1000}("");
    //                                        👆 가스를 지정해 줄 때   ,gas:1000 생략하면 가스 자동설정?
    //          👆 boolean이외에 byte 값을 반환한다고 함
    require(sent,"Failed to send either");
    emit howMuch(msg.value);
  }
}