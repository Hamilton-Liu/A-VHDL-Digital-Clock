library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity cnt60s is 
	port(	clk, rst, en, sel : in std_logic;
			co0, co1 : out std_logic;
			qout : out std_logic_vector(7 downto 0)
	);
end cnt60s;

architecture behave of cnt60s is
	signal qh, ql : std_logic_vector(3 downto 0);  -- 秒和分
	signal tco0, tco1 : std_logic;  -- 进位信号
begin

	process(rst, clk, en, sel, qh, ql)
	begin
		if (rst = '1') then
			ql <= "0000";  -- 秒钟复位为 0
			qh <= "0000";  -- 分钟复位为 0
			tco0 <= '0';   -- 进位信号清零
			tco1 <= '0';   -- 进位信号清零
		elsif (rising_edge(clk)) then
			if (en = '1') then
				if (sel = '0') then  -- plus
					tco0 <= '0';  -- 重置进位信号
					if (ql = "1001") then  -- 秒钟到达 59
						ql <= "0000";  -- 秒钟归零
						if (qh = "0101") then  -- 分钟到达 59
							qh <= "0000";  -- 分钟归零
							tco0 <= '1';   -- 设置进位信号
						else
							qh <= qh + 1;  -- 分钟递增
						end if;
					else
						ql <= ql + 1;  -- 秒钟递增
					end if;
				else  -- minus
					tco1 <= '0';  -- 重置进位信号
					if (ql = "0000") then  -- 秒钟为 00
						ql <= "1001";  -- 秒钟归 59
						if (qh = "0000") then  -- 分钟为 00
							qh <= "0101";  -- 分钟归 59
							tco1 <= '1';   -- 设置进位信号
						else
							qh <= qh - 1;  -- 分钟递减
						end if;
					else
						ql <= ql - 1;  -- 秒钟递减
					end if;
				end if;
			end if;
		end if;
	end process;

	-- 输出结果
	qout <= qh & ql;
	co0 <= tco0;
	co1 <= tco1;

end behave;
