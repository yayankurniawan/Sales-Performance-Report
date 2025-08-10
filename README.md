#  Sales-Performance-Report

##  Latar Belakang

Proyek ini bertujuan untuk menganalisis kinerja penjualan di **DQLab Store** dengan menggunakan **MYSQL** sebagai alat utama eksplorasi data. Fokus utama analisis mencakup:

- Efektivitas dan efisiensi promosi
- Identifikasi tren penjualan berdasarkan kategori produk
- Analisis perilaku dan retensi pelanggan berdasarkan periode waktu tertentu

Hasil dari analisis ini diharapkan dapat memberikan **wawasan strategis** yang mendukung pengambilan keputusan bisnis yang lebih tepat dan berbasis data.

---

##  Pertanyaan Bisnis

### 1. Analisis Kinerja Penjualan

- **1A.** Evaluasi performa keseluruhan DQLab Store dari tahun **2009 hingga 2012**, berdasarkan:
  - Jumlah pesanan
  - Total nilai penjualan dari pesanan yang berstatus `finished`

- **1B.** Perbandingan performa penjualan berdasarkan **Product Sub-Category** antara tahun **2011 dan 2012**

### 2. Analisis Efektivitas dan Efisiensi Promosi

- **2A.** Pengukuran **burn rate promosi** secara keseluruhan berdasarkan tahun untuk menilai efisiensi penggunaan anggaran promosi

- **2B.** Pengukuran **burn rate promosi berdasarkan Product Sub-Category** untuk mengetahui efektivitas promosi pada masing-masing segmen produk

### 3. Analisis Perilaku dan Retensi Pelanggan

- **3A.** Analisis jumlah **pelanggan aktif** setiap tahunnya

- **3B.** Identifikasi jumlah **pelanggan baru** yang bergabung setiap tahun

- **3C.** Analisis **cohort** untuk mengukur tingkat **retensi pelanggan** yang pertama kali bergabung pada tahun **2009**

---

##  Deskripsi Dataset

| Kolom                 | Deskripsi                                                                 |
|-----------------------|---------------------------------------------------------------------------|
| `OrderID`             | Identifikasi unik untuk setiap transaksi penjualan                        |
| `Order Status`        | Status pesanan: `finished`, `cancelled`, atau `processing`                |
| `Customer`            | Informasi pelanggan yang melakukan pembelian                              |
| `Order Date`          | Tanggal saat pesanan dibuat                                               |
| `Order Quantity`      | Jumlah unit produk yang dipesan                                           |
| `Sales`               | Nilai penjualan dari pesanan tersebut                                     |
| `Discount %`          | Persentase potongan harga yang diberikan                                  |
| `Discount`            | Nilai nominal potongan harga                                              |
| `Product Category`    | Kategori utama produk yang dijual                                         |
| `Product Sub-Category`| Subkategori produk yang lebih spesifik                                    |

---

##  Tools & Teknologi

- MYSQL
- Spreadsheet 

---

##  Output 
1. Analisis Kinerja Penjualan
- **1A.** Evaluasi performa keseluruhan DQLab Store dari tahun **2009 hingga 2012**, berdasarkan:
  - Jumlah pesanan
  - Total nilai penjualan dari pesanan yang berstatus `finished`
 
```
SELECT 
 YEAR(order_date) AS years, 
 SUM(sales) AS sales, 
 COUNT(*) AS number_of_order 
FROM 
 dqlab_sales_store.sales
WHERE 
 order_status = 'Order Finished'
GROUP BY 
 YEAR(order_date)
ORDER BY 
 years;
```
Output 

<img width="252" height="95" alt="image" src="https://github.com/user-attachments/assets/ad90370f-71ed-4931-9668-ab7ec3b8e1d9" />


