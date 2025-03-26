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
	 LED0_EN			: OUT STD_LOGIC;
	 LED1_EN			: OUT STD_LOGIC;
	 LED2_EN			: OUT STD_LOGIC;
	 LED3_EN			: OUT STD_LOGIC;
	 LED4_EN			: OUT STD_LOGIC;
	 LED5_EN			: OUT STD_LOGIC;
	 LED6_EN			: OUT STD_LOGIC;
	 LED7_EN			: OUT STD_LOGIC;
	 LED8_EN			: OUT STD_LOGIC;
	 LED9_EN			: OUT STD_LOGIC -- best way is 9 separate since only 1 can be on at a time
	 --	additionally, we can only handle one change of brightness at a time
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
  LED0_EN      <= '1' WHEN (ADDR_INT = 16#020#) and (IO_CYCLE = '1') ELSE '0';
  LED1_EN      <= '1' WHEN (ADDR_INT = 16#021#) and (IO_CYCLE = '1') ELSE '0';
  LED2_EN      <= '1' WHEN (ADDR_INT = 16#022#) and (IO_CYCLE = '1') ELSE '0';
  LED3_EN      <= '1' WHEN (ADDR_INT = 16#023#) and (IO_CYCLE = '1') ELSE '0';
  LED4_EN      <= '1' WHEN (ADDR_INT = 16#024#) and (IO_CYCLE = '1') ELSE '0';
  LED5_EN      <= '1' WHEN (ADDR_INT = 16#025#) and (IO_CYCLE = '1') ELSE '0';
  LED6_EN      <= '1' WHEN (ADDR_INT = 16#026#) and (IO_CYCLE = '1') ELSE '0';
  LED7_EN      <= '1' WHEN (ADDR_INT = 16#027#) and (IO_CYCLE = '1') ELSE '0';
  LED8_EN      <= '1' WHEN (ADDR_INT = 16#028#) and (IO_CYCLE = '1') ELSE '0';
  LED9_EN      <= '1' WHEN (ADDR_INT = 16#029#) and (IO_CYCLE = '1') ELSE '0';
      
END a;
