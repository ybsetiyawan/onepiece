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
              <th style="width: 6%;">Tanggal</th>
              <!-- <th style="width: 14%;">Cabang</th> -->
              <th style="width: 6.8%;">No Faktur</th>
              <th>Kode Item</th>
              <th style="width: 13%;">Nama Item</th>
              <th>Hpp</th>
              <th style="width: 9.5%;">Hjl</th>
              <th style="width: 7.8%;">Qty</th>
              <th>Subtotal</th>
              <th>Uom</th>
              <th>Jenis</th>
            </tr>
          </thead>
          <tbody class="cart-body">
            <tr v-for="(item, index) in item" :key="index">
              <td style="width: 6%;">{{ dateFormat(item.tanggal) }}</td>
              <!-- <td style="width: 14%;">{{ item.nama_cabang }}</td> -->
              <td style="width: 7.2%;">{{ item.no_faktur }}</td>
              <td>{{ item.kode_item }}</td>
              <td style="width: 14%;">{{ item.nama_item }}</td>
              <td>{{ priceFormat(item.hpp) }}</td>
              <td>{{ priceFormat(item.harga) }}</td>
              <td style="width: 8.5%;">{{ item.qty }}</td>
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
import jsPDF from 'jspdf';
import 'jspdf-autotable';



export default {
  mixins: [mixins],
  computed: {
    ...mapGetters(['getUserData']),
    
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
        const response = await api.get(`/reportsales?kode_cabang=${this.user.kode_cabang}&startDate=${this.startDate}&endDate=${this.endDate}`);
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
      const text1 = 'LAPORAN PENJUALAN';
      const text2 = `CABANG : ${this.user.kode_cabang} - ${this.user.nama_cabang}`;
      const text3 = `ALAMAT : ${this.user.alamat_cabang}`;
      const text4 = `USER : ${this.user.nama}`;
      const text5 = `PERIODE: ${this.dateFormat(this.startDate)} s/d ${this.dateFormat(this.endDate)}`;

      const text1Width = doc.getTextWidth(text1);
      // const text2Width = doc.getTextWidth(text2);
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
        { header: 'TANGGAL', dataKey: 'tanggal' },
        { header: 'NO FAKTUR', dataKey: 'no_faktur' },
        { header: 'KODE', dataKey: 'kode_item' },
        { header: 'NAMA', dataKey: 'nama_item' },
        { header: 'HPP', dataKey: 'hpp' },
        { header: 'HJL', dataKey: 'harga' },
        { header: 'QTY', dataKey: 'qty' },
        { header: 'SUBTOTAL', dataKey: 'subtotal' },
        { header: 'UOM', dataKey: 'nama_satuan' },
        { header: 'JENIS', dataKey: 'jenis_item' },
      ];

      const rows = this.item.map(item => ({
        tanggal: this.dateFormat(item.tanggal),
        no_faktur: item.no_faktur,
        kode_item: item.kode_item,
        nama_item: item.nama_item,
        hpp: this.priceFormat(item.hpp),
        harga: this.priceFormat(item.harga),
        qty: item.qty,
        subtotal: this.priceFormat(item.subtotal),
        nama_satuan: item.nama_satuan,
        jenis_item: item.jenis_item,
      }));

      // Debugging: Log the rows array
      console.log('Rows for PDF:', rows);

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
      

      doc.save('sales-report.pdf');
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