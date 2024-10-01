<template>
    <div class="sales-container">
      <div class="card">
        <div class="form-group flex-container">
          <h2>Report</h2>
          <v-divider vertical></v-divider>
          <div>
            <label for="tanggal">Tanggal Awal:</label>
            <input type="date" id="tanggal" class="input-field" v-model="startDate" />
          </div>
          <v-divider vertical />
          <div>
            <label for="tanggal">Tanggal Akhir:</label>
            <input type="date" id="tanggal" class="input-field" v-model="endDate" />
          </div>
          <v-divider vertical />
          <div class="flex-item-button">
            <v-btn small elevation="7" class="input-field option-button" :disabled="!startDate || !endDate">
              <v-icon @click="fetchReport" elevation="7" title="search">mdi-magnify</v-icon>
            </v-btn>
          </div>
          
        </div>
      </div>
      <div class="card">
        <v-simple-table class="small-table">
          <thead class="header-container">
            <tr>
              <th style="width: 4%;">Kode</th>
              <th style="width: 6%;">Tanggal</th>
              <th style="width: 14%;">Cabang</th>
              <th style="width: 7%;">No Faktur</th>
              <th>Kode Item</th>
              <th style="width: 14%;">Nama Item</th>
              <th>Hpp</th>
              <th>Hjl</th>
              <th>Qty</th>
              <th>Subtotal</th>
              <th>Uom</th>
              <th>Jenis</th>
            </tr>
          </thead>
          <tbody class="cart-body">
            <tr v-for="(item, index) in item" :key="index">
              <td style="width: 4%;">{{ item.kode_cabang }}</td>
              <td style="width: 6%;">{{ dateFormat(item.tanggal) }}</td>
              <td style="width: 14%;">{{ item.nama_cabang }}</td>
              <td style="width: 7%;">{{ item.no_faktur }}</td>
              <td>{{ item.kode_item }}</td>
              <td style="width: 14%;">{{ item.nama_item }}</td>
              <td>{{ priceFormat(item.hpp) }}</td>
              <td>{{ priceFormat(item.harga) }}</td>
              <td>{{ item.qty }}</td>
              <td>{{ priceFormat(item.subtotal) }}</td>
              <td>{{ item.nama_satuan }}</td>
              <td>{{ item.jenis_item }}</td>
            </tr>
          </tbody>
        </v-simple-table>
      </div>
    </div>
</template>

<script>
import { mapGetters } from 'vuex';
import api from '@/services/api';
import mixins from '@/mixins/mixins';
import Swal from 'sweetalert2';



export default {
  mixins: [mixins],
  computed: {
    ...mapGetters(['getUserData']),
    kodeCabang() {
      return this.getUserData.kode_cabang;
    },
    idCabang() {
      return this.getUserData.id_cabang;
    },
    
    
  },
  data() {
    return {
      item: [],
      search: '',
      user: this.getUserData,
      startDate: '',
      endDate: '',

    };
  },
  methods: {
    async fetchReport() {
      try {
        console.log('Start', this.startDate)
        console.log('End', this.endDate)
        const response = await api.get(`/reportsales?kode_cabang=${this.kodeCabang}&startDate=${this.startDate}&endDate=${this.endDate}`);
        if (response.data.length === 0) {
          Swal.fire({
          position: 'top',
          icon: 'error',
          title: 'Tidak ada data dalam rentang tanggal yang dipilih.',
          showConfirmButton: false,
          timer: 2000,
          toast: true,
          width: '500px',
          background: '#EF9A9A',
          color: '#fff',
          iconColor: '#fff',
          
        });
        } else {
          this.item = response.data;
        }
        console.log('Items :', this.item);
        // console.log('unit :', this.unit); // Tambahkan log ini
      } catch (error) {
        console.error('Error fetching unit:', error); // Tambahkan log ini
      }
    },

    async fetchUser() {
      try {
        this.user = this.getUserData;
      } catch (error) {
        console.error('Error fetching unit:', error); // Tambahkan log ini
      }
    },
  },
  async created() {
    await this.fetchUser();
    // await this.fetchReport();
  }

};
</script> 


<style scoped>

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



/* .item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 10px;
  border: 1px solid #ddd;
  border-radius: 4px;
} */

/* .item button {
  background-color: #007bff;
  color: white;
  border: none;
  padding: 5px 10px;
  border-radius: 4px;
  cursor: pointer;
} */


.flex-container {
  display: flex;
  gap: 20px;
}

.form-group label {
  display: block;
  margin-bottom: 5px;
  font-weight: bold;
  font-size: 12px;
  /* Adjust the font size */
  margin: 0;
  /* Adjust the margin */
}

.form-group input {
  width: 100%;
  padding: 4px;
  /* Adjust the padding */
  box-sizing: border-box;
  border: 1px solid #ccc;
  border-radius: 4px;
  font-size: 12px;
  /* Adjust the font size */
  height: 25px;
  /* Adjust the height */
}

  .cart-body td{
    height: 25px !important;
    font-size: 11px !important;
    /* font-weight: bold !important; */
  }

  .header-container th{
    height: 20px !important;
    font-size: 12px !important;
    font-weight: bold !important; 
    color: rgb(247, 116, 116) !important;

  }


.flex-item-button {
  margin-top: 15px;
}




.scrollable-table-body {
  display: block;
  max-height: 250px;
  /* Adjust the height as needed */
  overflow-y: auto;
}

/* Ensure the table headers align with the scrollable body */
.small-table thead,

.small-table tbody tr {
  display: table;
  width: 100%;
  table-layout: fixed;
}

.small-table tbody {
  display: block;
}

.small-table {
  font-size: 10px; /* Adjust the font size as needed */
}

.option-button{
  margin-top: 1px;
}

/* ... existing styles ... */
</style>