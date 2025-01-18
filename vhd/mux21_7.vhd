-- 7路二选一选择器

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY mux21_7 IS
    PORT (	A, B : IN std_logic_vector(6 downto 0);
				S : IN STD_LOGIC;
				Y : OUT std_logic_vector(6 downto 0)
	);
END mux21_7;

ARCHITECTURE behavioral OF mux21_7 IS
BEGIN
	Y <= A WHEN S = '0' ELSE B;
END behavioral;