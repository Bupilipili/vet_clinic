
/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE (neutered = true) AND (escape_attempts < 3);
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

BEGIN;

UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species = 'unspecified';

-- Verify changes

COMMIT;
-- Verify changes after commit

BEGIN;

DELETE FROM animals;
-- Verify deletion

ROLLBACK;
-- Verify rollback

BEGIN;

DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT savepoint1;
UPDATE animals SET weight_kg = weight_kg * -1;

ROLLBACK TO savepoint1;
UPDATE animals SET weight_kg = CASE WHEN weight_kg < 0 THEN weight_kg * -1 ELSE weight_kg END;

COMMIT;

-- Query 1: How many animals are there?
SELECT COUNT(*) AS total_animals FROM animals;

-- Query 2: How many animals have never tried to escape?
SELECT COUNT(*) AS non_escape_animals FROM animals WHERE escape_attempts = 0;

-- Query 3: What is the average weight of animals?
SELECT AVG(weight_kg) AS average_weight FROM animals;

-- Query 4: Who escapes the most, neutered or not neutered animals?
SELECT neutered, MAX(escape_attempts) AS max_escape_attempts FROM animals GROUP BY neutered;

-- Query 5: What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight FROM animals GROUP BY species;

-- Query 6: What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) AS avg_escape_attempts FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

