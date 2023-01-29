-- кількість стрільців що втекли за штатом
DROP PROCEDURE IF EXISTS fled_per_state(char);

CREATE OR REPLACE PROCEDURE fled_per_state(argstate char)
LANGUAGE plpgsql
AS $$
DECLARE fugities record;
  BEGIN
    BEGIN
        SELECT count(shooteroutcome) into fugities
        FROM shooter
        INNER JOIN incident
        ON shooter.incidentid = incident.incident_id
        WHERE shooteroutcome = 'Fled/Escaped' and state = argstate ;
        raise notice 'Escaped in this state: %', fugities ;
END;
  END;
$$;

CALL fled_per_state('LA')