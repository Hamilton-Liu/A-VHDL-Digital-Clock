LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY k_set IS
    PORT (
        Hour_Set, Min_Set, Time_Set : IN STD_LOGIC;
        SET_HOUR, SET_MIN           : OUT STD_LOGIC
    );
END k_set;

ARCHITECTURE behavioral OF k_set IS
    SIGNAL sel_h : STD_LOGIC := '0';
    SIGNAL sel_m : STD_LOGIC := '0';
BEGIN
    set_clock : PROCESS (Time_Set, Hour_Set, Min_Set)
    BEGIN
        IF Time_Set = '1' THEN
            sel_h <= '0';
            sel_m <= '0';
            IF Min_Set = '1' THEN
                sel_m <= '1';
            ELSIF Hour_Set = '1' THEN
                sel_h <= '1';
            END IF;
        ELSE
            sel_h <= '0';
            sel_m <= '0';
        END IF;
    END PROCESS;

    -- Output assignments
    SET_MIN <= sel_m;
    SET_HOUR <= sel_h;

END behavioral;
