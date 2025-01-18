LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity baoshi is
	port ( min, sec :in std_logic_vector ( 7 downto 0 );
			speak1000, speak500: out std_logic );
end baoshi;

architecture behave of baoshi is
begin
    process(min, sec)
    begin
        if (min = "01011001" and (sec = "01010000" or sec = "01010010" or sec = "01010100" or sec = "01010110" or sec = "01011000")) then
            -- 分钟 = 59，秒 = 50, 52, 54, 56, 58
            speak500 <= '1';
            speak1000 <= '0'; -- 确保不激活 speak1000
        elsif (min = "00000000" and sec = "00000000") then
            -- 分钟 = 0，秒 = 0
            speak500 <= '0';
            speak1000 <= '1';
        else
            -- 默认状态：关闭所有输出
            speak500 <= '0';
            speak1000 <= '0';
        end if;
    end process;
end behave;