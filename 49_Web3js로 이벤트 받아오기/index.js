// foundation이라는 nft마켓에서 transfer정보 실시간으로 받아오기

import Web3 from 'web3';
import Subscribe from './subscribe.js';

// 실시간으로 정보를 추출해야하므로 웹소켓 사용
const web3 = new Web3(
  new Web3.providers.WebsocketProvider(
    'wss://mainnet.infura.io/ws/v3/36ffd7ab3ab1420eb84c5ac8fc04d558'
  )
);

const foundation_token_address = '0x3B3ee1931Dc30C1957379FAc9aba94D1C48a5405';
const foundation_market_address = '0xcDA72070E455bb31C7690a170224Ce43623d0B6f';

// 토픽값 직접 입력
const transfer_topic =
  '0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef';

// 함수정보를통해 토픽값 생성
const market_list_topic = web3.utils.sha3(
  'ReserveAuctionCreated(address,address,uint256,uint256,uint256,uint256,uint256)'
);
const market_sold_topic = web3.utils.sha3(
  'ReserveAuctionFinalized(uint256,address,address,uint256,uint256,uint256)'
);

Subscribe(foundation_token_address, transfer_topic, 'TRANSFER'); // transfer 받아오기 (foundation에서 직접 발행한 nft인듯)
Subscribe(foundation_market_address, market_list_topic, 'TRANSFER'); // 리저브옥션 생성 시 transfer 받아오기
Subscribe(foundation_market_address, market_sold_topic, 'TRANSFER'); // 리저브옥션 체결 시 transfer 받아오기
