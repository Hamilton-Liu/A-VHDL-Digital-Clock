LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY anticnt IS
    PORT (
        h: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        m: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        s: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        SPEAKER, isCnt: OUT STD_LOGIC;
        clk: IN STD_LOGIC
    );
END anticnt;

ARCHITECTURE behavioral OF anticnt IS
BEGIN  
	 clock_alarm: PROCESS(clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF (h = "00000000" AND m = "00000000" AND s = "00000000") THEN
                SPEAKER <= '1';
                isCnt <= '0';  
				ELSE
                SPEAKER <= '0';
					 isCnt <= '1';
            END IF;
        END IF;
    END PROCESS;
END behavioral;
