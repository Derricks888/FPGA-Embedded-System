library ieee;
USE ieee.std_logic_1164.all; 
USE ieee.numeric_std.all;


ENTITY RAM128_32 IS 
PORT ( address : IN STD_LOGIC_VECTOR (6 DOWNTO 0); 
       clock : IN STD_LOGIC := '1'; data : IN STD_LOGIC_VECTOR (31 DOWNTO 0); 
       wren : IN STD_LOGIC; 
       q : OUT STD_LOGIC_VECTOR (31 DOWNTO 0) ); 
END RAM128_32;

ARCHITECTURE behavior OF RAM128_32 IS 
  TYPE ram_type IS ARRAY (0 TO 127) OF STD_LOGIC_VECTOR(31 DOWNTO 0); 
  SIGNAL ram : ram_type; 
  SIGNAL addr_reg : NATURAL RANGE 0 TO 127;
 BEGIN
 
 -- Convert address to integer 
 addr_reg <= to_integer(unsigned(address));
 
 -- Write process (synchronous)
 
 PROCESS (clock) 
 BEGIN
   
   IF rising_edge(clock) THEN
    IF wren = '1' THEN
	ram(addr_reg) <= data;
	END IF; 
   END IF;
  END PROCESS;
  
  -- Read process (combinational - unregistered output) 
  q <= ram(addr_reg); 
END behavior;