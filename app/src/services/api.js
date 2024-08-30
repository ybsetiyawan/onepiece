// api.js

import axios from 'axios';

const api = axios.create({
  baseURL: 'http://10.126.101.217:3000', // Ganti dengan basis URL Anda
  // baseURL: 'http://103.217.145.67:4000', // Ganti dengan basis URL Anda
  // opsi lain bisa ditambahkan di sini jika diperlukan
});

export default api;
