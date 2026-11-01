library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_signed.all;
use ieee.numeric_std.all;


entity Circuit_VHDL is
	port (
 		CLK, RST, DCLK : in std_logic;
		M1, M2         : in std_logic;
		PWM_SYNC_RST   : in  std_logic;
 		PWM_frequency  : in  std_logic_vector(24 downto 0);
		A,B,C          : in std_logic;
		Counter_OUT    : out unsigned(24 downto 0);
 		U,V,W,X,Y,Z         : out std_logic
	      );
end Circuit_VHDL;


architecture Behavioral of Circuit_VHDL is
  
  signal Temp1 :  std_logic_vector(24 downto 0);
  signal Temp2 :  std_logic_vector(24 downto 0);
  signal CN5   :  std_logic_vector(24 downto 0);
  signal Temp3 :  std_logic;
  signal D, E  :  std_logic;
 
  Component Filter_m is
	port(
		RESNm : IN std_logic;
		MOUTm : IN std_logic;
		MCLKm : IN std_logic;
		CNRm : IN std_logic;          
		CN5m : OUT std_logic_vector(24 downto 0)
	     );
  end component;

  Component Filter_r is
	port(
		RESNr, MOUTr, MCLKr, CNRr : in std_logic;
		CN5r                      : out std_logic_vector(24 downto 0)
	     ); 
  end component;

  Component pwm_prog is
	port (
 		 i_clk                       : in  std_logic;
 		 i_rstb                      : in  std_logic;
 		 i_sync_reset                : in  std_logic;
 		 i_pwm_module                : in  std_logic_vector(24 downto 0);  -- PWM Freq  = clock freq/ (i_pwm_module+1); max value = 2^N-1
 		 i_pwm_width                 : in  std_logic_vector(24 downto 0);  -- PWM width = (others=>0)=> OFF; i_pwm_module => MAX ON 
		 i_pwm_counter               : out unsigned(24 downto 0);
  		 o_pwm                       : out std_logic
	      );
  end component;

  Component lut is
	port (  
		a : IN std_logic;
		b : IN std_logic;
		c : IN std_logic;
		d : IN std_logic;
		e : IN std_logic;          
		u : OUT std_logic;
		v : OUT std_logic;
		w : OUT std_logic;
		x : OUT std_logic;
		y : OUT std_logic;
		z : OUT std_logic
 	     );
  end component;
   
begin

Sinc_modulator_reference : Filter_r
	port map (
			MOUTr => M1, CN5r => Temp1, MCLKr => CLK, CNRr => DCLK, RESNr =>RST
		 );

Sinc_modulator_measured : Filter_m
	port map (
			MOUTm => M2, CN5m => Temp2, MCLKm => CLK, CNRm => DCLK, RESNm =>RST
		 );

CN5 <= Temp1 XOR Temp2;

PWM_generation : pwm_prog
	port map (
			i_pwm_width => CN5, o_pwm => Temp3, i_clk => CLK, i_rstb => RST, 
			i_sync_reset => PWM_SYNC_RST, i_pwm_module => PWM_frequency, i_pwm_counter => Counter_OUT
		 );

D <= Temp3;
E <= Temp3;

Inst_lut: lut
	port map (
	   a => A,
		b => B,
		c => C,
		d => D,
		e => E,
		u => U,
		v => V,
		w => W,
		x => X,
		y => Y,
		z => Z
			
		 );

end Behavioral;