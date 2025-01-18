library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity selector is
	port(	clk	:	in std_logic;
			h,m,s	:	in std_logic_vector(7 downto 0);
			sel	:	buffer std_logic_vector(2 downto 0));
end selector;
architecture behave of selector is
signal key:std_logic_vector(3 downto 0);
begin
	p1:process(clk)	
		begin
			if rising_edge(clk) then
				case sel is
                when "111" => sel <= "110";
                when "110" => sel <= "101";
                when "101" => sel <= "100";
                when "100" => sel <= "011";
                when "011" => sel <= "010";
                when "010" => sel <= "001";
                when "001" => sel <= "000";
                when "000" => sel <= "111";
                when others => sel <= "111";
            end case;
			end if;
		end process p1;
	p2:process(sel,s,m,h)
		begin
			case sel is
				when "111" => key <= s(3 downto 0);
            when "110" => key <= s(7 downto 4);
            when "101" => key <= "1010";
            when "100" => key <= m(3 downto 0);
            when "011" => key <= m(7 downto 4);
            when "010" => key <= "1010";
				when "001" => key <= h(3 downto 0);
				when "000" => key <= h(7 downto 4);
            when others => key <= "0000";                
			end case;
		end process p2;
end behave;
			