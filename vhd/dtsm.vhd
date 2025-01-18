library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity dtsm is
	port(	clk	:	in std_logic;
			h,m,s	:	in std_logic_vector(7 downto 0);
			ledag	:	out std_logic_vector(6 downto 0);
			sel	:	buffer std_logic_vector(2 downto 0));
end dtsm;
architecture behave of dtsm is
signal key:std_logic_vector(3 downto 0);
signal sell:std_logic_vector(7 downto 0);
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
	p2:process(key)
		begin
			case key is 
				when	"0000"=>ledag<="0111111";
				when	"0001"=>ledag<="0000110";
				when	"0010"=>ledag<="1011011";
				when	"0011"=>ledag<="1001111";
				when	"0100"=>ledag<="1100110";
				when	"0101"=>ledag<="1101101";
				when	"0110"=>ledag<="1111101";
				when	"0111"=>ledag<="0000111";
				when	"1000"=>ledag<="1111111";
				when	"1001"=>ledag<="1101111";
				when	"1010"=>ledag<="1000000";
				when others =>ledag<="0000000";
			end case;
		end process p2;
	p3:process(sel,s,m,h)
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
		end process p3;
end behave;
			