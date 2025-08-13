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
1. Overall Performance by Year
 
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
Output: 


| years | sales      | number_of_order |
|-------|------------|-----------------|
|  2009 | 4613872681 |            1244 |
|  2010 | 4059100607 |            1248 |
|  2011 | 4112036186 |            1178 |
|  2012 | 4482983158 |            1254 |


2. Overall Performance by Product Sub Category

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
Output: 

| years | product_sub_category           | sales     |
|-------|--------------------------------|-----------|
|  2011 | Chairs & Chairmats             | 622962720 |
|  2011 | Office Machines                | 545856280 |
|  2011 | Tables                         | 505875008 |
|  2011 | Copiers and Fax                | 404074080 |
|  2011 | Telephones and Communication   | 392194658 |
|  2011 | Binders and Binder Accessories | 298023200 |
|  2011 | Storage & Organization         | 285991820 |
|  2011 | Appliances                     | 272630020 |
|  2011 | Computer Peripherals           | 232677960 |
|  2011 | Bookcases                      | 169304620 |
|  2011 | Office Furnishings             | 160471500 |
|  2011 | Paper                          | 111080380 |
|  2011 | Pens & Art Supplies            |  43093800 |
|  2011 | Envelopes                      |  36463900 |
|  2011 | Labels                         |  15607780 |
|  2011 | Scissors, Rulers and Trimmers  |  12638340 |
|  2011 | Rubber Bands                   |   3090120 |
|  2012 | Office Machines                | 811427140 |
|  2012 | Chairs & Chairmats             | 654168740 |
|  2012 | Telephones and Communication   | 422287514 |
|  2012 | Tables                         | 388993784 |
|  2012 | Binders and Binder Accessories | 363879200 |
|  2012 | Storage & Organization         | 356714140 |
|  2012 | Computer Peripherals           | 308014340 |
|  2012 | Copiers and Fax                | 292489800 |
|  2012 | Appliances                     | 266131100 |
|  2012 | Office Furnishings             | 178927480 |
|  2012 | Bookcases                      | 159984680 |
|  2012 | Paper                          | 126896160 |
|  2012 | Envelopes                      |  58629280 |
|  2012 | Pens & Art Supplies            |  43818480 |
|  2012 | Scissors, Rulers and Trimmers  |  36776400 |
|  2012 | Labels                         |  10007040 |
|  2012 | Rubber Bands                   |   3837880 |

3. Promotion Effectiveness and Efficiency by Years
   
Formula untuk burn rate : (total discount / total sales) * 100

```
SELECT
    years,
    sales,
    promotion_value,
    ROUND(
        (promotion_value / sales) * 100, 2 
    ) AS burn_rate_percentage
FROM 
(
SELECT
    EXTRACT(YEAR FROM order_date) AS years,
    SUM(sales) AS sales,
    SUM(discount_value) AS promotion_value
FROM 
    dqlab_sales_store.sales
WHERE 
    order_status = 'Order Finished'
AND 
    EXTRACT(YEAR FROM order_date) 
BETWEEN 
    2009 AND 2012
GROUP BY 
    1
) AS summary_of_year
ORDER BY 
    1;
```

Output : 

| years | sales      | promotion_value | burn_rate_percentage |
|-------+------------|-----------------|----------------------|
| 2009  | 4613872681 |       214330327 |                 4.65 |
| 2010  | 4059100607 |       197506939 |                 4.87 |
| 2011  | 4112036186 |       214611556 |                 5.22 |
| 2012  | 4482983158 |       225867642 |                 5.04 |

4. Promotion Effectiveness and Efficiency by Product Sub Category

```
SELECT
YEAR(order_date) AS years,
product_sub_category,
product_category,
SUM(sales) AS sales,
SUM(discount_value) AS promotion_value,
ROUND((SUM(discount_value)/SUM(sales))*100,2) AS burn_rate_percentage
FROM dqlab_sales_store.sales
WHERE order_status = 'Order Finished'
AND YEAR(order_date) = 2012
GROUP BY 
years,
product_sub_category,
product_category
ORDER BY sales DESC;
```
Output :

| years | product_sub_category           | product_category | sales     | promotion_value | burn_rate_percentage |
|-------|--------------------------------|------------------|-----------|-----------------|----------------------|
|  2012 | Office Machines                | Technology       | 811427140 |        46616695 |                 5.75 |
|  2012 | Chairs & Chairmats             | Furniture        | 654168740 |        26623882 |                 4.07 |
|  2012 | Telephones and Communication   | Technology       | 422287514 |        18800188 |                 4.45 |
|  2012 | Tables                         | Furniture        | 388993784 |        16348689 |                  4.2 |
|  2012 | Binders and Binder Accessories | Office Supplies  | 363879200 |        22338980 |                 6.14 |
|  2012 | Storage & Organization         | Office Supplies  | 356714140 |        18802166 |                 5.27 |
|  2012 | Computer Peripherals           | Technology       | 308014340 |        15333293 |                 4.98 |
|  2012 | Copiers and Fax                | Technology       | 292489800 |        14530870 |                 4.97 |
|  2012 | Appliances                     | Office Supplies  | 266131100 |        14393300 |                 5.41 |
|  2012 | Office Furnishings             | Furniture        | 178927480 |         8233849 |                  4.6 |
|  2012 | Bookcases                      | Furniture        | 159984680 |        10024365 |                 6.27 |
|  2012 | Paper                          | Office Supplies  | 126896160 |         6224694 |                 4.91 |
|  2012 | Envelopes                      | Office Supplies  |  58629280 |         2334321 |                 3.98 |
|  2012 | Pens & Art Supplies            | Office Supplies  |  43818480 |         2343501 |                 5.35 |
|  2012 | Scissors, Rulers and Trimmers  | Office Supplies  |  36776400 |         2349280 |                 6.39 |
|  2012 | Labels                         | Office Supplies  |  10007040 |          452245 |                 4.52 |
|  2012 | Rubber Bands                   | Office Supplies  |   3837880 |          117324 |                 3.06 |

5. Customers Transactions per Year

```

```


## Documentation

<img width="1366" height="729" alt="image" src="https://github.com/user-attachments/assets/6d23d2f3-0a60-4563-991c-530528bd5adc" />

<img width="1366" height="727" alt="image" src="https://github.com/user-attachments/assets/25be2ffe-14f3-4bc9-9971-b68000e0945d" />

<img width="1366" height="727" alt="image" src="https://github.com/user-attachments/assets/0853ef52-7f00-4005-b01e-85aa41837cef" />

<img width="1366" height="729" alt="image" src="https://github.com/user-attachments/assets/a29a079a-62b1-41a8-8f5b-0e3e42f8b0a6" />

