CREATE TABLE parking (
   TIMESTAMP,
  lot TEXT,
  available INT
);

COPY parking FROM '/docker-entrypoint-initdb.d/new_parking.csv' HEADER DELIMITER ',' CSV;

CREATE TABLE weather (
  dt TIMESTAMP,
  max_temp INT,
  min_temp INT,
  avg_temp DOUBLE PRECISION,
  precip DOUBLE PRECISION
);

COPY weather FROM '/docker-entrypoint-initdb.d/clean_weather.csv' HEADER DELIMITER ',' CSV;
