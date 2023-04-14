var helloWorld = artifacts.require("helloWorld");

contract("helloWorld", (accounts)=>{
  console.log(accounts)
  it("should be returned Hello World", async () => {
    const smartContract = await helloWorld.deployed()
    const hello = await smartContract.hello()
    assert(hello === "blablabla", "wrong return value")
  })
})