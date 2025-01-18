library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity cnt24 is 
	port(	clk,rst,en	:	in std_logic;
			co				:	out std_logic;
			qout			:	out std_logic_vector(7 downto 0));
end cnt24;
architecture behave of cnt24 is
signal qh,ql : std_logic_vector(3 downto 0);
signal tco : std_logic;
begin
	process(rst,clk,en,qh,ql)
	begin
	if (rst = '1') then ql <= "0000";qh <= "0000";
	elsif(clk'event and clk = '1')then
		if(en = '1')then tco <= '0';
			if(ql = 9)then
				qh<=qh + 1;ql<="0000";
			elsif(qh = 2)and(ql = 3)then
				qh<="0000";ql<="0000";tco<='1';
			else ql<=ql+1;
			end if;
		else qh<=qh;ql<=ql;
		end if;
	end if;
	qout<=qh & ql;
	co<=tco ;
	end process;
end behave;