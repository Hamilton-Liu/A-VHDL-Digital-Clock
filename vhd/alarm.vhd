LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY alarm IS
    PORT (
		  SET_H: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		  SET_M: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		  HOUR: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		  MIN: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		  SPEAKER: OUT STD_LOGIC
		 );
END alarm;
ARCHITECTURE behavioral OF alarm IS	
	BEGIN
		clock_alarm:PROCESS(SET_H, SET_M, HOUR, MIN)
		BEGIN
			IF HOUR = SET_H AND MIN = SET_M THEN
				SPEAKER <= '1';
			ELSE SPEAKER <= '0';
			END IF;
		END PROCESS;
END behavioral;