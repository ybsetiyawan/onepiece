const Pool = require('pg').Pool;
const { request, response } = require('express');
const pgqueries = require('./pgqueries');

const pool = new Pool({
    user: 'postgres',
    // host: 'localhost',
    host: '103.31.38.210',
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

const addItemCabang = (request, response) => {
    const { id_item, id_cabang, stok_awal, stok_akhir } = request.body
    pool.query('INSERT INTO m_item_cabang (id_item, id_cabang, stok_awal, stok_akhir) VALUES ($1, $2, $3, $4)',
        [id_item, id_cabang, stok_awal, stok_akhir], (error, result) => {
            if(error) {
                console.log(error);
                response.status(500).send('Internal Server Error');;
            }
            response.status(201).send('Data berhasil ditambahkan');
        }
    ) 

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



module.exports = {
    getCabang, addCabang, editCabang, deleteCabang,
    getRole, addRole, editRole, deleteRole,
    getUser, addUser, editUser, deleteUser,
    getSatuan, addSatuan, editSatuan, deleteSatuan,
    getJenisItem, addJenisItem, editJenisItem, deleteJenisItem,
    getItemCabang, addItemCabang,
    getItem, addItem, editItem,
    login
}