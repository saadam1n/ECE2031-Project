-- IO DECODER for SCOMP
-- This eliminates the need for a lot of AND decoders or Comparators 
--    that would otherwise be spread around the top-level BDF

LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY IO_DECODER IS

  PORT
  (
    IO_ADDR       : IN STD_LOGIC_VECTOR(10 downto 0);
    IO_CYCLE      : IN STD_LOGIC;
    SWITCH_EN     : OUT STD_LOGIC;
    TIMER_EN      : OUT STD_LOGIC;
    HEX0_EN       : OUT STD_LOGIC;
    HEX1_EN       : OUT STD_LOGIC;
	 -- From the programmer's and IO decoder's perspective, all LEDs are different devices
	 -- However, SCOMP writes to the same peripherial, which then uses the CS signal to determine 
	 -- 	which LED the programmer is trying to write to.
	 LED_EN			: OUT STD_LOGIC_VECTOR(0 to 9)
  );

END ENTITY;

ARCHITECTURE a OF IO_DECODER IS

  SIGNAL  ADDR_INT  : INTEGER RANGE 0 TO 2047;
  
begin

  ADDR_INT <= TO_INTEGER(UNSIGNED(IO_ADDR));
        
  SWITCH_EN    <= '1' WHEN (ADDR_INT = 16#000#) and (IO_CYCLE = '1') ELSE '0';
  TIMER_EN     <= '1' WHEN (ADDR_INT = 16#002#) and (IO_CYCLE = '1') ELSE '0';
  HEX0_EN      <= '1' WHEN (ADDR_INT = 16#004#) and (IO_CYCLE = '1') ELSE '0';
  HEX1_EN      <= '1' WHEN (ADDR_INT = 16#005#) and (IO_CYCLE = '1') ELSE '0';

  
  -- We utilize a process block to select a LED
  process(ADDR_INT, IO_CYCLE)
  begin
    for i in 0 to 9 loop
      LED_EN(i) <= '0';
    end loop;
    
    if (ADDR_INT >= 16#20# and ADDR_INT <= 16#29#) then
      LED_EN(ADDR_INT - 16#20#) <= IO_CYCLE;
    end if;
  end process;
		
END a;
