-- Simple schema for manga recommender

-- Create genres table
CREATE TABLE IF NOT EXISTS genres (
    genre_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

-- Create authors table
CREATE TABLE IF NOT EXISTS authors (
    author_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Create manga table
CREATE TABLE IF NOT EXISTS manga (
    manga_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    title_english VARCHAR(255),
    synopsis TEXT,
    image_url TEXT,
    score DECIMAL(3,2),
    popularity INTEGER,
    status VARCHAR(20),
    published_from TIMESTAMP,
    published_to TIMESTAMP,
    chapters INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create manga_genres table
CREATE TABLE IF NOT EXISTS manga_genres (
    id SERIAL PRIMARY KEY,
    manga_id INTEGER REFERENCES manga(manga_id),
    genre_id INTEGER REFERENCES genres(genre_id),
    UNIQUE(manga_id, genre_id)
);

-- Create manga_authors table
CREATE TABLE IF NOT EXISTS manga_authors (
    id SERIAL PRIMARY KEY,
    manga_id INTEGER REFERENCES manga(manga_id),
    author_id INTEGER REFERENCES authors(author_id)
);

-- Create users table
CREATE TABLE IF NOT EXISTS users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    email VARCHAR(255) UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create user_ratings table
CREATE TABLE IF NOT EXISTS user_ratings (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(user_id),
    manga_id INTEGER REFERENCES manga(manga_id),
    rating INTEGER CHECK (rating >= 1 AND rating <= 10),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(user_id, manga_id)
);

-- Insert some basic genres
INSERT INTO genres (name) VALUES 
('Action'),
('Adventure'),
('Comedy'),
('Drama'),
('Fantasy'),
('Horror'),
('Mystery'),
('Romance'),
('Sci-Fi'),
('Slice of Life'),
('Supernatural'),
('Thriller');

-- Insert some sample manga
INSERT INTO manga (manga_id, title, title_english, synopsis, score, popularity, status) VALUES
(1, 'Sample Manga 1', 'Sample Manga 1 English', 'This is a sample manga for testing', 7.50, 1000, 'Finished'),
(2, 'Sample Manga 2', 'Sample Manga 2 English', 'Another sample manga for testing', 8.00, 2000, 'Publishing'),
(11, 'Naruto', 'Naruto', 'Naruto Uzumaki, a mischievous adolescent ninja, struggles as he searches for recognition and dreams of becoming the Hokage, the village''s leader and strongest ninja.', 8.07, 5000, 'Finished');

-- Reset sequence after explicit ID insertions
SELECT setval('manga_manga_id_seq', (SELECT MAX(manga_id) FROM manga));

-- Create manga-genre relationships
INSERT INTO manga_genres (manga_id, genre_id) VALUES
(1, 1), -- Sample Manga 1 - Action
(1, 5), -- Sample Manga 1 - Fantasy
(2, 3), -- Sample Manga 2 - Comedy
(2, 8), -- Sample Manga 2 - Romance
(11, 1), -- Naruto - Action
(11, 2), -- Naruto - Adventure
(11, 5); -- Naruto - Fantasy 