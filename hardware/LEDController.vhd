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
    CLK			: IN    STD_LOGIC;
    EN_signals  : IN    STD_LOGIC_VECTOR(9 DOWNTO 0);
    WRITE_EN    : IN    STD_LOGIC;
    RESETN      : IN    STD_LOGIC;
    LEDs        : OUT   STD_LOGIC_VECTOR(9 DOWNTO 0);
    IO_DATA     : IN    STD_LOGIC_VECTOR(15 DOWNTO 0);

	DBG_DUTY_CYCLE : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
    DBG_TIMER : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
);
END LEDController;

ARCHITECTURE a OF LEDController IS

    type DUTY_CYCLE_ARRAY is array (9 DOWNTO 0) of std_logic_vector(6 DOWNTO 0);

    SIGNAL TIMER        : STD_LOGIC_VECTOR(6 DOWNTO 0);
    SIGNAL DUTY_CYCLE   : DUTY_CYCLE_ARRAY;

BEGIN
	-- Update our timer 
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

    -- Update duty cycle when EN_signal is updated.
    -- Also update the LED signal
    LEDUpdate: FOR i IN 9 DOWNTO 0 GENERATE
        -- Update LEDs if EN_signal(i) is enabled
        PROCESS(RESETN, EN_signals(i))
        BEGIN

            IF(RESETN = '0') THEN
                DUTY_CYCLE(i) <= "0000000";
            ELSIF(RISING_EDGE(EN_signals(i)) AND WRITE_EN = '1') THEN
                DUTY_CYCLE(i) <= IO_DATA(6 downto 0);
            END IF;

        END PROCESS;

        -- Update value of LED based on its relation to the timer
        LEDs(i) <= '1' when TIMER < DUTY_CYCLE(i) else '0';

    END GENERATE;

    DBG_DUTY_CYCLE <= DUTY_CYCLE(1);
    DBG_TIMER <= TIMER;

END a;