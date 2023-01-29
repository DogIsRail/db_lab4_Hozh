--загиблі жертви кожного року
DROP FUNCTION IF EXISTS fatal_per_year(year integer);
CREATE OR REPLACE FUNCTION fatal_per_year(year integer)
RETURNS integer
AS $fatals$
DECLARE fatals integer;
BEGIN
        SELECT count(injury) into fatals
        FROM victim
        INNER JOIN incident
        ON victim.incidentid = incident.incident_id
        WHERE injury = 'Fatal' and EXTRACT(YEAR FROM date) = year;
        RETURN fatals;
END;
$fatals$ LANGUAGE plpgsql;

SELECT fatal_per_year(2022);
