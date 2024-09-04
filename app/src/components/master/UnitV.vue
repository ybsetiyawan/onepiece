<template>
  <div>
      <v-card>
          <v-card-title>
              <h4>Data Unit</h4>
              <v-spacer></v-spacer>
              <v-btn color="primary" dark @click="addUser">Add Unit</v-btn>
          </v-card-title>
          <v-card-text>
              <v-data-table
                  :headers="headers"
                  :items="unit"
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
              {{ isAdd ? 'Add Unit' : 'Edit Unit' }}
            </v-toolbar>
            <v-form>
              <v-card-text>
                <v-row>
                  <v-col cols="6">
                    <v-text-field
                    
                    label="Nama"
                    v-model="editUnit.nama"
                    required
                    type="text"
                    :disabled="!isAdd"
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
                @click="isAdd ? saveUser() : updateUser()"
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
        ...mapGetters(['getUsersData','getCabangData']), // Pastikan getter didefinisikan dengan benar
       
    },
    data() {
        return {
            headers: [
                { text: 'Nama Satuan', value: 'nama' },
            ],
            user: [], // Pastikan ini diinisialisasi
            cabang: [],
            search: '',
            dialog:{
                value: false
            },
            editUser: {},
            isAdd: false,
              
        }
    },
    methods: {
        ...mapActions(['getUsers','getCabang']), // Pastikan action didefinisikan dengan benar
          async fetchUsers() {
            await this.getUsers(); // Memanggil action getUsers untuk mengambil data pengguna
            // console.log('User Data from Getter:', this.getUsersData); // Log data pengguna dari getter
            this.user = this.getUsersData; // Mengambil data pengguna dari getter
        },
        async fetchRoles() {
          try {
            const response = await api.get('/m_role');
            this.roles = response.data;
            // console.log('Role Data:', this.roles);
          } catch (error) {
            console.error('Error fetching roles:', error);
          }
        },
        async fetchBranches() {
          await this.getCabang();
          this.cabang = this.getCabangData;
          // console.log(this.cabang);
        },  
        
        handleRowClick(item) {              
            this.dialog.value = true; // Menampilkan dialog saat baris diklik
            this.editUser = { ...item }; // Mengisi data untuk diedit
            // console.log('Row clicked:', item); // Ganti dengan logika yang diinginkan
            // this.editUser.kode_role = item.kode_role;
            // this.editUser.nama_cabang = item.nama_cabang;
            this.isAdd = false;

        },
        addUser() {
            this.dialog.value = true;
            this.editUser = {
                username: '',
                password: '',
                kode_role: '',
                nama_cabang: '',
                nama: '',
            };
            this.isAdd = true;
        },
        async saveUser() {
          if (this.validateInputs(this.editUser, ['username', 'nama', 'password', 'kode_role', 'nama_cabang'])) { // Menggunakan metode baru
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
            if (!this.isUnique(this.user, 'username', this.editUser.username)) { // Hanya untuk penambahan
              Swal.fire({
                position: 'top',
                icon: 'warning',
                title: 'Username sudah ada',
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
            await api.post('/m_user', {
              username: this.editUser.username,
              password: this.editUser.password,
              id_role: this.editUser.kode_role,
              id_cabang: this.editUser.nama_cabang,
              nama: this.editUser.nama.toUpperCase(),
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
        updateUser() {
            this.isAdd = false;
            if (this.validateInputs(this.editUser, ['username', 'nama', 'password' ])
            || !this.editUser.kode_role || this.editUser.nama_cabang ) { // Menggunakan metode baru
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
            api.put(`/m_user/${this.editUser.id}`, {
              username: this.editUser.username,
              nama: this.editUser.nama.toUpperCase(),
              password: this.editUser.password,
              id_role: this.editUser.kode_role,
              id_cabang: this.editUser.nama_cabang,
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
        },
    },
    async created() {
        await this.fetchBranches(); // Tunggu hingga data diambil
        await this.fetchUsers(); // Memastikan untuk menunggu fetchUsers selesai
        await this.fetchRoles();

    }
}
</script>