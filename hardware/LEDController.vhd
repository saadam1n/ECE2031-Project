-- LEDController.VHD
-- 2025.03.09
--
-- This SCOMP peripheral drives ten outputs high or low based on
-- a value from SCOMP.

LIBRARY IEEE;
LIBRARY LPM;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE LPM.LPM_COMPONENTS.ALL;

ENTITY LEDController IS
PORT(
	 CLOCK,
    WRITE_EN    : IN  STD_LOGIC;
    RESETN      : IN  STD_LOGIC;
    LEDs        : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
    IO_DATA     : IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
	 LED0_EN		 : IN STD_LOGIC;
	 LED1_EN		 : IN STD_LOGIC;
	 LED2_EN		 : IN STD_LOGIC;
	 LED3_EN		 : IN STD_LOGIC;
	 LED4_EN		 : IN STD_LOGIC;
	 LED5_EN		 : IN STD_LOGIC;
	 LED6_EN		 : IN STD_LOGIC;
	 LED7_EN		 : IN STD_LOGIC;
	 LED8_EN		 : IN STD_LOGIC;
	 LED9_EN		 : IN STD_LOGIC
    );
END LEDController;

ARCHITECTURE a OF LEDController IS
BEGIN
    PROCESS (RESETN, LED0_EN, LED1_EN, LED2_EN, LED3_EN, LED4_EN, LED5_EN, LED6_EN, LED7_EN, LED8_EN, LED9_EN) -- may need to add clock in here eventually
    BEGIN
        IF (RESETN = '0') THEN
            -- Turn off LEDs at reset (a nice usability feature)
            LEDs <= "0000000000";
        ELSIF (RISING_EDGE(LED0_EN)) THEN
            IF WRITE_EN = '1' THEN
                -- If SCOMP is sending data to this peripheral, with this LED code,
                -- we want to update the brightness. Implement the lookup logic here
					 -- (update something that will allow a clock to implement a new duty cycle)
					 LEDs <= "1000000000"; -- PLACEHOLDER SO IT COMPILES
				--ELSE
					--IO_DATA <= THE CURRENT BRIGHTNESS SETTING
            END IF;
		  ELSIF (RISING_EDGE(LED1_EN)) THEN
				IF WRITE_EN = '1' THEN
					 -- If SCOMP is sending data to this peripheral, with this LED code,
                -- we want to update the brightness. Implement the lookup logic here
					 -- (update something that will allow a clock to implement a new duty cycle)
					 LEDs <= "0100000000"; -- PLACEHOLDER SO IT COMPILES
				--ELSE
					--IO_DATA <= THE CURRENT BRIGHTNESS SETTING
				END IF;
		  ELSIF (RISING_EDGE(LED2_EN)) THEN
				IF WRITE_EN = '1' THEN
					 -- If SCOMP is sending data to this peripheral, with this LED code,
                -- we want to update the brightness. Implement the lookup logic here
					 -- (update something that will allow a clock to implement a new duty cycle)
					 LEDs <= "0010000000"; -- PLACEHOLDER SO IT COMPILES
				--ELSE
					--IO_DATA <= THE CURRENT BRIGHTNESS SETTING
				END IF;
		  ELSIF (RISING_EDGE(LED3_EN)) THEN
				IF WRITE_EN = '1' THEN
					 -- If SCOMP is sending data to this peripheral, with this LED code,
                -- we want to update the brightness. Implement the lookup logic here
					 -- (update something that will allow a clock to implement a new duty cycle)
					 LEDs <= "0001000000"; -- PLACEHOLDER SO IT COMPILES
				--ELSE
					--IO_DATA <= THE CURRENT BRIGHTNESS SETTING
				END IF;
		  ELSIF (RISING_EDGE(LED4_EN)) THEN
				IF WRITE_EN = '1' THEN
					 -- If SCOMP is sending data to this peripheral, with this LED code,
                -- we want to update the brightness. Implement the lookup logic here
					 -- (update something that will allow a clock to implement a new duty cycle)
					 LEDs <= "0000100000"; -- PLACEHOLDER SO IT COMPILES
				--ELSE
					--IO_DATA <= THE CURRENT BRIGHTNESS SETTING
				END IF;
		  ELSIF (RISING_EDGE(LED5_EN)) THEN
				IF WRITE_EN = '1' THEN
					 -- If SCOMP is sending data to this peripheral, with this LED code,
                -- we want to update the brightness. Implement the lookup logic here
					 -- (update something that will allow a clock to implement a new duty cycle)
					 LEDs <= "0000010000"; -- PLACEHOLDER SO IT COMPILES
				--ELSE
					--IO_DATA <= THE CURRENT BRIGHTNESS SETTING
				END IF;
		  ELSIF (RISING_EDGE(LED6_EN)) THEN
				IF WRITE_EN = '1' THEN
					 -- If SCOMP is sending data to this peripheral, with this LED code,
                -- we want to update the brightness. Implement the lookup logic here
					 -- (update something that will allow a clock to implement a new duty cycle)
					 LEDs <= "0000001000"; -- PLACEHOLDER SO IT COMPILES
				--ELSE
					--IO_DATA <= THE CURRENT BRIGHTNESS SETTING
				END IF;
		  ELSIF (RISING_EDGE(LED7_EN)) THEN
				IF WRITE_EN = '1' THEN
					 -- If SCOMP is sending data to this peripheral, with this LED code,
                -- we want to update the brightness. Implement the lookup logic here
					 -- (update something that will allow a clock to implement a new duty cycle)
					 LEDs <= "0000000100"; -- PLACEHOLDER SO IT COMPILES
				--ELSE
					--IO_DATA <= THE CURRENT BRIGHTNESS SETTING
				END IF;
		  ELSIF (RISING_EDGE(LED8_EN)) THEN
				IF WRITE_EN = '1' THEN
					 -- If SCOMP is sending data to this peripheral, with this LED code,
                -- we want to update the brightness. Implement the lookup logic here
					 -- (update something that will allow a clock to implement a new duty cycle)
					 LEDs <= "0000000010"; -- PLACEHOLDER SO IT COMPILES
				--ELSE
					--IO_DATA <= THE CURRENT BRIGHTNESS SETTING
				END IF;
		  ELSIF (RISING_EDGE(LED9_EN)) THEN
				IF WRITE_EN = '1' THEN
					 -- If SCOMP is sending data to this peripheral, with this LED code,
                -- we want to update the brightness. Implement the lookup logic here
					 -- (update something that will allow a clock to implement a new duty cycle)
					 LEDs <= "0000000001"; -- PLACEHOLDER SO IT COMPILES
				--ELSE
					--IO_DATA <= THE CURRENT BRIGHTNESS SETTING
				END IF;
        END IF;
		  
		  -- here, we need to use the clock to push a value to the LEDs every clock cycle
		  -- this value will depend on every single LED's current brightness setting
    END PROCESS;
END a;