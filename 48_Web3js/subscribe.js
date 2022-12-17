import Web3 from 'web3';
const web3 = new Web3(
  new Web3.providers.WebsocketProvider(
    'wss://mainnet.infura.io/ws/v3/36ffd7ab3ab1420eb84c5ac8fc04d558'
  )
);

function Subscribe(contract_address, topic, type) {
  // subscribe = 실시간 정보 필터링해서 받아오는 함수?
  web3.eth.subscribe(
    'logs',
    {
      // 컨트랙트 주소와 함수 토픽값으로 필터링
      address: contract_address,
      topic: [topic],
    },
    (err, result) => {
      if (err) {
        // 에러체크
        console.error(error);
      } else {
      }
    }
  );
}

// 리저브옥션 같은 경우엔 transfer의 이벤트를 가져오지 못하므로 가져오는 과정 추가
