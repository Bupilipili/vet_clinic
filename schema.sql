-- Create the animals table
CREATE TABLE animals (
    id serial PRIMARY KEY,
    name VARCHAR(100),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL(5, 2)
);

ALTER TABLE animals
ADD COLUMN species VARCHAR(100);

-- Create the owners table
CREATE TABLE owners (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100),
    age INT
);

-- Create the species table
CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100)
);

-- Modify the animals table
ALTER TABLE animals
    DROP COLUMN IF EXISTS species,
    ADD COLUMN species_id INTEGER REFERENCES species(id),
    ADD COLUMN owner_id INTEGER REFERENCES owners(id);

-- Create the vets table
 CREATE TABLE vets (
    id serial PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    date_of_graduation DATE
);

-- Create the specializations table
CREATE TABLE specializations (
    vet_id INTEGER REFERENCES vets(id),
    species_id INTEGER REFERENCES species(id),
    PRIMARY KEY (vet_id, species_id)
);

   
-- Create the visits table
CREATE TABLE visits (
    animal_id INT,
    vet_id INT,
    visit_date DATE,
    FOREIGN KEY (animal_id) REFERENCES animals(id),
    FOREIGN KEY (vet_id) REFERENCES vets(id)
);

--- pair programmming
-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);


-- CREATE index 
--explain analyze SELECT COUNT(*) FROM visits where animal_id = 4

CREATE INDEX animal_index ON visits(animal_id);


--SELECT * FROM visits where vet_id = 2;
CREATE INDEX vet_id_index ON visits (vet_id);

--SELECT * FROM owners where email = 'owner_18327@mail.com';
CREATE INDEX email_index ON owners (email);
