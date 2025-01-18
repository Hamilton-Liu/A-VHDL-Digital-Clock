library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity cnt24s is 
	port(	clk, rst, en, sel : in std_logic;  -- sel: 閫夋嫨閫掑锛0'锛夋垨閫掑噺锛1'锛
			co0,co1 : out std_logic;
			qout : out std_logic_vector(7 downto 0)  -- 杈撳嚭璁℃暟鍊
	);
end cnt24s;

architecture behave of cnt24s is
	signal qh, ql : std_logic_vector(3 downto 0);  -- 绉掗挓鍜屽垎閽
	signal tco0,tco1 : std_logic;  -- 杩涗綅淇″彿
begin

	process(rst, clk, en, sel, qh, ql)
	begin
		if (rst = '1') then
			ql <= "0000";  -- 绉掗挓澶嶄綅涓00
			qh <= "0000";  -- 鍒嗛挓澶嶄綅涓00
			tco0 <= '0';    -- 杩涗綅淇″彿澶嶄綅
			tco1 <= '0';
		elsif (rising_edge(clk)) then
			if (en = '1') then
				if (sel = '0') then  -- 閫掑妯″紡
					if(ql = 9)then
						qh<=qh + 1; ql<="0000";
					elsif(qh = 2)and(ql = 3)then
						qh<="0000";ql<="0000";tco0<='1';
					else ql<=ql+1;
					end if;
				end if;
				else  -- 閫掑噺妯″紡
					tco1 <= '0';  -- 閲嶇疆杩涗綅淇″彿
					if (ql = "0000") then  -- 绉掗挓涓00
						ql <= "1001";  -- 绉掗挓褰9
						if (qh = "0000") then  -- 鍒嗛挓涓00
							tco1 <= '1';    -- 璁剧疆杩涗綅淇″彿
						else
							qh <= qh - 1;  -- 鍒嗛挓閫掑噺
						end if;
					else
						ql <= ql - 1;  -- 绉掗挓閫掑噺
					end if;
				end if;
			end if;
	end process;

	-- 杈撳嚭缁撴灉
	qout <= qh & ql;
	co0 <= tco0;
	co1 <= tco1;

end behave;
