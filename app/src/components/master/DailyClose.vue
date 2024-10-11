<template>
  <div class="sales-container">
    <div class="card">
      <div class="form-group flex-container">
        <h2>Daily Close</h2>
        <v-divider vertical></v-divider>
        
        
        <div class="flex-item-button">
          <v-btn small elevation="7" class="input-field option-button" @click="dailyClose">
            <v-icon  elevation="7" title="Proses Daily Close">mdi-cloud-arrow-up-outline</v-icon>
          </v-btn>
        </div>
      </div>
    </div>
    <div class="card">
      <h5 class="info-daily">Sebeleum melakukan proses Daily Close, Pastikan semua transaksi pada tanggal {{ user.app_date }} sudah selesai.</h5>
      <v-divider/>
      <h5 class="info-appdate">Your App Date : {{ user.app_date }}</h5>
      <!-- <h3>New Open Date : {{ user.app_date  }}</h3> -->
      <h5 class="info-nextdate">New Open Date : {{ nextAppDate }}</h5>
      <div v-if="isLoading" class="loading-animation">
      <div class="spinner" ></div>
      <p>Loading...</p>
    </div>
    </div>
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex';
import mixins from '@/mixins/mixins';
import api from '@/services/api';
import Swal from 'sweetalert2'
import 'jspdf-autotable';



export default {
mixins: [mixins],
computed: {
  ...mapGetters(['getUserData']),
  nextAppDate() {
    return new Date(new Date(this.user.app_date).setDate(new Date(this.user.app_date).getDate() + 1)).toLocaleString('en-GB', { day: 'numeric', month: 'short', year: 'numeric' });
  },
  
},
data() {
  return {
    item: [],
    search: '',
    user: this.getUserData,
    startDate: '',
    endDate: '',
    isLoading: false,

  };
},
methods: {
  ...mapActions(['logout']),
  logout() {
    this.$store.dispatch('logout');
  },
  async fetchUser() {
    try {
      this.user = this.getUserData;
      // console.log('user :', this.user);
    } catch (error) {
      console.error('Error fetching unit:', error); // Tambahkan log ini
    }
  },

  async dailyClose() {
    this.isLoading = true;
    const currentTime = new Date(new Date(this.user.app_date).setDate(new Date(this.user.app_date).getDate() + 1)).toLocaleString('en-GB', { day: 'numeric', month: 'short', year: 'numeric' });
            // console.log({
            //   kode: this.user.kode_cabang,
            //   app_date: currentTime
            // })
            
            api.put(`/m_cabang/dailyclose/${this.user.id_cabang}`, {
              kode: this.user.kode_cabang,
              app_date: currentTime
            })
            .then(() => {
              setTimeout(() => {
                this.isLoading = false
              }, 3000)
              setTimeout(() => {
                Swal.fire({
                position: 'top',
                icon: 'success',
                title: 'System Daily Close Sukses',
                showConfirmButton: false,
                timer: 2000,
                toast: true,
                width: '400px',
                padding: '20px',
                });
              }, 2100);
              setTimeout(() => {
                this.logout()
              }, 2800)
              
              })
              .catch(error => {
                alert('Update Failed' + error)
                this.isLoading = false;
              })
            // Tambahkan logika untuk menyimpan perubahan ke Vuex atau API
        },


  
},
async created() {
  await this.fetchUser();
  // await this.fetchReport();
}


};
</script> 


<style scoped>

.info-daily{
  padding-bottom: 3px;
}
.info-appdate{
  padding-top: 3px;
}

.info-nextdate{
  color: red;
}



h2{
margin-right: 5px;
font-size: 22px;
font-weight: bold;
display: flex;
align-items: center;
font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;  
}
.sales-container {
display: flex;
flex-direction: column;
gap: 20px;
padding: 20px;
}

.card {
background-color: #fff;
border-radius: 8px;
box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
padding: 20px;
}

.flex-container {
display: flex;
gap: 25px;
}


.flex-item-button {
margin-top: 15px;
}
/* Ensure the table headers align with the scrollable body */


.loading-animation {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 100px; /* Adjust height as needed */
}

.spinner {
  border: 8px solid #f3f3f3; /* Light grey */
  border-top: 8px solid #3498db; /* Blue */
  border-radius: 50%;
  width: 40px; /* Size of the spinner */
  height: 40px; /* Size of the spinner */
  animation: spin 1s linear infinite; /* Animation */
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}


/* ... existing styles ... */
</style>