--цей тригер записує ключ і штат у верхньому регістрі
DROP TRIGGER IF EXISTS trigger_1 ON incident;
DROP FUNCTION IF EXISTS task1;

CREATE OR REPLACE FUNCTION task1() RETURNS TRIGGER
LANGUAGE "plpgsql"
AS
$$
    BEGIN
        UPDATE incident
        SET
            incident_id = upper(incident_id),
            state = upper(state)
        WHERE incident_id = NEW.incident_id;
        RETURN NULL;
    END;
$$;

CREATE TRIGGER trigger_1
AFTER INSERT ON incident
FOR EACH ROW EXECUTE FUNCTION task1();

INSERT INTO incident(incident_id, date, quarter, school, city, state, school_level) VALUES ('20220524wirim', DATE('2022/5/24'),'Spring','Riverside University High School','Milwaukee','wi', 'High');