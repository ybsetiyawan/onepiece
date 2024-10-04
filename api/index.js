const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const morgan = require('morgan');
const db = require('./queries');
const app = express();
app.use(morgan('tiny'));
app.use(cors());
app.use(bodyParser.json());
app.get('/', (req, res) => {
    res.json({ 
        message: 'Hello World' 
    });
});

// m_item
app.get('/m_item', db.getItem),
app.post('/m_item', db.addItem),
app.put('/m_item/:id', db.editItem),

// m_item_cabang
app.get('/m_item_cabang', db.getItemCabang),
app.post('/m_item_cabang', db.addItemCabang)

// m_satuan
app.get('/m_satuan', db.getSatuan);
app.post('/m_satuan', db.addSatuan);
app.put('/m_satuan/:id', db.editSatuan);
app.delete('/m_satuan/:id', db.deleteSatuan);

// m_jenis_item
app.get('/m_jenis_item', db.getJenisItem);
app.post('/m_jenis_item', db.addJenisItem);
app.put('/m_jenis_item/:id', db.editJenisItem);
app.delete('/m_jenis_item/:id', db.deleteJenisItem);

// m_cabang
app.get('/m_cabang', db.getCabang);
app.post('/m_cabang', db.addCabang);
app.put('/m_cabang/:id', db.editCabang);
app.delete('/m_cabang/:id', db.deleteCabang);

// m_role
app.get('/m_role', db.getRole);
app.post('/m_role', db.addRole);
app.put('/m_role/:id', db.editRole);
app.delete('/m_role/:id', db.deleteRole);

// m_user
app.get('/m_user', db.getUser);
app.post('/m_user', db.addUser);
app.put('/m_user/:id', db.editUser);
app.delete('/m_user/:id', db.deleteUser);

// login
app.post('/login', db.login);

// t_trans_in
app.post('/t_trans_in', async (req, res)=> {
  await db.t_trans_in(req, res)
})

// getTransIn
app.get('/reportsales', async (req, res) => {
  await db.getTransIn(req, res)
});

// t_trans_receipt
app.post('/t_trans_receipt', async (req, res)=> {
  await db.t_trans_receipt(req, res)
})








const port = process.env.PORT || 3000;
app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});