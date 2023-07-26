USE Book_Goodreads_df;

SELECT * FROM book;

SELECT * FROM book_author;

SELECT * FROM book_genre;

SELECT * FROM unique_genre;

#how many genres do we have (in my db)?
SELECT COUNT(genre_id) FROM unique_genre;

#How many english books do we have (in my db)?
SELECT COUNT(DISTINCT original_title) AS English_book_number 
FROM book 
WHERE language_code = 'eng';

#Number of published books in each year
SELECT 
    original_publication_year, 
    COUNT(*) AS book_number
FROM book GROUP BY original_publication_year;

#Number of published english books in each year
SELECT original_publication_year, COUNT(*) AS number_of_English_books
FROM book
WHERE language_code = 'eng'
GROUP BY original_publication_year;

#Number of total published books, and published English boosks per year and share of English books
SELECT 
    original_publication_year,
    COUNT(*) AS number_of_books,
    SUM(CASE WHEN language_code = 'eng' THEN 1 ELSE 0 END) AS number_of_eng_books,
    SUM(CASE WHEN language_code = 'eng' THEN 1 ELSE 0 END) / COUNT(*) * 100 AS percentage_of_eng_books
FROM book
GROUP BY original_publication_year;
    
# I want to get the book titles with their author names
SELECT 
    b.original_title AS book_title,
    a.author_name
FROM book AS b
JOIN book_author AS ba ON b.goodreads_book_id = ba.goodreads_book_id
JOIN authors AS a ON ba.author_id = a.author_id;
 
 
# let's check JRR Tolkien books 
SELECT 
    b.original_title AS book_title,
    a.author_name
FROM book AS b
JOIN book_author AS ba ON b.goodreads_book_id = ba.goodreads_book_id
JOIN authors AS a ON ba.author_id = a.author_id
WHERE a.author_name = 'JRR Tolkien';
    
#let's check the genres of my books
SELECT 
    b.original_title AS book_title,
    g.genre AS genre_name
FROM book AS b
JOIN book_genre AS bg ON b.goodreads_book_id = bg.goodreads_book_id
JOIN unique_genre AS g ON bg.genre_id = g.genre_id;


#let's gather all the genres of a book in a row    
SELECT 
    b.original_title AS book_title,
    GROUP_CONCAT(g.genre SEPARATOR ', ') AS genre_names
FROM book AS b
JOIN book_genre AS bg ON b.goodreads_book_id = bg.goodreads_book_id
JOIN unique_genre AS g ON bg.genre_id = g.genre_id
GROUP BY b.original_title;
    
    

#number of books per genre (I think there is something wrong with my imported data because the result is not correct)
SELECT genre, COUNT(DISTINCT b.goodreads_book_id) AS number_of_books
FROM book AS b
JOIN book_genre AS bg ON b.goodreads_book_id = bg.goodreads_book_id
JOIN unique_genre AS g ON bg.genre_id = g.genre_id
GROUP BY g.genre;

#number of books per author
SELECT author_name, COUNT(DISTINCT b.goodreads_book_id) AS number_of_books
FROM book AS b
JOIN book_author AS ba ON b.goodreads_book_id = ba.goodreads_book_id
JOIN authors AS a ON ba.author_id = a.author_id
GROUP BY author_name;

