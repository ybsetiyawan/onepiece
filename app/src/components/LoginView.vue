<template>
  <v-container fill-height>
    <v-row justify="center" align="center">
      <v-col cols="12" sm="8" md="4">
        <v-card class="custom-card">
          <v-card-title class="text-h5">Login</v-card-title>
          <v-card-text>
            <v-form ref="form" v-model="valid" lazy-validation>
              <v-text-field
                label="Username"
                prepend-icon="mdi-account"
                v-model="loginData.username"
              ></v-text-field>
              <v-text-field
                label="Password"
                prepend-icon="mdi-lock"
                type="password"
                v-model="loginData.password"
              ></v-text-field>
              <v-btn @click="login">Login</v-btn>
            </v-form>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import api from '../services/api'
import Swal from 'sweetalert2'
import { mapActions } from 'vuex';



export default {
  data() {
    return {
      valid: true,
      loginData: {
        username: '',
        password: '',
      },
    }
  },
  methods: {
    ...mapActions(['setUserData']),
    login() {
      api.post('/login', this.loginData)
        .then(response =>  {
          this.loginDetail = response.data;
          // Mengakses data dengan benar
          this.setUserData({
            username: this.loginDetail.data.username, // Ambil username dari response.data
            id_role: this.loginDetail.data.id_role, // Ambil id_role dari response.data
            nama_cabang: this.loginDetail.data.nama_cabang, // Ambil id_cabang dari response.data 
            alamat_cabang: this.loginDetail.data.alamat_cabang,
            nama: this.loginDetail.data.nama,
            id_cabang: this.loginDetail.data.id_cabang,
            user_id: this.loginDetail.data.user_id,
            kode_cabang: this.loginDetail.data.kode_cabang
          });
          Swal.fire({
            position: 'top-end',
            icon: 'success',
            title: 'Login berhasil!',
            showConfirmButton: false,
            timer: 1500,
            toast: true,
            width: '400px',
            background: '#B0BEC5',
            color: '#fff',
            padding: '16px',
            iconColor: '#fff',
          });
          this.$router.push('/');
        })
        .catch(error => {
          let message = 'Login gagal: Terjadi kesalahan';
          if (error.response && error.response.data && error.response.data.message === 'Invalid credentials') {
            message = 'Login gagal: Username atau password salah';
          } else if (error.response && error.response.data) {
            message = 'Login gagal: ' + error.response.data.message;
          }
          Swal.fire({
            position: 'top-end',
            icon: 'error',
            showConfirmButton: false,
            timer: 1500,
            toast: true,
            width: '400px',
            background: '#EF9A9A',
            color: '#fff',
            padding: '16px',
            iconColor: '#fff',
            text: message
          });
        });
    }
  }
}

</script>


<style scoped>
.custom-card {
  max-width: 500px;
  box-shadow: 0 4px 8px rgba(0,0,0,2.5) !important;
}
</style>