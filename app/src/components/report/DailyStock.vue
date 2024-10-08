<template>
    <div class="sales-container">
      <div class="card">
        <div class="form-group flex-container">
          <h2>Daily Stock</h2>
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
            <v-btn small elevation="7" class="input-field option-button" @click="fetchReport" :disabled="!startDate || !endDate">
              <v-icon  elevation="7" title="search">mdi-magnify</v-icon>
            </v-btn>
          </div>
          <div class="flex-item-button">
            <v-btn small elevation="7" class="input-field option-button" @click="exportPDF" :disabled=" item.length === 0">
              <v-icon  elevation="7" title="exportpdf">mdi-file-pdf-box</v-icon>
            </v-btn>
          </div>
        </div>
      </div>
      <div class="card">
        <v-simple-table class="small-table">
          <thead class="header-container">
            <tr>
              <th rowspan="2">Kode Item</th>
              <th rowspan="2">Nama Item</th>
              <!-- <th rowspan="2">Tanggal</th> -->
              <th rowspan="2">Stok Awal</th>
              <th colspan="2" class="text-center">Mutasi</th>
              <!-- <th colspan="2">Transtp</th> -->
              <th rowspan="2" class="text-center">Stok Akhir</th>
            </tr>
            <tr>
              <th class="text-center">In</th>
              <th class="text-center">Out</th>
              <!-- <th>SLS</th> -->
              <!-- <th>Receipt</th> -->
            </tr>
          </thead>
          <v-divider/>

          <tbody class="cart-body">
            <tr v-for="(item, index) in item" :key="index">
              <td>{{ item.kode_item }}</td>
              <td>{{ item.nama_item }}</td>
              <!-- <td>{{ item.tanggal }}</td> -->
              <td >{{ item.stok_awal }}</td>
              <td class="text-center">{{ item.total_in }}</td>
              <td class="text-center">{{ item.total_out }}</td>
              <td class="text-center">{{ item.stok_akhir }}</td>
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
import jsPDF from 'jspdf';
import 'jspdf-autotable';



export default {
  mixins: [mixins],
  computed: {
    ...mapGetters(['getUserData']),
    // groupedItems() {
    //   const grouped = {};
    //   this.item.forEach(item => {
    //     const key = item.kode_item; // Group by kode_item
    //     if (!grouped[key]) {
    //       grouped[key] = {
    //         kode_cabang: item.kode_cabang,
    //         nama_cabang: item.nama_cabang,
    //         tanggal: item.tanggal,
    //         stok_awal: item.stok_awal,
    //         total_in: item.total_in,
    //         total_out: item.total_out,
    //         stok_akhir: item.stok_akhir
    //       };
    //     }
    //     // Separate in and out transactions
    //     if (item.transtp === 'in') {
    //       grouped[key].in += item.perubahan_stok;
    //     } else if (item.transtp === 'out') {
    //       grouped[key].out += item.perubahan_stok;
    //     }
    //     // Add other transaction types if needed
    //     if (item.transtp === 'sls') {
    //       grouped[key].sls += item.perubahan_stok;
    //     } else if (item.transtp === 'receipt') {
    //       grouped[key].receipt += item.perubahan_stok;
    //     }
    //   });
    //   return Object.values(grouped);
    // }
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
        const startDateTime = `${this.startDate}T00:00:00`;
        const endDateTime = `${this.endDate}T23:59:59`;
        console.log('Start', startDateTime)
        console.log('End', endDateTime)
        const response = await api.get(`/reportstock?kode_cabang=${this.user.kode_cabang}&startDate=${startDateTime}&endDate=${endDateTime}`);
        if (response.data.length === 0) {

          Swal.fire({
          position: 'center',
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
        this.item = [];
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
        console.log('user :', this.user);
      } catch (error) {
        console.error('Error fetching unit:', error); // Tambahkan log ini
      }
    },

    async exportPDF() {
      const doc = new jsPDF();
      const pageWidth = doc.internal.pageSize.getWidth();
      const margin = 10;
      const text1 = 'LAPORAN PERSEDIAAN BARANG';
      const text2 = `CABANG : ${this.user.kode_cabang} - ${this.user.nama_cabang}`;
      const text3 = `ALAMAT : ${this.user.alamat_cabang}`;
      const text4 = `USER : ${this.user.nama}`;
      const text5 = `PERIODE: ${this.dateFormat(this.startDate)} s/d ${this.dateFormat(this.endDate)}`;

      const text1Width = doc.getTextWidth(text1);
      const text4Width = doc.getTextWidth(text4);
      const text5Width = doc.getTextWidth(text5);

      doc.setFontSize(8); // Ukuran font untuk keterangan
      doc.setFont('helvetica', 'bold'); // Mengatur font menjadi Helvetica dan bold
      doc.text(text1, pageWidth - text1Width - 65, 7); // Posisi keterangan di kiri

      doc.setFontSize(7); // Ukuran font untuk keterangan

      doc.text(text2, margin, 12); // Posisi keterangan di kiri
      doc.text(text5, pageWidth - text5Width - (-39), 12); // Posisi keterangan di kanan
      doc.text(text3, margin, 17); // Posisi keterangan di kiri
      doc.text(text4, pageWidth - text4Width - (-18), 17); // Posisi keterangan di kanan

      const columns = [
        // { header: 'TANGGAL', dataKey: 'tanggal' },
        { header: 'KODE', dataKey: 'kode_item' },
        { header: 'NAMA', dataKey: 'nama_item' },
        { header: 'STOK AWAL', dataKey: 'stok_awal' },
        { header: 'MUTASI IN', dataKey: 'total_in' },
        { header: 'MUTASI OUT', dataKey: 'total_out' },
        { header: 'STOK AKHIR', dataKey: 'stok_akhir' },
      ];

      const rows = this.item.map(item => ({
        // tanggal: this.dateFormat(item.tanggal),
        kode_item: item.kode_item,
        nama_item: item.nama_item,
        stok_awal: item.stok_awal,
        total_in: item.total_in,
        total_out: item.total_out,
        stok_akhir: item.stok_akhir,
      }));

      // Debugging: Log the rows array
      // console.log('Rows for PDF:', rows);

      // Ensure autoTable is correctly called
      doc.autoTable({
        head: [columns.map(col => col.header)],
        body: rows.map(row => columns.map(col => row[col.dataKey])),
        styles: {
          font: 'helvetica',
          fontSize: 7,
        },
        margin: [20, 10, 10, 10],
      });
      

      doc.save('stock-report.pdf');
    }
  },
  async created() {
    await this.fetchUser();
    // await this.fetchReport();
  }
  

};
</script> 


<style scoped>
.input-field {
  margin-top: 4px;
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
    height: 27px !important;
    font-size: 11px !important;
    /* font-weight: bold !important; */
  }

  .cart-body{
    max-height: 485px;
    /* Adjust the height as needed */
    overflow-y: auto;

  }

  .header-container th{
    height: 20px !important;
    font-size: 12px !important;
    font-weight: bold !important; 
    color: rgb(247, 116, 116) !important;
    padding-bottom: 5px !important; /* menambahkan jarak antara header dan body table */
  }


.flex-item-button {
  margin-top: 15px;
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
  margin-top: 4px;
}



/* ... existing styles ... */
</style>