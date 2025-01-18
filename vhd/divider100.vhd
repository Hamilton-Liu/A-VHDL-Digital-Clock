library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity divider100 is 
	port(	clk:in std_logic;
			hzl:out std_logic);
end divider100;

architecture behave of divider100 is
signal count:std_logic_vector(5 downto 0);
signal clk_out : std_logic;
begin
	process(clk)
	begin
		if(rising_edge(clk))then
			if(count < 50) then
				count <= count+1;
				else
				clk_out <= not clk_out;
				count <= (others=>'0');
			end if;
		end if;
	end process;
	hzl<=clk_out;
end behave;