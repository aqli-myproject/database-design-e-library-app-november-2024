-- import data tabel book
COPY book(book_id, title, author, published_year, quantity, created_at, updated_at)
FROM 'E:\Pacmann Course\course sql\mentoring week 8 sql\data dummy\book.csv'
DELIMITER ';'
CSV HEADER;

-- import data tabel category
COPY category(category_id, category_name, created_at, updated_at)
FROM 'E:\Pacmann Course\course sql\mentoring week 8 sql\data dummy\category.csv'
DELIMITER ';'
CSV HEADER;

-- import data tabel book_category
COPY book_category(book_id, category_id)
FROM 'E:\Pacmann Course\course sql\mentoring week 8 sql\data dummy\book_category.csv'
DELIMITER ';'
CSV HEADER;

-- import data tabel library
COPY library(library_id, name, address, created_at, updated_at)
FROM 'E:\Pacmann Course\course sql\mentoring week 8 sql\data dummy\library.csv'
DELIMITER ';'
CSV HEADER;

-- import data tabel library_book
COPY library_book(library_book_id, book_id, library_id, quantity)
FROM 'E:\Pacmann Course\course sql\mentoring week 8 sql\data dummy\library_book.csv'
DELIMITER ';'
CSV HEADER;

-- import data tabel user
COPY "user"(user_id, first_name, last_name, username, password, email, registration_date, status, created_at, updated_at)
FROM 'E:\Pacmann Course\course sql\mentoring week 8 sql\data dummy\user.csv'
DELIMITER ','
CSV HEADER;

-- import data tabel loan
COPY loan(loan_id, user_id, library_book_id, loan_date, due_date, return_date, status)
FROM 'E:\Pacmann Course\course sql\mentoring week 8 sql\data dummy\loan.csv'
DELIMITER ','
CSV HEADER;

-- import data tabel hold
COPY hold(hold_id, user_id, library_book_id, hold_date, expiration_date, queue_position, status)
FROM 'E:\Pacmann Course\course sql\mentoring week 8 sql\data dummy\hold.csv'
DELIMITER ','
CSV HEADER;

-- import data tabel loan_limit
COPY loan_limit(user_id, max_loans, max_holds)
FROM 'E:\Pacmann Course\course sql\mentoring week 8 sql\data dummy\loan_limit.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM "user"
SELECT * FROM loan
SELECT * FROM hold
SELECT * FROM loan_limit