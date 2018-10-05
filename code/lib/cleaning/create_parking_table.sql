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

CREATE TABLE hourly_parking AS
SELECT date_trunc('hour', dt) dt_hour, lot, AVG(available) hr_avail
FROM parking
WHERE lot LIKE 'Structure %'
GROUP BY lot, date_trunc('hour', dt);


CREATE TABLE merged_hourly AS
SELECT a.dt_hour, a.lot, a.hr_avail, b.max_temp, b.min_temp, b.avg_temp, b.precip
FROM hourly_parking a
LEFT JOIN weather b
ON (date_trunc('day', a.dt_hour) = date_trunc('day', b.dt))
ORDER BY a.dt_hour, a.lot;
