<template>
  <div>
      <v-card>
          <v-card-title>
              <h4>Data Branch</h4>
              <v-spacer></v-spacer>
              <v-btn color="primary" dark @click="addCabang">Add Branch</v-btn>
          </v-card-title>
          <v-card-text>
              <v-data-table
                  :headers="headers"
                  :items="cabang"
                  :search="search"
                  @click:row="handleRowClick"
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
              {{ isAdd ? 'Add Branch' : 'Edit Branch' }}
            </v-toolbar>
            <v-form>
              <v-card-text>
                <v-row>
                  <v-col cols="6">
                    <v-text-field
                    
                    label="Kode"
                    v-model="editCabang.kode"
                    required
                    dense
                    :disabled="!isAdd"
                    >
                  </v-text-field>
                  </v-col>
                  <v-col cols="6">
                    <v-text-field
                    label="Nama"
                    v-model="editCabang.nama"
                    required
                    dense
                    >
                  </v-text-field>
                  </v-col>
                  <v-col cols="12">
                    <v-text-field
                    label="Alamat"
                    v-model="editCabang.alamat"
                    required
                    dense
                  >
                  </v-text-field>
                  </v-col>
                  <v-col cols="12">
                    <v-text-field
                    label="Telp"
                    v-model="editCabang.telp"
                    required
                    dense
                  >
                  </v-text-field>
                  </v-col>
                </v-row>
              </v-card-text>
            </v-form>
            <v-divider class="border-opacity-80"></v-divider>
            <v-card-actions class="justify-center">
              <v-btn
                text
                @click="isAdd ? saveCabang() : updateCabang()"
                color="success"
                outlined
              >
                {{ isAdd ? 'Add' : 'Update' }}
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
        ...mapGetters(['getCabangData','getUserData']), // Menghubungkan getter cabang dari Vuex
        userData() {
          return this.getUserData; // Mengambil data user dari store
        }
    },
    data() {
        return {
            headers: [
                { text: 'Kode', value: 'kode' },
                { text: 'Nama', value: 'nama' },
                { text: 'Alamat', value: 'alamat'},
                { text: 'Telp', value: 'telp'},
                
            ],
            cabang: [],
            search: '',
            dialog:{
                value: false
            },
            editCabang: {},
            isAdd: false,
        }
    },
    methods: {
        ...mapActions(['getCabang']),
        async fetchBranches() {
            await this.getCabang(); // Pastikan data diambil sebelum diassign
            this.cabang = this.getCabangData; // Mengambil data cabang dari getter
        },
        handleRowClick(item) {              
            this.dialog.value = true; // Menampilkan dialog saat baris diklik
            this.editCabang = { ...item }; // Mengisi data untuk diedit
            // console.log('Row clicked:', item); // Ganti dengan logika yang diinginkan

        },
        addCabang() {
            this.dialog.value = true;
            this.editCabang = {
                kode: '',
                nama: '',
                alamat: '',
                telp: '',
            };
            this.isAdd = true;
        },
        async saveCabang() {
          if (this.validateInputs(this.editCabang, ['kode', 'nama', 'alamat', 'telp'])) { // Menggunakan metode baru
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
            if (!this.isUnique(this.cabang, 'kode', this.editCabang.kode)) { // Hanya untuk penambahan
              Swal.fire({
                position: 'top',
                icon: 'warning',
                title: 'Kode cabang sudah ada',
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
            await api.post('/m_cabang', {
              kode: this.editCabang.kode,
              nama: this.editCabang.nama.toUpperCase(),
              alamat: this.editCabang.alamat.toUpperCase(),
              telp: this.editCabang.telp,
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
        updateCabang() {
            if (this.validateInputs(this.editCabang, ['kode', 'nama', 'alamat', 'telp'])) { // Menggunakan metode baru
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
            // Tidak perlu memeriksa isUnique saat memperbarui
            api.put(`/m_cabang/${this.editCabang.id}`, {
              kode: this.editCabang.kode,
              nama: this.editCabang.nama.toUpperCase(),
              alamat: this.editCabang.alamat.toUpperCase(),
              telp: this.editCabang.telp,
            })
            .then(() => {
              Swal.fire({
                position: 'top',
                icon: 'success',
                title: 'Update Success',
                showConfirmButton: false,
                timer: 1500,
                toast: true,
                width: '400px',
              })
              this.dialog.value = false; // Tutup dialog setelah pembaruan
              setTimeout(() => {
                location.reload();
              }, 900);
            })
            .catch(error => {
              alert('Update Failed' + error)
            })
            // Tambahkan logika untuk menyimpan perubahan ke Vuex atau API
        },
    },
    async created() {
        // await this.getCabang(); // Tunggu hingga data diambil
        this.fetchBranches(); // Memanggil fetchBranches setelah data diambil
        console.log('user', this.userData); // Menampilkan data user di console
    }
}
</script>