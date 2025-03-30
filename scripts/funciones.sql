SET GLOBAL log_bin_trust_function_creators = 1;

drop function if exists max_fecha;
DELIMITER //
CREATE FUNCTION max_fecha(p_idempleado int)  
RETURNS datetime
BEGIN
    DECLARE v_max_fecha datetime;
    SELECT max(fechahoradesde) into v_max_fecha from movimientos  where idempleado = p_idempleado;
        -- Handle NULL cases explicitly
    IF v_max_fecha IS NULL THEN
        SET v_max_fecha = STR_TO_DATE('1980-01-01T14:39:01.123', '%Y-%m-%dT%H:%i:%s.%f');
    END IF;
    RETURN (v_max_fecha);
END//

DELIMITER ;
