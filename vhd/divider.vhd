library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity divider is 
	port(	clk:in std_logic;
			hzl:out std_logic);
end divider;

architecture behave of divider is
signal q:std_logic_vector(9 downto 0);
begin
	process(clk)
	begin
		if(rising_edge(clk))then
			q<=q+1;
		end if;
	end process;
	hzl<= q(9);
end behave;