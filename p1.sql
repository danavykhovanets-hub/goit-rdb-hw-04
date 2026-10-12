

CREATE DATABASE IF NOT EXISTS LibraryManagement
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE LibraryManagement;

-- --- Таблиці без зв'язків ---------------

CREATE TABLE authors (
  author_id   INT AUTO_INCREMENT PRIMARY KEY,
  author_name VARCHAR(100) NOT NULL
);

CREATE TABLE genres (
  genre_id   INT AUTO_INCREMENT PRIMARY KEY,
  genre_name VARCHAR(100) NOT NULL
);

CREATE TABLE users (
  user_id  INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(100) NOT NULL,
  email    VARCHAR(150) NOT NULL
);

-- --- Таблиці зі зв'язками -----

CREATE TABLE books (
  book_id          INT AUTO_INCREMENT PRIMARY KEY,
  title            VARCHAR(200) NOT NULL,
  publication_year YEAR,
  author_id        INT,
  genre_id         INT,
  CONSTRAINT fk_books_author
    FOREIGN KEY (author_id) REFERENCES authors(author_id),
  CONSTRAINT fk_books_genre
    FOREIGN KEY (genre_id)  REFERENCES genres(genre_id)
);

CREATE TABLE borrowed_books (
  borrow_id   INT AUTO_INCREMENT PRIMARY KEY,
  book_id     INT,
  user_id     INT,
  borrow_date DATE,
  return_date DATE,
  CONSTRAINT fk_borrow_book
    FOREIGN KEY (book_id) REFERENCES books(book_id),
  CONSTRAINT fk_borrow_user
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

INSERT INTO authors (author_name) VALUES
  ('Ліна Костенко'),
  ('George Orwell');

INSERT INTO genres (genre_name) VALUES
  ('Поезія'),
  ('Антиутопія');

INSERT INTO users (username, email) VALUES
  ('dana_v',  'dana@example.com'),
  ('reader1', 'reader1@example.com');

INSERT INTO books (title, publication_year, author_id, genre_id) VALUES
  ('Маруся Чурай', 1979, 1, 1),
  ('1984',         1949, 2, 2);

INSERT INTO borrowed_books (book_id, user_id, borrow_date, return_date) VALUES
  (1, 1, '2026-10-01', '2026-10-10'),
  (2, 2, '2026-10-05', NULL);