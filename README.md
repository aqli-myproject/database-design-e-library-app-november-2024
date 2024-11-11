# Design Database e-Library App
- oleh: Moh. Isyroful Aqli | Sekolah Data Pacmann
- implementasi sql design struktur database pada aplikasi e-library

## Database Specification:
- Objective
- Design Requirements
- ERD struktur

## Objective:
- Mendesain sistem relational database untuk layanan aplikasi e-library yang mampu mengelola berbagai perpustakaan, dengan koleksi varian buku dan beragam jumlah kuantitasnya serta data pengguna yang meminjam dan memesan buku. Sehingga aplikasi e-library dapat: 1) Memudahkan untuk pengelolaan antar perpustakaan; 2) Memudahkan pengguna untuk meminjam buku; 3) Memudahkan pengguna untuk memesan buku untuk tersedia dipinjam berikutnya
- Untuk mengecek apakah database yang dibuat berjalan dengan baik, perlu membuat dummy data untuk setiap tabel yang telah dibuat
- Melakukan retrieval data untuk menguji berjalannya syntax bisa diterapkan pada desain struktur tabel yang telah dibuat

## Design Requirements:
### Features: 
- Manajemen Perpustakaan yang Terintegrasi, aplikasi mengelola beberapa perpustakaan sekaligus, masing-masing memiliki koleksi buku yang beragam dengan jumlah ketersediaan berbeda.
- Database menyimpan informasi lengkap tentang buku, termasuk judul, penulis, dan jumlah buku yang tersedia di setiap perpustakaan.
- Buku-buku dikelompokkan ke dalam kategori seperti pengembangan diri, biografi, fantasi, romansa, fiksi ilmiah, dan lainnya untuk memudahkan pencarian.
- Registrasi Pengguna, pengguna dapat mendaftar di platform e-library untuk mendapatkan akses fitur, seperti peminjaman buku, penahanan (hold), dan pengelolaan akun.
- Sistem Peminjaman Buku (Loan) Pengguna dapat meminjam buku dari perpustakaan mana pun jika tersedia, dengan durasi peminjaman 2 minggu. Pengguna dapat mengembalikan buku lebih awal dari tanggal jatuh tempo. Buku akan otomatis dikembalikan apabila melebihi tanggal jatuh tempo. Setiap pengguna hanya bisa meminjam maksimal 2 buku dalam satu waktu.
- Sistem Pemesanan Buku (Hold), Pengguna dapat memesan buku yang saat itu sedang tidak tersedia. Pemesanan ini memungkinkan pengguna mendapatkan buku ketika tersedia lagi. Perpustakaan memiliki antrean pemesanan, di mana pengguna yang berada di posisi teratas akan diberi kesempatan pertama untuk meminjam buku saat tersedia. Pengguna memiliki waktu 1 minggu untuk meminjam buku yang dipesan; jika tidak dipinjam dalam waktu tersebut, buku akan tersedia kembali bagi pengguna lain. Setiap pengguna hanya dapat memesan maksimal 2 buku dalam satu waktu.
- Platform mencatat semua transaksi peminjaman, termasuk tanggal peminjaman, tanggal jatuh tempo, dan tanggal pengembalian, sehingga mudah dilacak.

### Limitations:
- Pembatasan Jumlah Peminjaman dan Pemesanan. Pengguna hanya bisa meminjam maksimal 2 buku dan memesan 2 buku sekaligus, membatasi fleksibilitas dalam meminjam dan pemesanan lebih banyak buku.
- Aturan Pengembalian Otomatis. Sistem mengembalikan buku secara otomatis saat melewati tanggal jatuh tempo.
- Pemesanan dengan Batas Waktu Tertentu. Pengguna harus meminjam buku yang dipesan dalam waktu 1 minggu, yang dapat menjadi batasan jika pengguna memerlukan waktu lebih untuk mengambil buku.
- Beberapa aspek bisa ditangani back_end Aplikasi. Beberapa aturan seperti pengembalian otomatis, kemudian batas peminjaman dan pemesanan dikelola oleh aplikasi, sehingga database tidak secara langsung mengatur pembatasan ini harus ada kolaborasi

## ERD Struktur Database
![ERD Diagram](https://github.com/aqli-myproject/database-design-e-library-app-november-2024/blob/master/erd%20e-library.png)


# Tools
- postgreSQL (pgAdmin4 & dbeaver)
- python jupyter notebook

## Create Tabel Query
file terlampir

## Create Dummy Dataset With Faker
file terlampir

## Query Import Data
file terlampir

## Query Retrieval Data
file terlampir
