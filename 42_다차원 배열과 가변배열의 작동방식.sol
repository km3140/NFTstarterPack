// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

// +
// 이중배열 만드는 법? string[][]?
// 2차원 배열 시 다른 언어의 순서와 반대임 (예: array[1][2] → array[2][1]) ?
contract doubleArray{
  //❗ 선언할 때
  //    👇 안쪽배열
  string[4][] name; // 크기가 4인 string을 담는 배열을 담는 가변배열 name 선언
  //       👆 바깥쪽 배열

  //❗ 사용할 때 (선언할 때랑 반대로)
  function retrunDoubleArray() public returns(string memory){
    name.push(['a','b','c','d']);
  //            👇 바깥쪽 배열
    return name[1][3];
  //               👆 안쪽배열
  }
}



// +
// 크기가 정해진 배열에서, 인덱스를 지정하고 값을 직접 대입하려 하면 오류가 난다
// 크기가 정해진 배열은 기본적으로 push를 통해 값을 추가한다!!!
contract error{
    uint[] test;

    function returnArrayElement() public returns(uint){
        test[0]=123;
        return test[0]; // 에러가 뜸!
    }
}
// push로 배열의 길이가 늘어나면 늘어난 길이 만큼의 요소들은 인덱스를 지정해서 수정할 수 있음
contract success{
    uint[] test;

    function returnArrayElement() public returns(uint){
        test.push(1);
        test[0]=123;
        return test[0]; // 123을 성공적으로 리턴!
    }
}

// 2차원 배열도 마찬가지
contract error2{
  uint[4][] name;

  function retrunDoubleArray() public returns(uint){
    name[0]= [0,1,2,3];
    return name[0][1]; // 에러!!
  }
}
// 2차원 배열도 push로 배열의 길이가 늘어나면 늘어난 길이 만큼의 요소들은 인덱스를 지정해서 수정할 수 있음
contract success2{
  uint[4][] name;

  function retrunDoubleArray() public returns(uint){
    name.push([0,1,2,3]);
    name[0]= [11,22,33,44];
    return name[0][1]; // 성공적으로 22를 리턴!
  }
}