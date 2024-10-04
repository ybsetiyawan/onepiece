<template>
  <v-app>
    <v-navigation-drawer app style="background-color: #B0BEC5;">
    <!-- -->
    <v-list dense v-if="username">
        <v-list-item
          v-for="item in items"
          :key="item.title"
          :to="item.link"
          link
        >
          <v-list-item-icon>
            <v-icon>{{ item.icon }}</v-icon>
          </v-list-item-icon>

          <v-list-item-content>
            <v-list-item-title>{{ item.title }}</v-list-item-title>
          </v-list-item-content>
          <v-list-group v-if="item.subItems" no-action sub-group>
            <template v-slot:activator></template>
            <v-list-item v-for="subItem in item.subItems" :key="subItem.title" :to="subItem.link" class="pl-1">
              <v-list-item-icon>
                <v-icon> {{ subItem.icon }}</v-icon>
              </v-list-item-icon>
              <v-list-item-content>
                <v-list-item-title> {{ subItem.title }}</v-list-item-title>
              </v-list-item-content>
            </v-list-item>
          </v-list-group>
        </v-list-item>
      </v-list>
  </v-navigation-drawer>

    <v-app-bar
      app
      color="#78909C"
      dark
      height="60"
    >
    
      <div class="d-flex align-center">
        <v-img
          alt="Vuetify Logo"
          class="shrink mr-2"
          contain
          src="https://cdn.vuetifyjs.com/images/logos/vuetify-logo-dark.png"
          transition="scale-transition"
          width="40"
        />

        
      </div>
      <v-btn
        target="_blank"
        text
      >
        <span class>ONE PIECE CELL</span>
      </v-btn>

      <v-spacer></v-spacer>

      <!-- <v-btn
        v-if="!username"
        text
        to="/login"
      >
        <span class="mr-5">Login</span>
        <v-icon>mdi-login</v-icon>
      </v-btn> -->
      
      <v-btn
        v-if="username"
        text
        @click="dialog.value = true"
        outlined
        elevation="5"
        class="mr-1"
      >
        <span>Hello, {{ nama }} </span>
       
      </v-btn>
      <v-btn
          v-if="username"
          text
          @click="logout"
          title="Logout"
          outlined
          elevation="5">
        <v-icon>mdi-logout</v-icon>
      </v-btn>

    <template>
      <v-dialog
        v-model="dialog.value"
        transition="dialog-top-transition"
        max-width="600"
        overlay-opacity="0.8"

      >
        
        <template v-slot:default="dialog">
          <v-card>
            <v-toolbar
              color="#78909C"
              dark
            >Edit User</v-toolbar>
            <v-form>
              <v-card-text>
                <v-row>
                  <v-col>
                    <v-text-field
                    label="Username"
                    v-model="editUser.username"
                    required
                    type="text"
                    >
                  </v-text-field>
                  </v-col>
                  <v-col>
                    <v-text-field
                    label="Nama"
                    v-model="editUser.nama"
                    required
                    type="text"
                  >
                  </v-text-field>
                  </v-col>
                  <v-col>
                    <v-text-field
                    label="Password"
                    v-model="editUser.password"
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
                @click="updateUser"
                color="success"
                outlined
              >Update</v-btn>
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

    </v-app-bar>
    <v-main>
      <router-view/>
    </v-main>
    <v-footer app class="footer"
      style="background-color: #78909C;"
      dark
      height="30"
    >
      <span>
        &copy; 2024 - ONE PIECE CELL | Aplikasi Inventory Sederhana | Developed by yBs
      </span>
      <v-spacer></v-spacer>
      <span v-if="username">
        Branch : {{ kode_cabang }} - {{ nama_cabang }} | Address : {{ alamat_cabang }}
      </span>
    </v-footer>
  </v-app>
</template>

<script>
import { mapGetters, mapActions } from 'vuex';
import api from '../src/services/api'
import Swal from 'sweetalert2'


export default {
  name: 'App',
  computed:{
    ...mapGetters(['getUserData']),
    user_id() {
      return this.getUserData.user_id;
    },
    username() {
      return this.getUserData.username;
    },
    id_cabang() {
      return this.getUserData.id_cabang;
    },
    nama_cabang() {
      return this.getUserData.nama_cabang;
    },
    alamat_cabang() {
      return this.getUserData.alamat_cabang;
    },
    nama() {
      return this.getUserData.nama;
    },
    kode_cabang() {
      return this.getUserData.kode_cabang;
    },
    id_role() {
      return this.getUserData.id_role; // Ambil id_role dari store
    },
    // filteredItems() {
    //   // Filter items berdasarkan id_role
    //   return this.items.filter(item => {
    //     if (item.title === 'Master') {
    //       return item.title === 'Master' && this.id_role == 4;
    //     }
    //     return true; // Tampilkan item lainnya  
    //   });
    // }
  },
  data: () => ({
    editUser:{},
    dialog:{
      value: false
    },
    items: [
      { title: 'Home', icon: 'mdi-home', link: '/' },
      { 
        title: 'Master',
        icon: 'mdi-database',
        subItems: [
          { title: 'Branch', icon: 'mdi-store-outline',   link: '/branch' },
          { title: 'User', icon: 'mdi-account-outline', link: '/user' },
          { title: 'Unit', icon: 'mdi-cube-send', link: '/unit' },
          { title: 'Item Type', icon: 'mdi-bookshelf', link: '/itemtype' },
          { title: 'Item', icon: 'mdi-pig-variant-outline', link: '/item' },
          { title: 'Item Branch', icon: 'mdi-sheep', link: '/itembranch' },
          // { title: 'Ship', icon: 'mdi-ferry', link: '/ship' },
        ]
      },
      { title: 'Transaction', icon: 'mdi-file-document', subItems: [
        { title: 'Sales', icon: 'mdi-sort-bool-descending-variant', link: '/sales' },
        { title: 'Receipt', icon: 'mdi-sort-bool-ascending-variant', link: '/receipt' },
      ] },
      { title: 'Report', icon: 'mdi-chart-bar', subItems: [
        { title: 'Sales', icon: 'mdi-trending-up', link: '/reportsales' },
      ] },
    ],
  }
), 
methods: {
  ...mapActions(['logout']),
  onUserLoggedIn() {
  },
  logout() {
    this.$store.dispatch('logout');
  },
  updateUser(){
    if(!this.editUser.password || !this.editUser.nama ){
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
    
    api.put(`/m_user/${this.user_id}`, {
      
      username: this.editUser.username,
      password: this.editUser.password,
      id_role: this.getUserData.id_role,
      id_cabang: this.getUserData.id_cabang,
      nama: this.editUser.nama,
      
    })
      .then(() => {
        this.dialog.value = false,
        Swal.fire({
            position: 'top-right',
            icon: 'success',
            title: 'Update User Success!',
            showConfirmButton: false,
            timer: 1500,
            toast: true,
            width: '400px',
            background: 'green',
            color: '#fff',
            padding: '16px',
            iconColor: '#fff',
          });
        this.editUser = {}
        this.logout()
      })
      .catch(error => {
        Swal.fire({
            position: 'top-right',
            icon: 'error',
            title: 'Update User Failed!',
            showConfirmButton: false,
            timer: 1500,
            toast: true,
            width: '400px',
            background: 'red',
            color: '#fff',
            padding: '16px',
            iconColor: '#fff',
            text: error.response.data.message,
          });
      })
  }
},
mounted() {
  // console.log(this.getUserData)
}
};
</script>


<style>
.footer {
  font-family: 'Lucida Sans', 'Lucida Sans Regular', 'Lucida Grande', 'Lucida Sans Unicode', Geneva, Verdana, sans-serif;
  font-size: 14px;
}
</style>
