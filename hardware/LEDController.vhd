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
use IEEE.STD_LOGIC_MISC.all;
USE LPM.LPM_COMPONENTS.ALL;

ENTITY LEDController IS
PORT(
    CLK			: IN  STD_LOGIC;
    CS          : IN  STD_LOGIC;
    WRITE_EN    : IN  STD_LOGIC;
    RESETN      : IN  STD_LOGIC;
    LEDs        : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
    IO_DATA     : IN  STD_LOGIC_VECTOR(15 DOWNTO 0);

    DBG_TIMER_OUT   : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	DBG_DUTY_CYCLE_OUT : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
    );
END LEDController;

ARCHITECTURE a OF LEDController IS
    SIGNAL TIMER        : STD_LOGIC_VECTOR(6 DOWNTO 0);
    SIGNAL DUTY_CYCLE   : STD_LOGIC_VECTOR(6 DOWNTO 0);
BEGIN
	-- This process block updates the brightnesses for LEDs
    PROCESS (RESETN, CS)
    BEGIN
        IF (RESETN = '0') THEN
            -- Set all LEDs to a duty cycle of 0
            DUTY_CYCLE <= "0000000";
				
        ELSIF (RISING_EDGE(CS)) THEN
            -- Update the selected LED's duty cycle
            IF(WRITE_EN = '1') THEN
                DUTY_CYCLE <= IO_DATA(6 downto 0);
            END IF;

        END IF;

    END PROCESS;

    PROCESS(RESETN, CLK)
    BEGIN

        IF(RESETN = '0') THEN
            -- Set timer to zero
            TIMER <= "0000000";
        ELSIF(RISING_EDGE(CLK)) THEN

            -- Increment timer. If it equals 100 reset it back to zero
            TIMER <= TIMER + "0000001";
            IF(TIMER = "1100100") THEN
                TIMER <= "0000000";
            END IF;

        END IF;

    END PROCESS;
    -- Update all LEDs
    LEDs <= "1111111111" when TIMER < DUTY_CYCLE else "0000000000";

    DBG_TIMER_OUT <= TIMER;
	DBG_DUTY_CYCLE_OUT <= DUTY_CYCLE;
END a;