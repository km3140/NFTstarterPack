// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.17;

contract DataType {
/*
  솔리디티에서의 8가지 데이터타입
    값 타입 : stack 에서 관리
      bool
      int
      uint
      address
    참조 타입 : 자유로운 크기의 공간(memory?heap?)에 저장해놓고 stack에는 그 공간의 참조값만 저장
      string
      array
      struct
      mapping
*/

//    bool
//     일반적인 boolean, true false를 저장함

//   int
//     정수를 저장함
//     int와 uint(unsigned int)가 있음, uint는 양의 정수만을 저장
//       int8 = -128 ~ 127 (256개)
//       uint8 = 0 ~ 255 (256개)
//     바이트 수를 명시해서 저장공간을 정할 수 있음, 생략 시 256byte
//       int8 int16 int32 int64 int128 int256(int)
    
//   (new!) address
//     계정 주소를 담기 위해 설계된 자료형!, 20바이트의 데이터를 담을 수 있음

//   string
//     문자열 저장
//     숫자, 논릿값, 주소 형태도 ' or " 로 감싸면 string 타입으로 인식
// 
//  array
//    "같은 타입의" 데이터를 연속적으로 저장할 때 사용
//    ex)
        uint[] arrUint = [1,2,3];
        // 👆 arrUint라는 이름의 uint256으로 된 배열을 선언하고 1,2,3을 넣었음

        function add(uint num) public{
          arrUint.push(num); //num 값을 arrUint 배열의 마지막에 추가
        }

        function sub() public {
          arrUint.pop(); // arrUint 배열의 마지막 요소 제거
        }

        function get(uint idx) public view returns(uint,uint){
          uint lastItem = arrUint[idx]; // 인덱스를 사용해서 arrUint 배열 값 가져오기
          return(lastItem,arrUint.length); // 가져온 값과 arrUint 배열 길이 반환
        }


//  mapping
//    키와 키의 값을 쌍으로 저장하는 타입
//    .length 사용 못함
//    몇 개의 키-값 쌍이 담겨 있는지 알 수 없으므로 별도의 변수를 만들어 관리해야함
//    존재하지 않는 키에 접근하면 0 반환
//    ex)
        mapping(address => uint) balance;
        // 👆 mapping(키의 타입 => 키 값의 타입)매핑이름;  으로 선언

        function seBalance(address _arr, uint _n) public{
          balance[_arr] = _n; // balance에 _arr=>_n 쌍 추가, _arr키가 이미 있다면 값 수정
        }


//  struct
//    새로운 타입을 만들 때 사용
//    ex)
        struct Person {
          string name;
          uint age;
        }
        // 👆 string 타입의 name, uint 타입의 age를 속성으로 가지는 Person이라는 새로운 타입(구조체)를 생성함

        Person p1; // person 타입의 p1 변수 선언

        function setP(string memory param1, uint param2) public{
          p1 = Person(param1,param2); // 순서대로 param1=>name, param2=>age 할당
        }

        function getP() public returns(string memory, uint) {
          return (p1.name,p1.age); // p1의 이름과 나이를 반환
        }

        Person[] persons;
        mapping (address=>Person) p;
        // 👆 배열이나 매핑에도 사용 가능


//  ❗enum (열거형)
//    연속된 정수로 상태를 관리하는 타입
//    상태 변화를 나타내는데 유용함
//    ex)
        enum Color {red,green,orange}
        // 👆 red->0, green->1, orange->2
        Color public trafficLight; // 초기값은 0

        function setState(Color _c) public { // 0,1,2 이외의 값을 전달하면 에러 발생
          trafficLight = _c; 
        }

        function getState() public view returns(Color){
          return trafficLight;
        }

        function setOrange() public {
          trafficLight = Color.orange; // 2가 들어감
        }

        function reset() public{
          delete trafficLight; // trafficLight의 상태를 0으로 초기화
        }
}