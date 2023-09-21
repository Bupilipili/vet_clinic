/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Agumon', '2020-02-03', 0, TRUE, 10.23),
       ('Gabumon', '2018-11-15', 2, TRUE, 8),
       ('Pikachu', '2021-01-07', 1, FALSE, 15.04),
       ('Devimon', '2017-05-12', 5, TRUE, 11);


INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species)
VALUES 
('Charmander', '2020-02-08', 0, FALSE, -11, 'unspecified'),
('Plantmon', '2021-11-15', 2, TRUE, -5.7, 'unspecified'),
('Squirtle', '1993-04-02', 3, FALSE, -12.13, 'unspecified'),
('Angemon', '2005-06-12', 1, TRUE, -45, 'unspecified'),
('Boarmon', '2005-06-07', 7, TRUE, 20.4, 'unspecified'),
('Blossom', '1998-10-13', 3, TRUE, 17, 'unspecified'),
('Ditto', '2022-05-14', 4, TRUE, 22, 'unspecified');
