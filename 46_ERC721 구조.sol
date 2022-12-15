// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.1;

contract ERC721{

  string private _name;
  string private _symbol;

  // 이미지의 url을 기록할 매핑
  // ipfs의 주소가 들어감 => 직접 ipfs노드를 돌리거나 pinata를 씀
  mapping(uint256 => string) private _tokenInfo;

  mapping(uint256 => address) private _owners; // n번째 nft를 누가 갖고있는지
  mapping(address => uint256) private _balances; // 해당 nft를 몇 개 갖고있는가
  mapping(uint256 => address) private _tokenApprovals; // erc20의 allowances같은 개념인 듯? nft 담보 맡길 때?
  mapping(address => mapping(address => bool)) private _operatorApprovals; // ??

  uint private totalSupply;

  event Transfer(address from, address to, uint tokenId);
  event Approval(address from, address to, uint tokenId);
  // nft는 보통 외부 컨트랙트(opensea)에 의해 거래되는데 from의 모든 nft를 특정 주소가 아닌 누구에게나 옮길 수 있는 권한이 필요하다
  event ApprovalForAll(address from, address operator, bool approval);

  constructor(string memory name_, string memory symbol_){
    _name = name_;
    _symbol = symbol_;
  }

  function balanceOf(address owner) public view returns(uint256){
    return _balances[owner];
  }

  // tokenId번째 nft의 주인 반환 함수?
  function ownerOf(uint256 tokenId) public view returns(address){
    return _owners[tokenId];
  }

  function name() public view returns(string memory){
    return _name;
  }

  function symbol() public view returns(string memory){
    return _symbol;
  }

  // nft의 이미지 위치를 가져오는 함수
  function tokenURI(uint256 tokenId) public view returns(string memory){
    return _tokenInfo[tokenId];
  }

  // tokenId번째 nft가 어떤 주소에게 허용되었는지
  function getApproved(uint256 tokenId) public view returns(address){
    return _tokenApprovals[tokenId];
  }

  // owner의 nft들이 operator에게 허용되었는지 bool값으로 나타냄
  function isApprovedForAll(address owner, address operator) public view returns(bool){
    return _operatorApprovals[owner][operator];
  }

  function transferFrom(
    address from,
    address to,
    uint256 tokenId
  ) public {
    address owner = _owners[tokenId];
    // 토큰 주인이 sender || sender가 operator인가 || sender가 tokenId번째 nft의 권한이 있는가
    require(msg.sender == owner || isApprovedForAll(from, msg.sender) || getApproved(tokenId) == msg.sender, "Not Approved");
    //      ^^^^^^^^^^^^^^^^^^ == ( msg.sender == from )???

    delete _tokenApprovals[tokenId]; // 다음 소유자를 위해 삭제
    _balances[from] -= 1;
    _balances[to] += 1;
    _owners[tokenId] = to; // 소유자 변경    
  }

  function mint(address to, uint256 tokenId, string memory url) public{
    _balances[to] += 1;
    _owners[tokenId] = to;
    _tokenInfo[tokenId] = url;
    totalSupply += 1;
    emit Transfer(address(0), to, tokenId);
  }

  // 랜덤 생성
  function ramdomNFT(uint maxValue) public returns(uint){
    return uint(keccak256(abi.encodePacked(msg.sender, block.timestamp, totalSupply))) % maxValue;
  }

  function burn(uint256 tokenId) public {
    address owner = _owners[tokenId];
    require( msg.sender == owner );
    delete _tokenApprovals[tokenId]; // 다음 소유자를 위해 지워줌
    _balances[owner] -= 1;
    delete _owners[tokenId]; // 소유권 삭제

    emit Transfer(owner, address(0), tokenId);
  }

  function transfer(address to, uint256 tokenId) public {
    require(_owners[tokenId] == msg.sender, "Incoreect Owner"); // 보내는 사람이 해당 nft의 소유자가 맞는지 체크
    delete _tokenApprovals[tokenId]; // 다음 소유자를 위해 삭제
    _balances[msg.sender] -= 1;
    _balances[to] += 1;
    _owners[tokenId] = to; // 소유자 변경

    emit Transfer(msg.sender, to, tokenId);
  }

  function approve(address to, uint256 tokenId) public{
    require(_owners[tokenId] == msg.sender, "your not owner");
    _tokenApprovals[tokenId] = to;
    emit Approval(msg.sender, to, tokenId);
  }

  // owner 소유의 모든 nft의 권한을 operator에게 허용
  function setApprovalForAll(
    address owner,
    address operator,
    bool approved
  ) public {
    require(msg.sender == owner);
    _operatorApprovals[owner][operator] = approved;
    emit ApprovalForAll(owner, operator, approved);
  }

}


// ERC1155 = ERC20 + ERC721;