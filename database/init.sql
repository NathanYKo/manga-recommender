-- database/init.sql

-- Drop tables if they exist
DROP TABLE IF EXISTS user_ratings;
DROP TABLE IF EXISTS manga_genres;
DROP TABLE IF EXISTS genres;
DROP TABLE IF EXISTS manga;
DROP TABLE IF EXISTS users;

-- Create tables
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE manga (
    manga_id INTEGER PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    title_english VARCHAR(255),
    title_japanese VARCHAR(255),
    synopsis TEXT,
    image_url VARCHAR(255),
    score NUMERIC(3, 2),
    scored_by INTEGER,
    rank INTEGER,
    popularity INTEGER,
    status VARCHAR(50),
    publishing BOOLEAN,
    published_from TIMESTAMP WITH TIME ZONE,
    published_to TIMESTAMP WITH TIME ZONE,
    chapters INTEGER,
    volumes INTEGER,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE genres (
    genre_id INTEGER PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE manga_genres (
    manga_id INTEGER REFERENCES manga(manga_id) ON DELETE CASCADE,
    genre_id INTEGER REFERENCES genres(genre_id) ON DELETE CASCADE,
    PRIMARY KEY (manga_id, genre_id)
);

CREATE TABLE user_ratings (
    user_id INTEGER REFERENCES users(user_id) ON DELETE CASCADE,
    manga_id INTEGER REFERENCES manga(manga_id) ON DELETE CASCADE,
    rating INTEGER NOT NULL CHECK (rating BETWEEN 1 AND 10),
    review TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, manga_id)
);

-- Create indexes for performance
CREATE INDEX idx_manga_title ON manga(title);
CREATE INDEX idx_manga_score ON manga(score);
CREATE INDEX idx_manga_popularity ON manga(popularity);
CREATE INDEX idx_manga_genres ON manga_genres(manga_id, genre_id);
CREATE INDEX idx_user_ratings ON user_ratings(user_id, manga_id, rating);