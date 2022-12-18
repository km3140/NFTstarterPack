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
      // 에러체크
      if (err) {
        console.error(error);
      } else {
        console.log('*************************************');
        console.log('New Transaction Event');
        console.log('*************************************');
        getReceiptFindTransfer(result.transactionHash, type);
      }
    }
  );
}

// 리저브옥션 같은 경우엔 Subscribe만으로는 transfer의 이벤트를 가져오지 못하므로 같은 트렌젝션에 있는 transfer log를 가져오는 과정 추가
async function getReceiptFindTransfer(txid, type) {
  // 해당 트렌젝션 영수증 가져오기
  web3.eth.getTransactionReceipt(txid).then(result => {
    let logs = result.logs;
    for (const log of logs) {
      let topics = log.topics;
      // 0번째 토픽이 transfer라면~
      if (
        topic[0] == '0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef'
      ) {
        let token_id = topic[3];
        let new_owner = topic[2];
        let before_owner = topic[1];
        let contract_address = log.address;
        token_id = web3.utils.hexToNumberString(token_id);
        InsertToDB(contract_address, token_id, type, before_owner, new_owner);
      }
    }
  });
}

// 트렌젝션 영수증 예시(getTransactionReceipt의 result)
/*
  {
    blockHash: '0x43f34ae1b9cda49947a4b1001081356f80144d6ce2299ae7f959befe2125f55c',
    blockNumber: 10240861,
    contractAddress: null,
    cumulativeGasUsed: 1196178,
    from: '0xcdd6a2b9dd3e386c8cd4a7ada5cab2f1c561182d',
    gasUsed: 21000,
    logs: [], // 👈 이 값을 추출해 온 것
    logsBloom: '0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000',
    status: true,
    to: '0x142e6c18e62d1bdca2ce40c05c6ecb3e1af1848c',
    transactionHash: '0x663ae686dc57a55262704c8f1a8b133e1548fd0e32ae72d399630ad842d68be7',
    transactionIndex: 14
  }
*/
