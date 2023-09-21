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

