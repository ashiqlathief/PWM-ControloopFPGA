library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;


entity Filter_r is
	port(
		RESNr, MOUTr, MCLKr, CNRr : in std_logic;
		CN5r                      : out std_logic_vector(24 downto 0)
	     ); 
end Filter_r;


architecture Behavioral of Filter_r is
  signal DN0r, DN1r, DN3r, DN5r : std_logic_vector(24 downto 0);
  signal CN1r, CN2r, CN3r, CN4r : std_logic_vector(24 downto 0);
  signal DELTA1r                : std_logic_vector(24 downto 0);

begin
	process(MCLKr, RESNr)
	begin
		if RESNr = '0' then
			DELTA1r <= (others => '0');
		elsif MCLKr'event and MCLKr = '1' then
			if MOUTr = '1' then
				DELTA1r <= DELTA1r + 1;
			end if;
		end if;
	end process;


	process(RESNr, MCLKr)
	begin
		if RESNr = '0' then
			CN1r <= (others => '0');
			CN2r <= (others => '0');
		elsif MCLKr'event and MCLKr = '1' then
			CN1r <= CN1r + DELTA1r;
			CN2r <= CN2r + CN1r;
		end if;
	end process;


	process(RESNr, CNRr)
	begin
		if RESNr = '0' then
			DN0r <= (others => '0');
			DN1r <= (others => '0');
			DN3r <= (others => '0');
			DN5r <= (others => '0');
		elsif CNRr'event and CNRr = '1' then
			DN0r <= CN2r;
			DN1r <= DN0r;
			DN3r <= CN3r;
			DN5r <= CN4r;
		end if;
	end process;

CN3r <= DN0r - DN1r;
CN4r <= CN3r - DN3r;
CN5r <= CN4r - DN5r;

end Behavioral;
