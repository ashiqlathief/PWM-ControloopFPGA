library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;


entity Filter_m is
	port(
		RESNm, MOUTm, MCLKm, CNRm : in std_logic;
	        CN5m                      : out std_logic_vector(24 downto 0)
	     );
end Filter_m;


architecture Behavioral of Filter_m is
  signal DN0m, DN1m, DN3m, DN5m : std_logic_vector(24 downto 0);
  signal CN1m, CN2m, CN3m, CN4m : std_logic_vector(24 downto 0);
  signal DELTA1m                : std_logic_vector(24 downto 0);

begin
	process(MCLKm, RESNm)
	begin
		if RESNm = '0' then
			DELTA1m <= (others => '0');
		elsif MCLKm'event and MCLKm = '1' then
			if MOUTm = '1' then
				DELTA1m <= DELTA1m + 1;
			end if;
		end if;
	end process;


	process(RESNm, MCLKm)
	begin
		if RESNm = '0' then
			CN1m <= (others => '0');
			CN2m <= (others => '0');
		elsif MCLKm'event and MCLKm = '1' then
			CN1m <= CN1m + DELTA1m;
			CN2m <= CN2m + CN1m;
		end if;
	end process;


	process(RESNm, CNRm)
	begin
		if RESNm = '0' then
			DN0m <= (others => '0');
			DN1m <= (others => '0');
			DN3m <= (others => '0');
			DN5m <= (others => '0');
		elsif CNRm'event and CNRm = '1' then
			DN0m <= CN2m;
			DN1m <= DN0m;
			DN3m <= CN3m;
			DN5m <= CN4m;
		end if;
	end process;

CN3m <= DN0m - DN1m;
CN4m <= CN3m - DN3m;
CN5m <= CN4m - DN5m;

end Behavioral;
