const getUser = `SELECT
	  u.id AS id,
	  u.username,
	  u.password,
	  u.nama,
	  u.id_role,
      u.id_cabang,
	  r.kode AS kode_role,
	  c.kode AS kode_cabang,
	  c.nama AS nama_cabang,
	  c.alamat AS alamat_cabang
FROM
	  m_user u
JOIN m_cabang c ON u.id_cabang = c.id
JOIN m_role r ON u.id_role = r.id
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


const getItem = `
SELECT
		i.id AS id,
		i.kode,
		i.nama,
		i.hpp,
		i.hjl,
		i.id_satuan,
		s.nama AS nama_satuan,
		i.id_jenis_item,
		j.nama AS jenis_item
FROM m_item i
JOIN m_satuan s ON i.id_satuan = s.id
JOIN m_jenis_item j ON i.id_jenis_item = j.id
ORDER BY i.id DESC;
`;

const getItemCabang = `
SELECT
	ic.id AS id,
	ic.id_item,
	i.kode AS kode,
	i.nama AS nama,
	i.hpp AS hpp,
	i.hjl AS hjl,
	i.id_satuan,
	s.nama AS nama_satuan,
	i.id_jenis_item,
	j.nama AS jenis_item,
	ic.id_cabang,
	nc.kode AS kode_cabang,
	nc.nama AS nama_cabang,
	ic.stok_awal,
	ic.stok_akhir
	
FROM m_item_cabang ic
	
JOIN m_item i ON ic.id_item = i.id
JOIN m_satuan s ON i.id_satuan = s.id
JOIN m_jenis_item j ON i.id_satuan = j.id
JOIN m_cabang nc ON ic.id_cabang = nc.id
WHERE nc.kode = $1
ORDER BY ic.id ASC
`;

const getTransIn = `
	SELECT 
	c.kode AS kode_cabang,
    c.nama AS nama_cabang,
    t.no_faktur,
    t.tanggal,
    i.kode AS kode_item,
	i.nama AS nama_item,
	i.hpp,
    td.harga,
    td.qty,
    td.subtotal,
	s.nama AS nama_satuan,
	j.nama AS jenis_item,
    t.keterangan
	
FROM 
    t_trans_in t
JOIN 
    t_trans_in_detail td ON t.id = td.id_transaksi
JOIN 
    m_item_cabang ic ON td.id_item_cabang = ic.id
JOIN 
    m_item i ON ic.id_item = i.id
JOIN 
    m_cabang c ON ic.id_cabang = c.id
JOIN
	m_satuan s ON i.id_satuan = s.id 
JOIN
	m_jenis_item j ON i.id_jenis_item = j.id
WHERE
	c.kode = $1
AND
	t.tanggal BETWEEN $2 AND $3
ORDER BY		
    t.tanggal ASC;
	
`;

const getTransReceipt = `
	SELECT 
	c.kode AS kode_cabang,
    c.nama AS nama_cabang,
    t.docno,
    t.tanggal,
    i.kode AS kode_item,
	i.nama AS nama_item,
    td.qty,
	s.nama AS nama_satuan,
	j.nama AS jenis_item,
    t.keterangan
	
FROM 
    t_receipt t
JOIN 
    t_receipt_detail td ON t.id = td.id_transaksi
JOIN 
    m_item_cabang ic ON td.id_item_cabang = ic.id
JOIN 
    m_item i ON ic.id_item = i.id
JOIN 
    m_cabang c ON ic.id_cabang = c.id
JOIN
	m_satuan s ON i.id_satuan = s.id 
JOIN
	m_jenis_item j ON i.id_jenis_item = j.id
WHERE
	c.kode = $1
AND
	t.tanggal BETWEEN $2 AND $3
ORDER BY		
    t.tanggal ASC;
`;




module.exports = {
    getUser,
    getUserLogin,
	getItem, getItemCabang,
	getTransIn, getTransReceipt
}