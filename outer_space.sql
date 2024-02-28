-- CREATE DATABASE outer_space;

\c outer_space

CREATE TABLE stars(
    -- just names bc already in stars
    star_names TEXT PRIMARY KEY,
    -- temp_in_kelvin
    temp_of_stars INT NOT NULL
);

CREATE TABLE planets(
    planet_names TEXT PRIMARY KEY,
    -- When measured, use float
    orbital_period NUMERIC(10,3) NOT NULL,
    -- planet would only have one star call it singular
    stars TEXT
        NOT NULL REFERENCES stars
);

CREATE TABLE moons(
    moon_names TEXT PRIMARY KEY,
    planets TEXT
        NOT NULL REFERENCES planets
);

INSERT INTO stars
    (star_names, temp_of_stars)
    VALUES
    ('The Sun', 5800),
    ('Proxima Centauri', 3042),
    ('Gliese 876', 3192);

INSERT INTO planets
    (planet_names, orbital_period, stars)
    VALUES
    ('Earth', 1.00, 'The Sun'),
    ('Mars', 1.882, 'The Sun'),
    ('Venus', 0.62, 'The Sun'),
    ('Proxima Centauri b', 0.03, 'Proxima Centauri'),
    ('Gliese 876 b', 0.236, 'Gliese 876');

INSERT INTO moons
    (moon_names, planets)
    VALUES
    ('The Moon', 'Earth'),
    ('Phobos', 'Mars'),
    ('Deimos', 'Mars');
    ('', 'Venus');
    ('', 'Proxima Centauri b');
    ('', 'Gliese 876 b');

SELECT planets.planet_names as planet, stars.star_names as star, COUNT(moon_names)
FROM planets INNER JOIN stars ON (planets.stars = stars.star_names)
LEFT OUTER JOIN moons ON (moons.planets = planets.planet_names)
GROUP BY planet_names, star_names ORDER BY planets.planet_names;

