// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

  /*
    0.6 버전 이후
    try/catch 왜 써야하는가?
      기존의 에러핸들러는 에러를 발생시키고 프로그램을 끝냄.
      그러나, try/catch로 에러가 났어도, 프로그램을 종료시키지 않고 예기치 못한 에러에 대처할 수 있게 만듬

    try/catch 특징
      1. try/catch문 안에서 assert,revert,require을 통해 에러가 난다면 개발자의 의도로 판단하여 catch로 에러를 잡지 않고 에러를 발생시킴 (89번째 줄 참조)
      2. try/catch문 밖에서?('검사할 명령 안에서'인 듯?, try 옆에 있는)

    3가지 catch
      1. catch Error(string memory 에러메세지) { ... } : revert나 require을 통해 생성된 에러를 잡음
      2. catch Panic(uint 에러코드) { ... } : assert를 통해 생성된 에러(Panic, assert()함수이외에도 발생할 수 있음)를 잡음
        👆 에러코드는 솔리디티에서 정의된 Panic 에러의 종류별로 나옴, 26_번째 파일 참조
      3. catch (bytes memory _errCode) { ... } : 로우레벨에러를 잡음
      + catch { ... } : 모든 오류를 잡음

    어디서 쓰는가?
      1. 외부 컨트랙 함수를 부를 때 : 다른 컨트랙을 인스턴스화, 상속을 해서 얻은 함수를 try/catch문에 적용
      2. 외부 컨트랙을 생성 할 때 : 다른 컨트랙의 인스턴스를 생성하는 line 자체를 try/catch에 적용
      3. 컨트랙 내부 함수를 부를 때 : this를 통해 try/catch에 적용
  */


// 1. 외부 컨트랙 함수를 부를 때
contract math{
  
  function division(uint256  _num1, uint256 _num2) public pure returns(uint256){
    require(_num1<10,"num1 should not be more than 10");
          // 👆 _num1이 10보다 작지 않으면 오류
    return _num1/_num2;
  }

}

contract runner{

  event catchErr(string _name, string _err); // 👈 revert,require로 일어난 오류를 잡고 난 뒤 emit할 event
  event catchPanic(string _name, uint256 _err); // 👈 Panic류의 오류를 잡고 난 뒤 emit할 event
  event catchLowLevelErr(string _name, bytes _err); // 👈 로우레벨에러를 잡고 난 뒤 emit할 event

  math public mathInstance = new math(); // 👈 math의 인스턴스를 생성

  function playTryCatch(uint256 _num1, uint256 _num2) public returns(uint256,bool){
                                                  // 👇 mathInstance.division()의 return값을 uint의 value로 받음
    try mathInstance.division(_num1, _num2) returns(uint256 value){
      return(value,true); // 👈 성공적으로 실행 시 value와 true를 반환 (playTryCatch의 반환값)
    } catch Error(string memory _err) { // 👈 mathInstance.division 에서 revert,require이 발생했을 때 실행
                              // 👆 revert/require에서 설정한 에러메세지가 들어감
      emit catchErr("revert/require", _err); // math 콘트랙트의 division에 revert/require를 넣어서 발생시켜 볼 수 있음
      return(0,false);
    } catch Panic(uint256 _errCode) { // 👈 assert/Panic이 발생했을 때 실행
                  // 👆 Panic의 에러코드, 예를들어 _num1에 0이 들어갔을 때 18(0x12)이 들어감
      emit catchPanic("assertError/Panic",_errCode);
      return(0,false);
    } catch (bytes memory _errCode) { // 👈 로우레벨에러가 발생했을 시 실행
      emit catchLowLevelErr("LowLevelError",_errCode);
      return(0,false);
    }
  }

}

  // 2. 외부 컨트랙을 생성할 때
contract character{

  string private name;
  uint256 private power;

  constructor(string memory _name, uint256 _power){
    // revert("intentional error");  👈 runner2의 catch가 발동하게 됨
    name = _name;
    power = _power;
  }

}

contract runner2{

  event catchOnly(string _name, string _err);

  function playTryCatch(string memory _name, uint256 _power) public returns(bool){
    try new character(_name, _power){
    // revert("intentional error");  👈 try안에서 난 오류는 catch로 넘어가지 않고 오류를 일으킴
      return(true);
    } catch{
      emit catchOnly("catch","Error Message");
      return(false);
    }
  }
}

// 3. 컨트랙 내부 함수를 부를 때
contract runner3{
  
  event catchOnly(string _name, string _err);

  function simple() public pure returns(uint256){
    return 4;
  }

  function playTryCatch() public returns(uint,bool){
    try this.simple() returns(uint256 _value){
      // 👆 this를 붙이지 않으면 오류가 남
      //    TypeError: Try can only be used with external function calls and contract creation calls.
      //    즉 try는 외부의 함수의 호출이나 외부의 컨트랙 생성에만 적용할 수 있음!
      return (_value,true);
    }catch{
      emit catchOnly("catch","Error Message");
      return (0,false);
    }
  }
}
