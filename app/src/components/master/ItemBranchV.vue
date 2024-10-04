<template>
  <div>
      <v-card>
          <v-card-title>
              <h4>Data Item Branch</h4>
              <v-spacer></v-spacer>
              <v-btn color="primary" dark @click="add">Add Item</v-btn>
          </v-card-title>
          <v-card-text>
              <v-data-table
                  :headers="headers"
                  :items="formattedItems"
                  :search="search"
              />
          </v-card-text>
      </v-card>

      <template>
      <v-dialog
        v-model="dialog.value"
        transition="dialog-top-transition"
        max-width="600"
        overlay-opacity="0.8"
      >
        
        <template v-slot:default="dialog">
          <v-card>
            <v-toolbar color="#78909C" dark >
              Add Item Branch
            </v-toolbar>
            <v-form>
              <v-card-text>
                <v-row>
                  <v-col cols="12">
                    <v-select
                    label="Select Item"
                    v-model="edit.kode"
                    :items="availableItems"
                    item-value="id"
                    item-text="nama"
                    required
                    dense
                   >
                   <template v-slot:item="data">
                    <div class="small-item">
                      {{ data.item.kode }} - {{ data.item.nama }} - {{ priceFormat(data.item.hpp) }}
                    </div>
                   </template>
                    </v-select>
                  </v-col>
                  
                  <!-- <v-col cols="4">
                    <v-text-field
                    label="Stok Awal"
                    v-model="edit.stok_awal"
                    required
                    dense
                    disabled

                  >
                  </v-text-field>
                  </v-col>
                  <v-col cols="4">
                    <v-text-field
                    label="Stok Akhir"
                    v-model="edit.stok_akhir"
                    required
                    dense
                  >
                  </v-text-field>
                  </v-col> -->
                </v-row>
              </v-card-text>
            </v-form>
            <v-divider class="border-opacity-80"></v-divider>
            <v-card-actions class="justify-center">
              <v-btn
                text
                @click="save"
                color="success"
                outlined
              >
              Add
              </v-btn>
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
  </div>
</template>


<script>
import { mapActions, mapGetters } from 'vuex';
import api from '@/services/api';
import Swal from 'sweetalert2';
import mixins from '@/mixins/mixins';

export default {
  mixins: [mixins], // Menambahkan mixin ke dalam komponen
  computed: {
        ...mapGetters(['getUnitData','getUserData','getItemData','getItemTypeData']), // Pastikan getter didefinisikan dengan benar
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
                hjl: this.priceFormat(item.hjl)
            }));
        },
        availableItems() {
          const existingItemIds = this.formattedItems.map(item => item.kode);
          return this.items.filter(item => !existingItemIds.includes(item.kode));
        }
       
    },
    data() {
        return {
            headers: [
                { text: 'Branch', value: 'kode_cabang'},
                { text: 'Kode Item', value: 'kode' },
                { text: 'Nama Item', value: 'nama' },
                { text: 'Harga Beli', value: 'hpp' },
                { text: 'Harga Jual', value: 'hjl'},
                { text: 'Satuan', value: 'nama_satuan'},
                { text: 'Item Type', value: 'jenis_item'},
                { text: 'Stok Awal', value: 'stok_awal' },
                { text: 'Stok Akhir', value: 'stok_akhir'},
            ],
            item: [],
            user: this.getUserData,
            search: '',
            dialog:{
                value: false
            },
            edit: {},
            isAdd: false,
              
        }
    },
    methods: {
        ...mapActions(['getUnit', 'getItem', 'getItemType']), // Pastikan action didefinisikan dengan benar
        
        async fetchUnit() {
          try {
            await this.getUnit();
            this.unit = this.getUnitData;
            // console.log('unit :', this.unit); // Tambahkan log ini
          } catch (error) {
            console.error('Error fetching unit:', error); // Tambahkan log ini
          }
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
            // console.log('user :', this.user); // Tambahkan log ini
          } catch (error) {
            console.error('Error fetching unit:', error); // Tambahkan log ini
          }
        },

        async fetchItem() {
          try {
            await this.getItem();
            this.items = this.getItemData;
            // console.log('Items All :', this.items); // Tambahkan log ini
          } catch (error) {
            console.error('Error fetching unit:', error); // Tambahkan log ini
          }
        },

        async fetchItemType() {
          try {
            await this.getItemType();
            this.itemtype = this.getItemTypeData;
            // console.log('unit :', this.unit); // Tambahkan log ini
          } catch (error) {
            console.error('Error fetching unit:', error); // Tambahkan log ini
          }
        },
    

        // handleRowClick(item) {              
        //     this.dialog.value = true; // Menampilkan dialog saat baris diklik
        //     this.edit = { ...item }; // Mengisi data untuk diedit
        //     // console.log('Row clicked:', item); // Ganti dengan logika yang diinginkan
        //     // this.editUser.kode_role = item.kode_role;
        //     // this.editUser.nama_cabang = item.nama_cabang;
        //     this.isAdd = false;

        // },
        add() {
            this.dialog.value = true;
            // this.edit = {
            //     nama: '',
            // };
            this.isAdd = true;
        },
        async save() {
          if (this.validateInputs(this.edit, ['kode'])) { // Menggunakan metode baru
              Swal.fire({
                position: 'top',
                icon: 'warning',
                title: 'Ada inputan yang kosong',
                showConfirmButton: false,
                timer: 1500,
                toast: true,
                width: '400px',
                background: '#EF9A9A',
                color: '#fff',
                padding: '16px',
                iconColor: '#fff',
              });
              return;
            }
            await api.post('/m_item_cabang', {
              id_item: this.edit.kode,
              stok_awal: 0,
              stok_akhir: 0,
              id_cabang: this.idCabang,
            })
            .then(() => {
              Swal.fire({
                position: 'top',
                icon: 'success',
                title: 'Add Success',
                showConfirmButton: false,
                timer: 1500,
                toast: true,
                width: '400px',
              })
              this.dialog.value = false;
              setTimeout(() => {
                location.reload();
              }, 900);
            })
            .catch(error => {
              alert('Add Failed' + error)
            })
        },
        // update() {
        //     this.isAdd = false;
        //     if (this.validateInputs(this.edit, ['kode', 'stok_awal', 'stok_akhir'])) { // Menggunakan metode baru
        //         Swal.fire({
        //             position: 'top',
        //             icon: 'warning',
        //             title: 'Ada inputan yang kosong',
        //             showConfirmButton: false,
        //             timer: 1500,
        //             toast: true,
        //             width: '400px',
        //             background: '#EF9A9A',
        //             color: '#fff',
        //             padding: '16px',
        //             iconColor: '#fff',
        //         });
        //         return;
        //     }
        //     // Tidak perlu memeriksa isUnique saat memperbarui  
        //     api.put(`/m_satuan/${this.edit.id}`, {
        //       nama: this.edit.nama.toUpperCase(),
        //     })
        //     .then(() => {
        //       Swal.fire({
        //         position: 'top',
        //         icon: 'success',
        //         title: 'Update Success',
        //         showConfirmButton: false,
        //         timer: 1500,
        //         toast: true,
        //         width: '400px',
        //       })
        //       this.dialog.value = false; // Tutup dialog setelah pembaruan
        //       setTimeout(() => {
        //         location.reload();
        //       }, 900);
        //     })
        //     .catch(error => {
        //       alert('Update Failed' + error)
        //     })
        // },
    },
    async created() {
      await this.fetchUnit();
      await this.fetchItemCabang();
      this.fetchUser();
      await this.fetchItem();
      await this.fetchItemType();
      // console.log('Component created, unit data:', this.unit); //
      // console.log('kode_cabang :', this.getUserData.kode_cabang)
    },
}
</script>

<style scoped>
.small-item {
  font-size: 12px;
  padding: 4px;
}
</style>