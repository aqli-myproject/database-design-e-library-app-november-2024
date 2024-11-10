-- Tabel Library untuk menyimpan informasi perpustakaan
CREATE TABLE Library (
    library_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabel Book untuk menyimpan informasi buku
CREATE TABLE Book (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(100),
    published_year DATE,
    quantity INT NOT NULL CHECK (quantity >= 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabel Category untuk menyimpan kategori buku
CREATE TABLE Category (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabel Book_Category untuk mengelompokkan buku ke dalam beberapa kategori
CREATE TABLE Book_Category (
    book_id INT,
    category_id INT,
    PRIMARY KEY (book_id, category_id),
    FOREIGN KEY (book_id) REFERENCES Book(book_id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES Category(category_id) ON DELETE CASCADE
);

-- Tabel User untuk menyimpan informasi pengguna
CREATE TABLE "user" (
    user_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(10) CHECK (status IN ('active', 'inactive')) DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabel Library_Book untuk mendata jumlah buku di tiap perpustakaan
CREATE TABLE Library_Book (
    library_book_id SERIAL PRIMARY KEY,
    library_id INT,
    book_id INT,
    quantity INT DEFAULT 0 CHECK (quantity >= 0),
    FOREIGN KEY (library_id) REFERENCES Library(library_id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES Book(book_id) ON DELETE CASCADE
);

-- Tabel Loan_Limit untuk membatasi peminjaman dan pemesanan buku per pengguna
CREATE TABLE Loan_Limit (
    user_id INT PRIMARY KEY,
    max_loans INT DEFAULT 2 CHECK (max_loans > 0),
    max_holds INT DEFAULT 2 CHECK (max_holds > 0),
    FOREIGN KEY (user_id) REFERENCES "user"(user_id) ON DELETE CASCADE
);

-- Tabel Loan untuk mencatat peminjaman buku
CREATE TABLE Loan (
    loan_id SERIAL PRIMARY KEY,
    user_id INT,
    library_book_id INT,
    loan_date DATE NOT NULL,
    due_date DATE NOT NULL CHECK (due_date = loan_date + INTERVAL '14 days'),
    return_date DATE,
    status VARCHAR(10) DEFAULT 'borrowed' CHECK (status IN ('borrowed', 'returned', 'overdue')),
    FOREIGN KEY (user_id) REFERENCES "user"(user_id) ON DELETE CASCADE,
    FOREIGN KEY (library_book_id) REFERENCES Library_Book(library_book_id) ON DELETE CASCADE
);

-- Tabel Hold untuk mencatat pemesanan buku oleh pengguna
CREATE TABLE Hold (
    hold_id SERIAL PRIMARY KEY,
    user_id INT,
    library_book_id INT,
    hold_date DATE NOT NULL,
    expiration_date DATE NOT NULL CHECK (expiration_date = hold_date + INTERVAL '7 days'),
    queue_position INT NOT NULL,
    status VARCHAR(10) DEFAULT 'active' CHECK (status IN ('active', 'expired', 'ready')),
    FOREIGN KEY (user_id) REFERENCES "user"(user_id) ON DELETE CASCADE,
    FOREIGN KEY (library_book_id) REFERENCES Library_Book(library_book_id) ON DELETE CASCADE
);