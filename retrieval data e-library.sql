-- Siapa saja pengguna yang saat ini meminjam lebih dari 1 buku dan buku apa saja yang mereka pinjam?
SELECT 
    u.first_name,
    u.last_name,
    COUNT(l.loan_id) as total_loans,
    STRING_AGG(b.title, ', ') as borrowed_books
FROM "user" u
JOIN loan l ON u.user_id = l.user_id
JOIN library_book lb ON l.library_book_id = lb.library_book_id
JOIN book b ON lb.book_id = b.book_id
WHERE l.return_date IS NULL
GROUP BY u.user_id, u.first_name, u.last_name
HAVING COUNT(l.loan_id) > 1
ORDER BY total_loans DESC;

-- Kategori buku apa yang paling populer berdasarkan jumlah peminjaman dalam 6 bulan terakhir?
SELECT 
    c.category_name,
    COUNT(l.loan_id) as total_loans
FROM category c
JOIN book_category bc ON c.category_id = bc.category_id
JOIN book b ON bc.book_id = b.book_id
JOIN library_book lb ON b.book_id = lb.book_id
JOIN loan l ON lb.library_book_id = l.library_book_id
WHERE l.loan_date >= CURRENT_DATE - INTERVAL '6 months'
GROUP BY c.category_id, c.category_name
ORDER BY total_loans DESC
LIMIT 5;

-- Berapa rata-rata durasi peminjaman buku per library, dan library mana yang memiliki tingkat pengembalian tercepat?
WITH LibraryLoanDurations AS (
  SELECT
    l.name AS library_name,
    loan.return_date - loan.loan_date AS loan_duration_days
  FROM library l
  JOIN library_book lb ON l.library_id = lb.library_id
  JOIN loan ON lb.library_book_id = loan.library_book_id
  WHERE loan.return_date IS NOT NULL
)

SELECT
  library_name,
  ROUND(AVG(loan_duration_days), 2) AS avg_loan_duration_days,
  RANK() OVER (ORDER BY AVG(loan_duration_days) ASC) AS return_rank
FROM LibraryLoanDurations
GROUP BY library_name
ORDER BY avg_loan_duration_days ASC;

-- Berapa jumlah buku yang tersedia dan sedang dipinjam untuk setiap perpustakaan, serta persentase utilisasi koleksi bukunya?
SELECT 
    l.name as library_name,
    SUM(lb.quantity) as total_books,
    COUNT(loan.loan_id) as borrowed_books,
    ROUND((COUNT(loan.loan_id)::numeric / SUM(lb.quantity) * 100), 2) as utilization_percentage
FROM library l
JOIN library_book lb ON l.library_id = lb.library_id
LEFT JOIN loan ON lb.library_book_id = loan.library_book_id 
    AND loan.return_date IS NULL
GROUP BY l.library_id, l.name
ORDER BY utilization_percentage DESC;

-- Siapa saja pengguna paling aktif dalam 3 bulan terakhir berdasarkan kombinasi peminjaman dan reservasi buku, serta berapa total aktivitasnya?
WITH user_activity AS (
    SELECT 
        u.user_id,
        u.first_name,
        u.last_name,
        COUNT(DISTINCT l.loan_id) as loan_count,
        COUNT(DISTINCT h.hold_id) as hold_count
    FROM "user" u
    LEFT JOIN loan l ON u.user_id = l.user_id 
        AND l.loan_date >= CURRENT_DATE - INTERVAL '3 months'
    LEFT JOIN hold h ON u.user_id = h.user_id 
        AND h.hold_date >= CURRENT_DATE - INTERVAL '3 months'
    GROUP BY u.user_id, u.first_name, u.last_name
)
SELECT 
    first_name,
    last_name,
    loan_count as total_borrowed,
    hold_count as total_holds,
    (loan_count + hold_count) as total_activity,
    CASE 
        WHEN (loan_count + hold_count) >= 10 THEN 'Super Active'
        WHEN (loan_count + hold_count) >= 5 THEN 'Active'
        ELSE 'Regular'
    END as user_status
FROM user_activity
WHERE (loan_count + hold_count) > 0
ORDER BY total_activity DESC
LIMIT 10;