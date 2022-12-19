// DB설치 없이 사용할 수 있게 함
import sqlite3 from 'sqlite3';

// 추출한 정보 DB에 INSERT
async function InsertToDB(
  contract_address,
  token_id,
  type,
  before_owner,
  new_owner
) {
  // 현재폴더 eth.db에 저장
  const db = new sqlite3.Database('./eth.db', (err) => {
    if (err) {
      console.error(err.message);
    }
  });

  db.run(
    'CREATE TABLE IF NOT EXISTS event(contract_address text,token_id text,type text,before_owner text,new_owner text)'
  );
  db.run(
    'INSERT INTO event(contract_address,token_id,type,before_owner,new_owner) VALUES (?,?,?,?,?)',
    [contract_address, token_id, type, before_owner, new_owner]
  );
  db.close();
}

export default InsertToDB;
