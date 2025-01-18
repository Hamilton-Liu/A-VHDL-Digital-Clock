LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY bcd7seg IS
	PORT (BCD : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		  HEX : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
END bcd7seg;

ARCHITECTURE behavioral OF bcd7seg IS
	SIGNAL ledag : STD_LOGIC_VECTOR(6 DOWNTO 0);
	BEGIN
		seg : PROCESS(BCD)
		BEGIN
			CASE BCD IS
				when	"0000"=>ledag<="0111111";--0
				when	"0001"=>ledag<="0000110";--1
				when	"0010"=>ledag<="1011011";--2
				when	"0011"=>ledag<="1001111";--3
				when	"0100"=>ledag<="1100110";--4
				when	"0101"=>ledag<="1101101";--5
				when	"0110"=>ledag<="1111101";--6
				when	"0111"=>ledag<="0000111";--7
				when	"1000"=>ledag<="1111111";--8
				when	"1001"=>ledag<="1101111";--9
				when	"1010"=>ledag<="1000000";--dash
				when others =>ledag<="0000000";--default
			END CASE;
		END PROCESS;

		HEX <= ledag;
END behavioral;