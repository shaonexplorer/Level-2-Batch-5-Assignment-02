-- Active: 1747479663208@@127.0.0.1@5432@conservation_db

CREATE TABLE rangers (
    ranger_id serial PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    region VARCHAR(200) NOT NULL
)

CREATE TABLE species (
    species_id serial PRIMARY KEY,
    common_name VARCHAR(100) NOT NULL,
    scientific_name VARCHAR(200) NOT NULL,
    discovered_date DATE NOT NULL,
    conservation_status VARCHAR(100) NOT NULL
);

create TABLE sightings (
    sighting_id serial PRIMARY KEY,
    ranger_id INT REFERENCES rangers(ranger_id) on DELETE CASCADE not NULL,
    species_id INT REFERENCES species(species_id) on DELETE CASCADE not NULL,
    sighting_time TIMESTAMP NOT NULL,
    location VARCHAR(200) NOT NULL,
    notes TEXT
);

insert INTO rangers (name, region) VALUES
('Alice Green', 'Northern Hills'),
('Bob White', 'River Delta'),
('Carol King', 'Mountain Range')
 
insert INTO species (common_name, scientific_name, discovered_date, conservation_status) VALUES
('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');

insert INTO sightings (ranger_id, species_id, sighting_time, location, notes) VALUES
(1, 1, '2024-05-10 07:45:00', 'Peak Ridge', 'Camera trap image captured'),
(2, 2, '2024-05-12 16:20:00', 'Bankwood Area', 'Juvenile seen'),
(3, 3, '2024-05-15 09:10:00', 'Bamboo Grove East', 'Feeding observed'),
(2, 1, '2024-05-18 18:30:00', 'Snowfall Pass',NULL);


--1️⃣ Register a new ranger with provided data with name = 'Derek Fox' and region = 'Coastal Plains'
INSERT INTO rangers (name, region) VALUES
('Derek Fox', 'Coastal Plains');
SELECT * FROM rangers

--2️⃣ Count unique species ever sighted.
select count(*) from (select count(*) as "unique_species_count" from species
GROUP BY common_name)

--3️⃣ Find all sightings where the location includes "Pass".
select * from sightings
where location like '%Pass%'

--4️⃣ List each ranger's name and their total number of sightings.
SELECT r.name as "ranger_name", count(*) as "total_sighting_num" from sightings as s
join rangers as r on s.ranger_id = r.ranger_id
GROUP BY r.name
ORDER BY r.name asc

--5️⃣ List species that have never been sighted.
select common_name from species
where species_id NOT IN (select species_id from sightings)

--6️⃣ Show the most recent 2 sightings.
SELECT species.common_name, sightings.sighting_time, rangers.name FROM sightings
JOIN species ON sightings.species_id = species.species_id
JOIN rangers ON sightings.ranger_id = rangers.ranger_id
ORDER BY sighting_time DESC
LIMIT 2;

--7️⃣ Update all species discovered before year 1800 to have status 'Historic'.
update species
set conservation_status = 'Historic'
where extract(year from discovered_date) < 1800;

select * from species;

--8️⃣ Label each sighting's time of day as 'Morning', 'Afternoon', or 'Evening'.
select sighting_id,
CASE 
    WHEN extract(hours from sighting_time)<12 THEN 'Morning'
    WHEN extract(hours from sighting_time)>=12 AND extract(hours from sighting_time)<18 THEN 'Afternoon'
    WHEN extract(hours from sighting_time)>=18 THEN 'Evening' 
END as "time_of_day"
from sightings;

--9️⃣ Delete rangers who have never sighted any species
DELETE from rangers
WHERE ranger_id NOT IN (SELECT ranger_id FROM sightings);

select * from rangers;
 