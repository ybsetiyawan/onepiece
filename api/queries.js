const Pool = require('pg').Pool;
const { request, response } = require('express');
const pgqueries = require('./pgqueries');

const pool = new Pool({
    user: 'postgres',
    host: 'localhost',
    // host: '103.31.38.210',
    database: 'db_onepiece',
    password: 'pakepake',
    port: 5432,
});

const getSatuan = (request, response) => {
    pool.query('SELECT * FROM m_satuan ORDER BY id ASC', (error, results) =>{
        if (error){
            throw error
        }
        response.status(200).json(results.rows)
    })
}

const addSatuan = (request, response) => {
    const {nama} = request.body
    pool.query('INSERT INTO m_satuan (nama) VALUES ($1)', [nama], (error, results) => {
        if (error){
            console.log(error);
            response.status(500).send('Internal Server Error');
        }
        response.status(201).send('Data berhasil ditambahkan')
    })
}

const editSatuan = (request, response) => {
    const id = request.params.id;
    const {nama} = request.body
    pool.query('UPDATE m_satuan SET nama = $1 WHERE id = $2', [nama, id], (error, results) => {
        if (error){
            console.log(error);
            response.status(500).send('Internal Server Error');
        }
        response.status(200).send('Data berhasil diubah')
     })
    }

const deleteSatuan = (request, response) => {
    const id = request.params.id
    pool.query('DELETE FROM m_satuan WHERE id = $1', [id], (error, results) => {
        if (error){
            console.log(error);
            response.status(500).send('Internal Server Error');
        }
        response.status(200).send('Data berhasil dihapus')
    })
}

const getJenisItem = (request, response) => {
    pool.query('SELECT * FROM m_jenis_item ORDER BY id ASC', (error, results) =>{
        if (error){
            throw error
        }
        response.status(200).json(results.rows)
    })
}

const addJenisItem = (request, response) => {
    const {nama} = request.body
    pool.query('INSERT INTO m_jenis_item (nama) VALUES ($1)', [nama], (error, results) => {
        if (error){
            console.log(error);
            response.status(500).send('Internal Server Error');
        }
        response.status(201).send('Data berhasil ditambahkan')
    })
}

const editJenisItem = (request, response) => {
    const id = request.params.id;
    const {nama} = request.body
    pool.query('UPDATE m_jenis_item SET nama = $1 WHERE id = $2', [nama, id], (error, results) => {
        if (error){
            console.log(error);
            response.status(500).send('Internal Server Error');
        }
        response.status(200).send('Data berhasil diubah')
     })
    }

const deleteJenisItem = (request, response) => {
    const id = request.params.id
    pool.query('DELETE FROM m_jenis_item WHERE id = $1', [id], (error, results) => {
        if (error){
            console.log(error);
            response.status(500).send('Internal Server Error');
        }
        response.status(200).send('Data berhasil dihapus')
    })
}


const getItemCabang = (request, response) => {
    const { kode_cabang } = request.query;
    pool.query(pgqueries.getItemCabang,[kode_cabang], (error, results) => {
        if (error){
            throw error
        }
        response.status(200).json(results.rows)
    })
}

// const addItemCabang = (request, response) => {
//     const { id_item, id_cabang, stok_awal, stok_akhir } = request.body
//     pool.query('INSERT INTO m_item_cabang (id_item, id_cabang, stok_awal, stok_akhir) VALUES ($1, $2, $3, $4)',
//         [id_item, id_cabang, stok_awal, stok_akhir], (error, result) => {
//             if(error) {
//                 console.log(error);
//                 response.status(500).send('Internal Server Error');;
//             }
//             response.status(201).send('Data berhasil ditambahkan');
//         }
//     ) 

// }

const formatDate = (date) => {
    const pad = (n) => n < 10 ? '0' + n : n;
    return date.getFullYear() + '-' +
           pad(date.getMonth() + 1) + '-' +
           pad(date.getDate()) + ' ' +
           pad(date.getHours()) + ':' +
           pad(date.getMinutes()) + ':' +
           pad(date.getSeconds());
};

const addItemCabang = async (request, response) => {
    const { id_item, id_cabang, stok_awal, stok_akhir } = request.body;
    const client = await pool.connect();
    try {
        await client.query('BEGIN');
        // insert into m_item_cabang
        const insertItemCabangQuery = 'INSERT INTO m_item_cabang (id_item, id_cabang, stok_awal, stok_akhir) VALUES ($1, $2, $3, $4) RETURNING id';
        const result = await client.query(insertItemCabangQuery, [id_item, id_cabang, stok_awal, stok_akhir]);
        const id_item_cabang = result.rows[0].id;

        // insert into stok_harian
        const insertStokHarianQuery = 'INSERT INTO stok_harian (tanggal, id_item_cabang, stok_awal, stok_akhir, perubahan_stok, transtp, transfrom) VALUES ($1, $2, $3, $4, $5, $6, $7)';
        const currentDate = new Date();
        await client.query(insertStokHarianQuery,[formatDate(currentDate), id_item_cabang, stok_awal, stok_akhir, stok_akhir - stok_awal, 'NULL', 'NULL']);

        await client.query('COMMIT');
        response.status(201).send('Data berhasil ditambahkan');
        
    } catch (error) {
        await client.query('ROLLBACK');
        console.log(error);
        response.status(500).send('Internal Server Error');
    } finally {
        client.release();
    }
}


const getItem = (request, response) => {
    pool.query(pgqueries.getItem, (error, results) => {
        if (error) {
            throw error
        }
        response.status(200).json(results.rows)
    })
}


const addItem = (request, response) => {
    const {kode, nama, hpp, hjl, id_satuan, id_jenis_item} = request.body
    pool.query('INSERT INTO m_item (kode, nama, hpp, hjl, id_satuan, id_jenis_item) VALUES ($1, $2, $3, $4, $5, $6)',
        [kode, nama, hpp, hjl, id_satuan, id_jenis_item], (error, results) => {
        if (error){
            console.log(error);
            response.status(500).send('Internal Server Error');
        }
        response.status(201).send('Data berhasil ditambahkan')
    })
}

const editItem = (request, response) => {
    const {kode, nama , hpp, hjl, id_satuan, id_jenis_item} = request.body
    pool.query('UPDATE m_item SET nama = $1, hpp = $2, hjl = $3, id_satuan = $4, id_jenis_item = $5 WHERE kode = $6',
        [nama, hpp, hjl, id_satuan, id_jenis_item, kode], (error, results) => {
        if (error){
            console.log(error);
            response.status(500).send('Internal Server Error');
        }
        response.status(200).send('Data berhasil diubah')
     })
    }

const deleteItem = (request, response) => {
    const id = request.params.id
    pool.query('DELETE FROM m_jenis_item WHERE id = $1', [id], (error, results) => {
        if (error){
            console.log(error);
            response.status(500).send('Internal Server Error');
        }
        response.status(200).send('Data berhasil dihapus')
    })
}



const getCabang = (request, response) => {
    pool.query('SELECT * FROM m_cabang ORDER BY kode ASC', (error, results) =>{
        if (error){
            throw error
        }
        response.status(200).json(results.rows)
    })
}

const addCabang = (request, response) => {
    const { kode, nama, alamat, telp } = request.body
    pool.query('INSERT INTO m_cabang (kode, nama, alamat, telp) VALUES ($1, $2, $3, $4)', [kode, nama, alamat, telp], (error, results) => {
        if (error){
            console.log(error);
            response.status(500).send('Internal Server Error');
        }
        response.status(201).send('Data berhasil ditambahkan')
    })
}

const editCabang = (request, response) => {
    const { kode, nama, alamat, telp } = request.body
    pool.query('UPDATE m_cabang SET nama = $1, alamat = $2, telp = $3 WHERE kode = $4', [nama, alamat, telp, kode], (error, results) => {
        if (error){
            console.log(error);
            response.status(500).send('Internal Server Error');
        }
        response.status(200).send('Data berhasil diubah')
     })
    }

const deleteCabang = (request, response) => {
    const id = request.params.id
    pool.query('DELETE FROM m_cabang WHERE id = $1', [id], (error, results) => {
        if (error){
            console.log(error);
            response.status(500).send('Internal Server Error');
        }
        response.status(200).send('Data berhasil dihapus')
    })
}

// m_role
const getRole = (request, response) => {
    pool.query('SELECT * FROM m_role', (error, results) => {
        if (error){
            throw error
        }
        response.status(200).json(results.rows)
    })
}

const addRole = (request, response) => {
    const {kode, nama} = request.body
    pool.query('INSERT INTO m_role (kode, nama) VALUES ($1, $2)', [kode, nama], (error, results) => {
        if (error){
            console.log(error);
            response.status(500).send('Internal Server Error');
        }
        response.status(201).send('Data berhasil ditambahkan')
        })
    }

const editRole = (request, response) => {
    const {kode, nama} = request.body
    pool.query('UPDATE m_role SET nama = $1 WHERE kode = $2', [nama, kode], (error, results) => {
        if (error){
            console.log(error);
            response.status(500).send('Internal Server Error');
        }
        response.status(200).send('Data berhasil diubah')
        })
    }

const deleteRole = (request, response) => {
    const id = request.params.id
    pool.query('DELETE FROM m_role WHERE id = $1', [id], (error, results) => {
        if (error){
            console.log(error);
            response.status(500).send('Internal Server Error');
        }
        response.status(200).send('Data berhasil dihapus')
        })
    }

// m_user
const getUser = (request, response) => {
    pool.query(pgqueries.getUser, (error, results) => {
        if (error){
            throw error
        }
        response.status(200).json(results.rows)
        })
    }

const addUser = (request, response) => {
    const {username, password, id_role, id_cabang, nama} = request.body
    pool.query('INSERT INTO m_user (username, password, id_role, id_cabang, nama) VALUES ($1, $2, $3, $4, $5)', [username, password, id_role, id_cabang, nama], (error, results) => {
        if (error){
            console.log(error);
            response.status(500).send('Internal Server Error');
        }
        response.status(201).send('Data berhasil ditambahkan')
        })
    }

const editUser = (request, response) => {
    const id = request.params.id
    const {username, password, id_role, id_cabang, nama} = request.body
    pool.query('UPDATE m_user SET username = $1, password = $2, id_role = $3, id_cabang = $4, nama = $5 WHERE id = $6', [username, password, id_role, id_cabang, nama, id], (error, results) => {
        if (error){
            console.log(error);
            response.status(500).send('Internal Server Error');
        }
        response.status(200).send('Data berhasil diubah')
        })
    }

const deleteUser = (request, response) => {
    const id = request.params.id
    pool.query('DELETE FROM m_user WHERE id = $1', [id], (error, results) => {
        if (error){
            console.log(error);
            response.status(500).send('Internal Server Error');
        }
        response.status(200).send('Data berhasil dihapus')
        })
    }




//login
const login = (request, response) => {
    const username = request.body.username;
    const password = request.body.password;

    const query = pgqueries.getUserLogin;

    pool.query(query, [username, password], (err, result) => {
        if (err) { // Menangani kesalahan query
            console.error('Query error:', err); // Log kesalahan untuk debugging
            return response.status(500).send('Internal Server Error');
        }
        if (result && result.rows && result.rows.length === 1) { // Memastikan result terdefinisi
            const user = result.rows[0];
            response.status(200).json({
                status: 'success',
                message: 'Login berhasil',
                data: {
                    user_id: user.id,
                    pegawai: user.pegawai,
                    username: user.username,
                    id_role: user.id_role,
                    nama: user.nama,
                    id_cabang: user.id_cabang,
                    nama_cabang: user.nama_cabang,
                    alamat_cabang: user.alamat_cabang,
                    kode_cabang: user.kode_cabang
                },
            });
        } else {
            response.status(401).json({
                status: 'error',
                message: 'Username atau password salah',
                data: null // Tidak ada data jika login gagal
            });
        }
    });
}

const t_trans_in =  async (request, response) => {
    try {
        const { tanggal,keterangan, detail } = request.body;
        if (!Array.isArray(detail)) {
            return response.status(400).json({
                error: 'Detail bukan array'
            });
        }
        const client = await pool.connect()
        try {
            await client.query('BEGIN')

            // Check stock availability
            for (let i = 0; i < detail.length; i++) {
                const { id_item_cabang, qty } = detail[i];
                const queryCheckStock = `
                    SELECT stok_akhir
                    FROM stok_harian
                    WHERE id_item_cabang = $1
                    ORDER BY tanggal DESC
                    LIMIT 1
                `;
                const resultCheckStock = await client.query(queryCheckStock, [id_item_cabang]);
                const stokAkhir = resultCheckStock.rows.length > 0 ? resultCheckStock.rows[0].stok_akhir : 0;

                if (stokAkhir < qty) {
                    await client.query('ROLLBACK');
                    return response.status(400).json({
                        error: `Stok tidak mencukupi untuk item ini, coba cek stok barang`
                    });
                }
            }

            const queryTransIn = 'INSERT INTO t_trans_in (tanggal, keterangan) VALUES ($1, $2) RETURNING id, no_faktur'

            const valuesTransIn = [tanggal, keterangan];
            const resultTransIn = await client.query(queryTransIn, valuesTransIn);
            const transInId = resultTransIn.rows[0].id;
            let nofaktur = resultTransIn.rows[0].no_faktur;

            nofaktur = `${transInId.toString().padStart(5, '0')}`;
            await client.query('UPDATE t_trans_in set no_faktur = $1 where id = $2', [nofaktur, transInId])

            for (let i = 0; i < detail.length; i++) {
                const {id_item_cabang, qty, harga } = detail[i];
                const subtotal = qty * harga;

                const queryDetail = `
                    INSERT INTO t_trans_in_detail (id_transaksi, id_item_cabang, qty, harga, subtotal)
                    VALUES ($1, $2, $3, $4, $5)`;
                const valuesDetail = [nofaktur, id_item_cabang, qty, harga, subtotal];
                await client.query(queryDetail, valuesDetail)

                const queryLastStok = `
                    SELECT stok_akhir
                    FROM stok_harian
                    WHERE id_item_cabang = $1
                    ORDER BY tanggal DESC
                    LIMIT 1
                `;

                const result = await client.query(queryLastStok, [id_item_cabang]);

                let stokAwal;

                // Jika ada data di stok_harian, gunakan stok_akhir sebagai stok_awal
                if (result.rows.length > 0) {
                    stokAwal = result.rows[0].stok_akhir;
                } 

                // hitung stok_akhir setelah perubahan
                const perubahanStok = qty;  // Qty mewakili perubahan stok (positif atau negatif)
                const stokAkhir = stokAwal - perubahanStok;  // Kurangi perubahan stok (qty) dari stok_awal

                const queryStokHarian = `
                    INSERT INTO stok_harian (tanggal, id_item_cabang, stok_awal, stok_akhir, perubahan_stok, transtp, transfrom)
                    VALUES ($1, $2, $3, $4, $5, 'OUT', 'SLS')
                `;
                const valuesStokHarian = [tanggal, id_item_cabang, stokAwal, stokAkhir, perubahanStok];
                await client.query(queryStokHarian, valuesStokHarian);

                const queryUpdateStok = `
                    UPDATE m_item_cabang
                    SET stok_awal = stok_awal - $1,
                    stok_akhir = stok_akhir - $1
                    WHERE id = $2`;
                    
                const valuesUpdateStok = [qty, id_item_cabang];
                await client.query(queryUpdateStok, valuesUpdateStok);

            }
            await client.query('COMMIT');
            response.status(200).json({
                message: 'Transaksi berhasil ditambahkan',
                no_faktur: nofaktur
            });
        } catch (error) {
            await client.query('ROLLBACK');
            console.error('Error:', error);
            throw error;
        } finally {
            client.release()
        } 

    } catch (error) {
        console.error('Error saat menyimpan transaksi:', error); // Log error detail
        response.status(500).json({ error: 'Gagal menyimpan transaksi' });
    }
}

// get all trans in
const getTransIn = async (request, response) => {
    const { kode_cabang, startDate, endDate } = request.query;

    try {
        const results = await pool.query(pgqueries.getTransIn, [kode_cabang, startDate, endDate]);
        response.status(200).json(results.rows);
    } catch (error) {
        console.error('Query error:', error);
        response.status(500).send('Internal Server Error');
    }
};


// t_trans_receipt
const t_trans_receipt =  async (request, response) => {
    try {
        const { tanggal,keterangan, detail } = request.body;
        if (!Array.isArray(detail)) {
            return response.status(400).json({
                error: 'Detail bukan array'
            });
        }
        const client = await pool.connect()
        try {
            await client.query('BEGIN')

            // Check stock availability
            // for (let i = 0; i < detail.length; i++) {
            //     const { id_item_cabang, qty } = detail[i];
            //     const queryCheckStock = `
            //         SELECT stok_akhir
            //         FROM stok_harian
            //         WHERE id_item_cabang = $1
            //         ORDER BY tanggal DESC
            //         LIMIT 1
            //     `;
            //     const resultCheckStock = await client.query(queryCheckStock, [id_item_cabang]);
            //     const stokAkhir = resultCheckStock.rows.length > 0 ? resultCheckStock.rows[0].stok_akhir : 0;

            //     if (stokAkhir < qty) {
            //         await client.query('ROLLBACK');
            //         return response.status(400).json({
            //             error: `Stok tidak mencukupi untuk item ini, coba cek stok barang`
            //         });
            //     }
            // }

            const queryTrans = 'INSERT INTO t_receipt (tanggal, keterangan) VALUES ($1, $2) RETURNING id, docno'

            const valuesTrans = [tanggal, keterangan];
            const resultTrans = await client.query(queryTrans, valuesTrans);
            const transId = resultTrans.rows[0].id;
            let docno = resultTrans.rows[0].docno;

            docno = `${transId.toString().padStart(5, '0')}`;
            await client.query('UPDATE t_receipt set docno = $1 where id = $2', [docno, transId])

            for (let i = 0; i < detail.length; i++) {
                const {id_item_cabang, qty } = detail[i];

                const queryDetail = `
                    INSERT INTO t_receipt_detail (id_transaksi, id_item_cabang, qty)
                    VALUES ($1, $2, $3)`;
                const valuesDetail = [docno, id_item_cabang, qty];
                await client.query(queryDetail, valuesDetail)

                const queryLastStok = `
                    SELECT stok_akhir
                    FROM stok_harian
                    WHERE id_item_cabang = $1
                    ORDER BY tanggal DESC
                    LIMIT 1
                `;

                const result = await client.query(queryLastStok, [id_item_cabang]);

                let stokAwal;

                // Jika ada data di stok_harian, gunakan stok_akhir sebagai stok_awal
                if (result.rows.length > 0) {
                    stokAwal = result.rows[0].stok_akhir;
                } 

                // hitung stok_akhir setelah perubahan
                const perubahanStok = qty;  // Qty mewakili perubahan stok (positif atau negatif)
                const stokAkhir = stokAwal + perubahanStok;  // tambah perubahan stok (qty) dari stok_awal

                const queryStokHarian = `
                    INSERT INTO stok_harian (tanggal, id_item_cabang, stok_awal, stok_akhir, perubahan_stok, transtp, transfrom)
                    VALUES ($1, $2, $3, $4, $5, $6, $7)
                `;
                const valuesStokHarian = [tanggal, id_item_cabang, stokAwal, stokAkhir, perubahanStok, 'IN','RECEIPT'];
                await client.query(queryStokHarian, valuesStokHarian);

                const queryUpdateStok = `
                    UPDATE m_item_cabang
                    SET stok_awal = stok_awal + $1,
                    stok_akhir = stok_akhir + $1
                    WHERE id = $2`;
                    
                const valuesUpdateStok = [qty, id_item_cabang];
                await client.query(queryUpdateStok, valuesUpdateStok);

            }
            await client.query('COMMIT');
            response.status(200).json({
                message: 'Transaksi berhasil ditambahkan',
                docno: docno
            });
        } catch (error) {
            await client.query('ROLLBACK');
            console.error('Error:', error);
            throw error;
        } finally {
            client.release()
        } 

    } catch (error) {
        console.error('Error saat menyimpan transaksi:', error); // Log error detail
        response.status(500).json({ error: 'Gagal menyimpan transaksi' });
    }
}


// get all trans receipt
const getTransReceipt = async (request, response) => {
    const { kode_cabang, startDate, endDate } = request.query;

    try {
        const results = await pool.query(pgqueries.getTransReceipt, [kode_cabang, startDate, endDate]);
        response.status(200).json(results.rows);
    } catch (error) {
        console.error('Query error:', error);
        response.status(500).send('Internal Server Error');
    }
};

// get all daily stock
const getDailyStock = async (request, response) => {
    const { kode_cabang, startDate, endDate } = request.query;

    try {
        const results = await pool.query(pgqueries.getDailyStock, [kode_cabang, startDate, endDate]);
        response.status(200).json(results.rows);
    } catch (error) {
        console.error('Query error:', error);
        response.status(500).send('Internal Server Error');
    }
};




module.exports = {
    getCabang, addCabang, editCabang, deleteCabang,
    getRole, addRole, editRole, deleteRole,
    getUser, addUser, editUser, deleteUser,
    getSatuan, addSatuan, editSatuan, deleteSatuan,
    getJenisItem, addJenisItem, editJenisItem, deleteJenisItem,
    getItemCabang, addItemCabang,
    getItem, addItem, editItem,
    login,
    t_trans_in, getTransIn,
    t_trans_receipt, getTransReceipt, getDailyStock
}