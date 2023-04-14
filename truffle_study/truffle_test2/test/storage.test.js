const AdvancedStorage = artifacts.require("AdvancedStorage");


contract("AdvancedStorage", ()=>{
// 👇 it("테스트이름", 테스트할 내용 가진 (비동기)콜백)
  it("should be array pushed at array", async () => {
    const smartContract = await AdvancedStorage.deployed()
    await smartContract.add(100)
    const result = await smartContract.get(0)

    console.log("ㅡㅡㅡㅡㅡㅡㅡㅡ1ㅡㅡㅡㅡㅡㅡㅡㅡ")
    console.log(result)
    console.log("ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ")
    console.log(typeof result)
    //               👆 키워드처럼 사용 가능
    console.log("ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ")

    // 👇 내장함수, require느낌?
    assert(result.toNumber() === 100, "wrong return value")
    //           👆 또는 .words[0]
  })

  it("should be returned array", async () => {
    const smartContract = await AdvancedStorage.deployed()
    await smartContract.add(50)
    const idsArr = await smartContract.getAll()
    const ids = idsArr.map(id=>id.toNumber())

    console.log("ㅡㅡㅡㅡㅡㅡㅡㅡ2ㅡㅡㅡㅡㅡㅡㅡㅡ")
    console.log(ids)// 👈 [100, 50]
    console.log("ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ")
    console.log(typeof ids) // 👈 object???
    console.log("ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ")

    assert.deepEqual(ids, [100,50], "wrong return value")
  })
})