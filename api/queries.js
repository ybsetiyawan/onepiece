const Pool = require('pg').Pool;
const pgqueries = require('./pgqueries');

const pool = new Pool({
    user: 'postgres',
    host: 'localhost',
    database: 'db_onepiece',
    password: 'pakepake',
    port: 5432,
});

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
    const {username, password, id_role, id_cabang} = request.body
    pool.query('INSERT INTO m_user (username, password, id_role, id_cabang) VALUES ($1, $2, $3, $4)', [username, password, id_role, id_cabang], (error, results) => {
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
    login
}