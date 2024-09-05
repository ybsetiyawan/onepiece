<template>
  <div>
      <v-card>
          <v-card-title>
              <h4>Data Unit</h4>
              <v-spacer></v-spacer>
              <v-btn color="primary" dark @click="add">Add Unit</v-btn>
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
                  <v-col>
                    <v-text-field
                    label="Nama"
                    v-model="edit.nama"
                    required
                    type="text"
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
                @click="isAdd ? save() : update()"
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
        ...mapGetters(['getUnitData']), // Pastikan getter didefinisikan dengan benar
       
    },
    data() {
        return {
            headers: [
                { text: 'Id Satuan', value: 'id' },
                { text: 'Nama Satuan', value: 'nama' },
            ],
            unit: [],
            search: '',
            dialog:{
                value: false
            },
            edit: {},
            isAdd: false,
              
        }
    },
    methods: {
        ...mapActions(['getUnit']), // Pastikan action didefinisikan dengan benar
        async fetchUnit() {
        try {
            await this.getUnit();
            this.unit = this.getUnitData;
            // console.log('unit :', this.unit); // Tambahkan log ini
        } catch (error) {
            console.error('Error fetching unit:', error); // Tambahkan log ini
        }
    },

        handleRowClick(item) {              
            this.dialog.value = true; // Menampilkan dialog saat baris diklik
            this.edit = { ...item }; // Mengisi data untuk diedit
            // console.log('Row clicked:', item); // Ganti dengan logika yang diinginkan
            // this.editUser.kode_role = item.kode_role;
            // this.editUser.nama_cabang = item.nama_cabang;
            this.isAdd = false;

        },
        add() {
            this.dialog.value = true;
            this.edit = {
                nama: '',
            };
            this.isAdd = true;
        },
        async save() {
          if (this.validateInputs(this.edit, ['nama'])) { // Menggunakan metode baru
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
            if (!this.isUnique(this.unit, 'nama', this.edit.nama)) { // Hanya untuk penambahan
              Swal.fire({
                position: 'top',
                icon: 'warning',
                title: 'Nama Unit sudah ada',
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
            await api.post('/m_satuan', {
              nama: this.edit.nama.toUpperCase(),
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
        update() {
            this.isAdd = false;
            if (this.validateInputs(this.edit, ['nama'])) { // Menggunakan metode baru
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
            api.put(`/m_satuan/${this.edit.id}`, {
              nama: this.edit.nama.toUpperCase(),
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
      await this.fetchUnit();
      // console.log('Component created, unit data:', this.unit); //
    }
}
</script>