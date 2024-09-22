<template>
  <v-app>
  <div class="sales-container">
    <div class="card">
        <div class="flex-container">
              <h4>Transaksi Penjualan Accesories</h4>
              <v-spacer></v-spacer>
              <v-btn color="primary" dark elevation="7">New</v-btn>
        </div>
      <div class="form-group flex-container"></div>
      <v-divider/>
      <div class="form-group flex-container">
        <div>
          <label for="tanggal">Tanggal:</label>
          <input type="date" id="tanggal" class="input-field" v-model="transaction.tanggal"/>
        </div>
        <v-divider vertical/>
        <div class="flex-item">
          <label for="keterangan">Keterangan:</label>
          <input type="text" id="keterangan" autocomplete = "off" class="input-field" v-model="transaction.keterangan"/>
        </div>
        <v-divider vertical/>
        <div class="flex-item-button">
          <label for="search"></label>
          <v-btn  small elevation="7" class="input-field">
              <v-icon @click="dialog.value = true" elevation="10">mdi-magnify</v-icon>
          </v-btn>
        </div>
        <div class="flex-item-button">
          <label for="save"></label>
          <v-btn  small elevation="7" class="input-field">
              <v-icon @click="saveTransaction" elevation="7">mdi-content-save</v-icon>
          </v-btn>
        </div>
        <div class="flex-item-button">
          <label for="cancel"></label>
          <v-btn  small elevation="7" class="input-field">
              <v-icon @click="resetForm" elevation="7">mdi-delete</v-icon>
          </v-btn>
        </div>
      </div>
    </div>
    <div class="card">
      <h4>Item yang Dipilih</h4>
      <v-simple-table class="small-table">
        <thead>
          <tr>
            <th>Kode</th>
            <th>Nama</th>
            <th>Hpp</th>
            <th>Hjl</th>
            <th>Qty</th>
            <th>Stok</th>
            <th>Uom</th>
            <th class="delete-column">-</th>
          </tr>
        </thead>
        <tbody class="cart-body">
          <tr v-for="(item, index) in selectedItems" :key="index">
            <td>{{ item.kode }}</td>
            <td>{{ item.nama }}</td>
            <td>{{ item.hpp }}</td>
            <!-- <td contenteditable="true" class="warning">{{ item.hpp }}</td> -->
            <td contenteditable="true" @input="updateHjl(index, $event)" class="texthargajual">{{ item.hjl }}</td> <!-- Make hpp editable -->
            <td>
              <input class="qty" type="number" name="qty" id="qty" v-model="quantities[index]" @input="updateQuantity(index, $event.target.value)" min="1">
            </td>
            <td>{{ item.stok_akhir }}</td>
            <td>{{ item.nama_satuan }}</td>
            <td>
              <v-icon 
                @click="removeItem(index)"
                color="red"
                size="15px"
              >mdi-delete</v-icon>
            </td>
          </tr>
        </tbody>
      </v-simple-table>
     
    </div>
  </div>

  <template>
      <v-dialog
        v-model="dialog.value"
        transition="dialog-top-transition"
        overlay-opacity="0.8"
        max-width="1200"
      >
        
        <template v-slot:default="dialog">
          <v-card>
            <v-toolbar
              color="#78909C"
              dark
            >Daftar Barang</v-toolbar>
            <v-form>
             
              <v-data-table
                  :headers="headers"
                  :items="formattedItems"
                  :search="search"
                  @click:row="addItem"
              />
            </v-form>
            <v-divider class="border-opacity-80"></v-divider>
            <v-card-actions class="justify-center">
              <v-btn
                text
                @click="dialog.value = false"
                color="error"
                outlined
              >Close</v-btn>
            </v-card-actions>
          </v-card>
        </template>
      </v-dialog>
    </template>
</v-app>
</template>

<script>
import { mapGetters } from 'vuex';
import api from '@/services/api';
// import Swal from 'sweetalert2';
import mixins from '@/mixins/mixins';

export default {
  mixins: [mixins],
  name: 'SalesV',
  computed:{
    ...mapGetters(['getUserData']),
    kodeCabang(){
        return this.getUserData.kode_cabang;
    },
    idCabang(){
          return this.getUserData.id_cabang;
        },
        formattedItems() {
            return this.item.map(item => ({
                ...item,
                hpp: this.priceFormat(item.hpp),
            }));
        },
  },
  data() {
    return {
        headers: [
                { text: 'Kode Item', value: 'kode' },
                { text: 'Nama Item', value: 'nama' },
                { text: 'Harga Beli', value: 'hpp' },
                { text: 'Harga Jual', value: 'hjl' },
                { text: 'Satuan', value: 'nama_satuan' },
                { text: 'Item Type', value: 'jenis_item' },
                { text: 'Stok Akhir', value: 'stok_akhir' }
            ],
            items: [
                { text: 'Kode Item', value: 'kode' },
                { text: 'Nama Item', value: 'nama' },
            ],
            selectedItems: [],
            dialog: {
                value: false
            },
            search: '',
            item: [],
            quantities: {},
            transaction: {
              // idCustomer: '',
              // nama: '',
              // kode: '',
              tanggal: '',
              keterangan: '',
            },
            noFaktur: '',
            user: this.getUserData,
        };
    },
    methods: {
    
    addItem(item) {
      this.selectedItems.push(item);
      this.$set(this.quantities, this.selectedItems.length - 1, 1); 
      this.dialog.value = false;
      console.log('selectedItems :', this.selectedItems);
    },
    removeItem(index) {
      this.selectedItems.splice(index, 1);
    },

    updateHjl(index, event) {
      const newValue = event.target.innerText.trim();
      // console.log(`Updating hpp for item at index ${index} to ${newValue}`);
      this.selectedItems[index].hjl = newValue;
  },
    async saveTransaction() {
      if(!this.transaction.tanggal || !this.transaction.keterangan || !this.selectedItems === 0){
        alert("Ada data yang belum lengkap");
        return;
      }

      const transactionData = {
        tanggal: this.transaction.tanggal,
        keterangan: this.transaction.keterangan,
        detail: this.selectedItems.map((item, index) => ({
                id_item_cabang: item.id_item,
                qty: this.quantities[index],
                harga: item.hjl,
            }))
      }
      try {
        const response = await api.post('/t_trans_in', transactionData);
        this.noFaktur = response.data.no_faktur;
        console.log('no faktur:', this.noFaktur);

        console.log('data transaksi:', transactionData)
        alert('transaksi sukses');
      } catch (error) {
        console.log('error simpan data transaksi', error);

      }
      
    },

    resetForm() {
        // Reset the transaction object and selected items
        this.transaction.tanggal = '';
        this.transaction.keterangan = '';
        this.selectedItems = [];
        this.quantities = {};
    },
   


    
    async fetchItemCabang() {
          try {
            const response = await api.get(`/m_item_cabang?kode_cabang=${this.kodeCabang}`);
            this.item = response.data;
            // console.log('Items :', this.item);
            // console.log('unit :', this.unit); // Tambahkan log ini
          } catch (error) {
            console.error('Error fetching unit:', error); // Tambahkan log ini
          }
        },

    async fetchUser() {
          try {
            this.user = this.getUserData;
            console.log('user :', this.user); // Tambahkan log ini
          } catch (error) {
            console.error('Error fetching unit:', error); // Tambahkan log ini
          }
        },
    
  },

  async created() {
      await this.fetchItemCabang();
      await this.fetchUser();
  }

};
</script>

<style scoped>
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

.card h2 {
  margin-top: 0;
  color: #333;
}

.item-list, .selected-items {
  display: flex;
  flex-direction: column;
  gap: 10px;
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

.item button:hover {
  background-color: #0056b3;
}

.flex-container {
  display: flex;
  gap: 10px;
}

.flex-item {
  flex: 1;
}

.form-group {
  margin-top: 15px;
  margin-bottom: 10px;
}

.form-group label {
  display: block;
  margin-bottom: 5px;
  font-weight: bold;
  font-size: 12px; /* Adjust the font size */
  margin: 0; /* Adjust the margin */
}

.form-group input {
  width: 100%;
  padding: 4px; /* Adjust the padding */
  box-sizing: border-box;
  border: 1px solid #ccc;
  border-radius: 4px;
  font-size: 12px; /* Adjust the font size */
  height: 25px; /* Adjust the height */
}

.input-field{
    margin-top: 10px;
}
.qty{
  max-width: 50px
}
.cart-body{
  font-size: 12px;
}
.texthargajual{
  background-color: #dcdee0;
}
.flex-item-button{
  margin-top: 15px;
}


</style>
