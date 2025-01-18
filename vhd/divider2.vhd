library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity divider2 is 
	port(	clk:in std_logic;
			hzl:out std_logic);
end divider2;

architecture behave of divider2 is
signal clk_out : std_logic :='0';
begin
	process(clk)
	begin
		if rising_edge(clk) then
			clk_out <= not clk_out;
		end if;
	end process;
	hzl<=clk_out;
end behave;