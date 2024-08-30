const getUser = `SELECT
	  u.id AS id,
	  u.username,
	  u.password,
	  u.nama,
	  u.id_role,
      u.id_cabang,
	  c.kode AS kode_cabang,
	  c.nama AS nama_cabang,
	  c.alamat AS alamat_cabang
FROM
	  m_user u
JOIN m_cabang c ON u.id_cabang = c.id
ORDER BY
	u.id ASC;
`;


const getUserLogin = `SELECT
	  u.id AS id,
	  u.username,
	  u.password,
	  u.id_role,
	  u.nama,
      u.id_cabang,
	  c.kode AS kode_cabang,
	  c.nama AS nama_cabang,
	  c.alamat AS alamat_cabang
FROM
	  m_user u
JOIN m_cabang c ON u.id_cabang = c.id
WHERE u.username = $1 AND u.password = $2;
`;
module.exports = {
    getUser,
    getUserLogin
}