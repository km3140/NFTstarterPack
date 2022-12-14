// SPDX-License-Identifier: MIT

pragma solidity ^0.8.1;

// ERC20 함수들 뜯어보기

contract ERC20 {
  //ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ기본 ERC20 ICO 기능ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ

  mapping(address => uint) private _balances; // 유저별 토큰 잔액 기록
  mapping(address => mapping(address => uint)) _allowances; // 허용한 사람 => 허용 받은 사람 => 허용해준 양
  uint private _totalSupply; // 총 토큰량
  string private _name; // 토큰 이름
  string private _symbol; // 토큰 심볼 
  uint8 private _decimals; // 소수점 자리 수 (이더는 18, 테더는 6)

  // transfer 실행 시 emit 할 이벤트
  event Transfer(address indexed from, address indexed to, uint amount);
  // approval 실행 시 emit 할 이벤트
  event Approval(address indexed from, address indexed to, uint amount);

  modifier checkBalance(uint amount){
    require (_balances[msg.sender] > amount, "Not Sufficient Balance"); // 보낼 양보다 잔액이 많은지 체크
    _;
  }

  constructor(string memory _name_, string memory _symbol_, uint8 _decimals_){
    _name = _name_;
    _symbol = _symbol_;
    _decimals = _decimals_;
    _totalSupply = 10000000 * (10**_decimals);
    owner = msg.sender;
  }

  function name() public view returns (string memory){
    return _name;
  }

  function symbol() public view returns (string memory){
    return _symbol;
  }

  function decimals() public view returns (uint8){
    return _decimals;
  }

  function totalSupply() public view returns (uint256){
    return _totalSupply;
  }

  function balanceOf(address account) public view returns (uint256) {
    return _balances[account]; // account의 토큰 잔액 확인
  }

  // 내가 발행한 토큰의 transfer
  function transfer(address to, uint256 amount) public checkBalance(amount) checkBlackList returns(bool) { 

    _balances[msg.sender] -= amount; // sender의 balance에서 amount 만큼 빼서
    _balances[to] += amount; // to의 balance에 더함

    emit Transfer(msg.sender, to, amount);
    return true;
  }

  function allowance(address owner, address spender) public view returns (uint256){
    return _allowances[owner][spender];
  }

  function approve(address spender, uint256 amount) public checkBalance(amount) checkBlackList returns(bool){
    _allowances[msg.sender][spender] = amount; // sender가 spender에게 amount만큼 잔액 인출을 허용
    emit Approval(msg.sender, spender, amount);
    return true;
  }

  function transferFrom(
    address from,
    address to,
    uint256 amount
  ) public checkBalance(amount) checkBlackList returns(bool){

    require(_allowances[from][to] >= amount,"Not Allowed Amount"); // 허용한 금액보다 같거나? 커야함
    require(to == msg.sender, "Not Allowed User"); // _allowances에 등록된 허용받은 사람이 맞는지 확인

    // transfer
    _balances[msg.sender] -= amount; 
    _balances[to] += amount; 

    emit Transfer(msg.sender, to, amount);
    return true;
  }


  //ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ추가적인 기능ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ

  address public owner;

  // 블랙리스트 기록 매핑
  mapping (address => bool) private _blackList;

  modifier onlyOwner {
    require(owner == msg.sender, "Only Owner!");
    _;
  }

  // 함수 실행 시 블랙리스트 확인
  modifier checkBlackList{
    require(!_blackList[msg.sender] == true, "Ban User");
    _;
  }

  // 토큰 추가민팅
  function mint(address to, uint amount) public onlyOwner{
    _balances[to] += amount;
    _totalSupply += amount; 
  }

  // 관리자용 소각 함수
  function burn(address to, uint amount) public onlyOwner{
    _balances[to] -= amount; // 사용자 to의 잔액에서 소각
    _totalSupply -= amount; // 소각한만큼 총 발행량 감소
  }

  // 유저용 소각 함수
  function burnByUser(uint amount) public onlyOwner{
    transfer(address(0), amount); // address(0)으로 amount만큼 토큰을 보냄 == 소각
    _totalSupply -= amount; // 소각한만큼 총 발행량 감소
  }

  // 블랙리스트 등록
  function setBlackList(address to) public onlyOwner{
    _blackList[to] = true;
  }
}