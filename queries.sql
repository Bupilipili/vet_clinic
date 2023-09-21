
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

-- multiple tables Queries

-- Question 1: What animals belong to Melody Pond?
SELECT animals.name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Melody Pond';

-- Question 2: List of all animals that are Pokemon.
SELECT animals.name FROM animals JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';

-- Question 3: List all owners and their animals, including those who don't own any animal.
SELECT owners.full_name, animals.name AS animal_name FROM owners LEFT JOIN animals ON owners.id = animals.owner_id;

-- Question 4: How many animals are there per species?
SELECT species.name, COUNT(animals.id) AS animal_count FROM species LEFT JOIN animals ON species.id = animals.species_id GROUP BY species.name;

-- Question 5: List all Digimon owned by Jennifer Orwell.
SELECT animals.name FROM animals JOIN species ON animals.species_id = species.id JOIN owners ON animals.owner_id = owners.id WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';

-- Question 6: List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animals.name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

-- Question 7: Who owns the most animals?
SELECT owners.full_name, COUNT(animals.id) AS animal_count FROM owners LEFT JOIN animals ON owners.id = animals.owner_id GROUP BY owners.full_name ORDER BY animal_count DESC LIMIT 1;


-- join tables

-- 1.Who was the last animal seen by William Tatcher?
SELECT a.name AS animal_name FROM visits v JOIN animals a ON v.animal_id = a.id JOIN vets vt ON v.vet_id = vt.id WHERE vt.name = 'William Tatcher' ORDER BY v.visit_date DESC LIMIT 1;

-- 2.How many different animals did Stephanie Mendez see?
SELECT COUNT(DISTINCT a.id) AS number_of_animals FROM visits v JOIN animals a ON v.animal_id = a.id JOIN vets vt ON v.vet_id = vt.id WHERE vt.name = 'Stephanie Mendez';

-- 3.List all vets and their specialties, including vets with no specialties.
SELECT v.name AS vet_name, COALESCE(s.name, 'No specialty') AS specialty FROM vets v LEFT JOIN specializations sp ON v.id = sp.vet_id LEFT JOIN species s ON sp.species_id = s.id ORDER BY v.name;

-- 4.List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT a.name AS animal_name, v.visit_date FROM visits v JOIN animals a ON v.animal_id = a.id JOIN vets vet ON v.vet_id = vet.id WHERE vet.name = 'Stephanie Mendez' AND v.visit_date >= '2020-04-01' AND v.visit_date <= '2020-08-30';

-- 5.What animal has the most visits to vets?
SELECT a.name AS animal_name, COUNT(*) AS visit_count FROM visits v JOIN animals a ON v.animal_id = a.id GROUP BY a.name ORDER BY visit_count DESC LIMIT 1;

-- 6.Who was Maisy Smith's first visit?
SELECT a.name AS animal_name, v.visit_date FROM visits v JOIN animals a ON v.animal_id = a.id JOIN vets vet ON v.vet_id = vet.id WHERE vet.name = 'Maisy Smith' ORDER BY v.visit_date LIMIT 1;

-- 7.Details for most recent visit: animal information, vet information, and date of visit.
SELECT a.name AS animal_name, v.visit_date, vet.name AS vet_name, vet.age AS vet_age FROM visits v JOIN animals a ON v.animal_id = a.id JOIN vets vet ON v.vet_id = vet.id ORDER BY v.visit_date DESC LIMIT 1;

-- 8.How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) AS count_of_mismatched_visits FROM visits v JOIN animals a ON v.animal_id = a.id JOIN vets vt ON v.vet_id = vt.id LEFT JOIN specializations sp ON vt.id = sp.vet_id AND a.species_id = sp.species_id WHERE sp.species_id IS NULL;

-- 9.What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT s.name AS recommended_specialty, COUNT(*) AS visits_count FROM visits v JOIN animals a ON v.animal_id = a.id JOIN vets vt ON v.vet_id = vt.id JOIN specializations sp ON vt.id = sp.vet_id JOIN species s ON sp.species_id = s.id WHERE vt.name = 'Maisy Smith' GROUP BY s.name ORDER BY visits_count DESC LIMIT 1;


