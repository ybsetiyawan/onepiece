import router from '@/router';
import Vue from 'vue'
import Vuex from 'vuex'
import api from '../services/api';

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    userData: JSON.parse(localStorage.getItem('userData')) || {
      user_id: '',
      username: '',
      id_role: '',
      id_cabang: '',
      nama_cabang: '',
      alamat_cabang: '',
      nama: '',
      kode_cabang: ''
    },
    
  },
  mutations: {
    setUserData(state, payload) {
      state.userData.user_id = payload.user_id;
      state.userData.username = payload.username;
      state.userData.id_role = payload.id_role;
      state.userData.id_cabang = payload.id_cabang;
      state.userData.nama_cabang = payload.nama_cabang;
      state.userData.alamat_cabang = payload.alamat_cabang;
      state.userData.nama = payload.nama;
      state.userData.kode_cabang = payload.kode_cabang;
      localStorage.setItem('userData', JSON.stringify(state.userData));
    },
    logout(state) {
      state.userData = {
        user_id: '',
        username: '',
        id_role: '',
        id_cabang: '',
        nama_cabang: '',
        alamat_cabang: '',
        nama: '',
        kode_cabang: ''

      }
      localStorage.removeItem('userData');
    },
    setCabang(state, data) {
      state.cabang = data; // Pastikan mutasi ini ada
    },
    setUsers(state, data) {
      state.users = data; // Menyimpan data pengguna ke state
    },
    setUnit(state, data) {
      state.unit = data; // Menyimpan data pengguna ke state
    },
    setItemType(state, data) {
      state.itemtype = data; // Menyimpan data pengguna ke state
    },
    setItem(state, data) {
      state.item = data; // Menyimpan data pengguna ke state
    }

  },
  actions: {
    setUserData({ commit }, userData) {
      // console.log('userData', userData);
      commit('setUserData', userData);
    },
    logout({ commit }) {
      commit('logout');
      if (router.currentRoute.path !== '/login') {
        router.push('/login');
      }
    },
    async getCabang({ commit }) {
      const response = await api.get('/m_cabang');
      const data = response.data;
      commit('setCabang', data);
      // console.log(data);
    },
    async getUsers({ commit }) {
      const response = await api.get('/m_user');
      const data = response.data;
      commit('setUsers', data);
      // console.log(data);
    },
    async getUnit({ commit }) {
      const response = await api.get('/m_satuan');
      const data = response.data;
      commit('setUnit', data);
      // console.log(data);
    },
    async getItemType({ commit }) {
      const response = await api.get('/m_jenis_item');
      const data = response.data;
      commit('setItemType', data);
      // console.log(data);
    },
    async getItem({ commit }) {
      const response = await api.get('/m_item');
      const data = response.data;
      commit('setItem', data);
      // console.log(data);
    }
  },
  getters: {
    getUserData: (state) => state.userData,
    isLoggedIn: (state) => !!state.userData.username,
    getCabangData: (state) => state.cabang, // Pastikan ini mengembalikan state.cabang
    getUsersData: (state) => state.users, // Mengembalikan data pengguna
    getUnitData: (state) => state.unit, // Mengembalikan data pengguna
    getItemTypeData: (state) => state.itemtype, // Mengembalikan data pengguna
    getItemData: (state) => state.item, // Mengembalikan data pengguna
  }
})
