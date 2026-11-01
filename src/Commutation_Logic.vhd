library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity lut is
Port (
a : in STD_LOGIC; 
b : in STD_LOGIC; 
c : in STD_LOGIC; 
d : in STD_LOGIC; 
e : in STD_LOGIC;
u : out STD_LOGIC; 
v : out STD_LOGIC; 
w : out STD_LOGIC; 
x : out STD_LOGIC; 
y : out STD_LOGIC; 
z : out STD_LOGIC);  

end lut;   

architecture Behavioral of lut is  


begin 
process(a,b,c,d,e) 
begin
if d='1' 
then 
  u<='1';
  v<='1';
  w<='1';
  x<='1';
  y<='1';
  z<='1';
elsif a='0' and b='0' and c='0' and d='0' and e='0'
then u<='1';
  v<='1';
  w<='1';
  x<='1';
  y<='1';
  z<='1'; 
  elsif a='0' and b='0' and c='0' and d='0' and e='1' 
then u<='1';
  v<='1';
  w<='1';
  x<='1';
  y<='1';
  z<='1';
  elsif a='0' and b='0' and c='1' and d='0' and e='0' 
then u<='1';
  v<='1';
  w<='0';
  x<='0';
  y<='1';
  z<='1';
  elsif a='0' and b='0' and c='1' and d='0' and e='1' 
then u<='0';
  v<='1';
  w<='1';
  x<='1';
  y<='1';
  z<='0';
  elsif a='0' and b='1' and c='0' and d='0' and e='0'
then u<='1';
  v<='0';
  w<='1';
  x<='1';
  y<='1';
  z<='0';

elsif a='0' and b='1' and c='0' and d='0' and e='1'
then u<='1';
  v<='1';
  w<='0';
  x<='1';
  y<='0';
  z<='1';


elsif a='0' and b='1' and c='1' and d='0' and e='0' 
then u<='1';
  v<='0';
  w<='1';
  x<='0';
  y<='1';
  z<='1';
elsif a='0' and b='1' and c='1' and d='0' and e='1' 
then u<='0';
  v<='1';
  w<='1';
  x<='1';
  y<='0';
  z<='1';
  elsif a='1' and b='0' and c='0' and d='0' and e='0' 
then u<='0';
  v<='1';
  w<='1';
  x<='1';
  y<='0';
  z<='1';
  
elsif a='1' and b='0' and c='0' and d='0' and e='1' 
then u<='1';
  v<='0';
  w<='1';
  x<='0';
  y<='1';
  z<='1';
elsif a='1' and b='0' and c='1' and d='0' and e='0' 
then u<='1';
  v<='1';
  w<='0';
  x<='1';
  y<='0';
  z<='1';
  
elsif a='1' and b='0' and c='1' and d='0' and e='1' 
then u<='1';
  v<='0';
  w<='1';
  x<='1';
  y<='1';
  z<='0';
elsif a='1' and b='1' and c='0' and d='0' and e='0' 
then u<='0';
  v<='1';
  w<='1';
  x<='1';
  y<='1';
  z<='0';
  
  elsif a='1' and b='1' and c='0' and d='0' and e='1' 
then u<='1';
  v<='1';
  w<='0';
  x<='0';
  y<='1';
  z<='1';
  elsif a='1' and b='1' and c='1' and d='0' and e='0' 
then u<='1';
  v<='1';
  w<='1';
  x<='1';
  y<='1';
  z<='1';
  
  elsif a='1' and b='1' and c='1' and d='0' and e='1' 
then u<='1';
  v<='1';
  w<='1';
  x<='1';
  y<='1';
  z<='1';
end if; 
end process; 


end Behavioral;