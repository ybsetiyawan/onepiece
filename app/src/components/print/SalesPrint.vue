<template>
    <v-dialog v-model="dialog" max-width="800px">
      <v-container class="invoice-container">
        <v-row>
          <v-col cols="12">
            <v-card class="invoice-card">
              <v-card-title>
                <h5 class="title-mepet">Invoice</h5>
              </v-card-title>
              <v-card-text ref="invoiceContent">
                <div class="invoice-details">
                  <p class="center-invoice-code">FAKTUR</p>
                  <p class="center-invoice-code">{{ transaction.documentNumber }}</p>
                  <div class="flex-container">
                    <!-- <p><strong>Kode Customer:</strong> {{ transaction.kodeCustomer }}</p> -->
                    <p class="flex-container">{{ formatDate(transaction.tanggal) }}</p>
                    <p class="user-print"><strong>User :</strong> {{ transaction.namaUser }}</p>
                  </div>
                  <div class="flex-container">
                  </div>
                  <div class="flex-container">
                    <p><strong>Cabang :</strong> {{ transaction.namaCabang }} </p>
                  </div>
                  <div class="flex-container">
                    <p><strong>Alamat :</strong> {{ transaction.alamatCabang }}</p>
                  </div>
                  <p><strong>Keterangan :</strong> {{ transaction.keterangan }}</p>
                </div>
                <v-simple-table class="invoice-table">
                  <thead>
                    <tr>
                    <th>Kode</th>  
                      <th>Nama Item</th>
                      <th>Harga</th>
                      <th>Qty</th>
                      <th>Total</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr v-for="(item, index) in transaction.items" :key="index">
                        <td>{{ item.kode }}</td>  
                        <td>{{ item.nama }}</td>
                        <td>{{ item.hjl }}</td>
                        <td>{{ item.qty }}</td>
                        <td>{{ item.total }}</td>
                    </tr>
                  </tbody>
                </v-simple-table>
                <div class="total">
                  <strong>SubTotal:</strong> {{ priceFormat(transaction.subtotal) }}
                </div>
              </v-card-text>
            </v-card>
          </v-col>
        </v-row>
      </v-container>
    </v-dialog>
  </template>
  
  <script>
  import mixins from '@/mixins/mixins';
  
  export default {
    mixins: [mixins],
    props: {
      transaction: {
        type: Object,
        required: true
      }
    },
    data() {
      return {
        dialog: true
      };
    },
    methods: {
      formatDate(date) {
        const options = { year: 'numeric', month: 'long', day: 'numeric' };
        return new Date(date).toLocaleDateString('id-ID', options);
      },

     
    
      closeDialogOnEsc(event) {
        if (event.key === 'Escape' && this.dialog) {
          this.dialog = false;
        }
      },
      saveTransaction() {
        // Simpan transaksi di sini
        // ...

        // Setelah menyimpan transaksi, panggil printInvoice
        this.printInvoice();
      },
      printInvoice() {
        const printContents = this.$refs.invoiceContent.innerHTML;
        const originalContents = document.body.innerHTML;

        document.body.innerHTML = printContents;
        window.print();
        document.body.innerHTML = originalContents;
        window.location.reload(); // Optional: Reload the page after printing
      },
    
    },
    mounted() {
      this.printInvoice();
      window.addEventListener('keydown', this.closeDialogOnEsc);
    },
    beforeDestroy() {
      window.removeEventListener('keydown', this.closeDialogOnEsc);
    }
  }
  </script>
  
  <style scoped>
.invoice-container {
  padding: 20px;
  background-color: #f9f9f9b9;
  box-shadow: 0 0 10px 0 rgba(0, 0, 0, 1);
  border-radius: 10px;
}

.invoice-card {
  border-radius: 10px;
  background-color: #f0ecec76;
  box-shadow: 0 0 10px 0 rgba(0, 0, 0, 1);
}

.invoice-details p {
  margin: 5px 0;
}

.invoice-details .invoice-table{
  font-family: 'Times New Roman', Times, serif;
  font-size: 12px;
}
.user-print{
  font-size: 8px;
  text-align: right;
}


.invoice-table {
  margin-top: 20px;
  width: 100%;
  border-collapse: collapse;
}

.invoice-table th, .invoice-table td {
  border: 1px solid #ddd;
  padding: 8px;
  text-align: left;
}

.invoice-table th {
  background-color: #f2f2f2;
  font-weight: bold;
  
}


.total {
  font-weight: bold;
  margin-top: 20px;
  color: rgb(118, 115, 115);
  text-align: right;
  font-size: 15px;
  border: 1px solid #ddd;
  padding: 10px;
  /* border-radius: 10px; */
  width: 100%; /* Make the total div the same width as the table */
  box-sizing: border-box; /* Include padding and border in the element's total width and height */
}

.center-invoice-code {
  text-align: center !important;
  width: 100%;
  font-size: 1.2em;
  font-weight: bold;
  margin: 0;
}

.right-invoice-date {
  text-align: right;
  display: inline-block;
  width: 50%;
}



.flex-container {
  display: flex;
  justify-content: space-between;
}

@media print {
  @page {
    size: 21.59cm 14.00cm;
    margin-top: 0cm; /* Adjust the top margin to move content up */
    margin-right: 1cm;
    margin-bottom: 1cm;
    margin-left: 1cm;
  
  }
  body {
    margin: 0;
    transform: scale(0.6); /* Adjust the scale as needed */
    transform-origin: top left;
    margin-top: -5cm; /* Move content further up */
  }
  .invoice-container {
    width: 100%;
    transform: scale(0.6); /* Adjust the scale as needed */
    transform-origin: top left;
  }
}
</style>
