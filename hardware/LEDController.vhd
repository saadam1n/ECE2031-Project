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
    IO_DATA     : INOUT    STD_LOGIC_VECTOR(15 DOWNTO 0);

	DBG_DUTY_CYCLE : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
    DBG_TIMER : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
);
END LEDController;

ARCHITECTURE a OF LEDController IS

    type DUTY_CYCLE_ARRAY is array (9 DOWNTO 0) of std_logic_vector(6 DOWNTO 0);
	 type BRIGHTNESS_ARRAY is array (9 DOWNTO 0) of STD_LOGIC_VECTOR(6 DOWNTO 0);

    SIGNAL TIMER        : STD_LOGIC_VECTOR(6 DOWNTO 0);
    SIGNAL DUTY_CYCLE   : DUTY_CYCLE_ARRAY;
	 SIGNAL BRIGHTNESS	: BRIGHTNESS_ARRAY;
	 SIGNAL CS				: STD_LOGIC;
	 SIGNAL SEL	: INTEGER RANGE 0 TO 9 := 0;

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
					 BRIGHTNESS(i) <= "0000000";
            ELSIF(RISING_EDGE(EN_signals(i)) AND WRITE_EN = '1') THEN
					CASE IO_DATA(6 downto 0) IS
						WHEN "0000000" => DUTY_CYCLE(i) <= "0000000";
						WHEN "0000001" => DUTY_CYCLE(i) <= "0001100";
						WHEN "0000010" => DUTY_CYCLE(i) <= "0010000";
						WHEN "0000011" => DUTY_CYCLE(i) <= "0010100";
						WHEN "0000100" => DUTY_CYCLE(i) <= "0010111";
						WHEN "0000101" => DUTY_CYCLE(i) <= "0011001";
						WHEN "0000110" => DUTY_CYCLE(i) <= "0011011";
						WHEN "0000111" => DUTY_CYCLE(i) <= "0011101";
						WHEN "0001000" => DUTY_CYCLE(i) <= "0011111";
						WHEN "0001001" => DUTY_CYCLE(i) <= "0100001";
						WHEN "0001010" => DUTY_CYCLE(i) <= "0100011";
						WHEN "0001011" => DUTY_CYCLE(i) <= "0100100";
						WHEN "0001100" => DUTY_CYCLE(i) <= "0100110";
						WHEN "0001101" => DUTY_CYCLE(i) <= "0100111";
						WHEN "0001110" => DUTY_CYCLE(i) <= "0101000";
						WHEN "0001111" => DUTY_CYCLE(i) <= "0101010";
						WHEN "0010000" => DUTY_CYCLE(i) <= "0101011";
						WHEN "0010001" => DUTY_CYCLE(i) <= "0101100";
						WHEN "0010010" => DUTY_CYCLE(i) <= "0101101";
						WHEN "0010011" => DUTY_CYCLE(i) <= "0101111";
						WHEN "0010100" => DUTY_CYCLE(i) <= "0110000";
						WHEN "0010101" => DUTY_CYCLE(i) <= "0110001";
						WHEN "0010110" => DUTY_CYCLE(i) <= "0110010";
						WHEN "0010111" => DUTY_CYCLE(i) <= "0110011";
						WHEN "0011000" => DUTY_CYCLE(i) <= "0110100";
						WHEN "0011001" => DUTY_CYCLE(i) <= "0110101";
						WHEN "0011010" => DUTY_CYCLE(i) <= "0110110";
						WHEN "0011011" => DUTY_CYCLE(i) <= "0110111";
						WHEN "0011100" => DUTY_CYCLE(i) <= "0111000";
						WHEN "0011101" => DUTY_CYCLE(i) <= "0111000";
						WHEN "0011110" => DUTY_CYCLE(i) <= "0111001";
						WHEN "0011111" => DUTY_CYCLE(i) <= "0111010";
						WHEN "0100000" => DUTY_CYCLE(i) <= "0111011";
						WHEN "0100001" => DUTY_CYCLE(i) <= "0111100";
						WHEN "0100010" => DUTY_CYCLE(i) <= "0111101";
						WHEN "0100011" => DUTY_CYCLE(i) <= "0111110";
						WHEN "0100100" => DUTY_CYCLE(i) <= "0111110";
						WHEN "0100101" => DUTY_CYCLE(i) <= "0111111";
						WHEN "0100110" => DUTY_CYCLE(i) <= "1000000";
						WHEN "0100111" => DUTY_CYCLE(i) <= "1000001";
						WHEN "0101000" => DUTY_CYCLE(i) <= "1000001";
						WHEN "0101001" => DUTY_CYCLE(i) <= "1000010";
						WHEN "0101010" => DUTY_CYCLE(i) <= "1000011";
						WHEN "0101011" => DUTY_CYCLE(i) <= "1000100";
						WHEN "0101100" => DUTY_CYCLE(i) <= "1000100";
						WHEN "0101101" => DUTY_CYCLE(i) <= "1000101";
						WHEN "0101110" => DUTY_CYCLE(i) <= "1000110";
						WHEN "0101111" => DUTY_CYCLE(i) <= "1000110";
						WHEN "0110000" => DUTY_CYCLE(i) <= "1000111";
						WHEN "0110001" => DUTY_CYCLE(i) <= "1001000";
						WHEN "0110010" => DUTY_CYCLE(i) <= "1001000";
						WHEN "0110011" => DUTY_CYCLE(i) <= "1001001";
						WHEN "0110100" => DUTY_CYCLE(i) <= "1001010";
						WHEN "0110101" => DUTY_CYCLE(i) <= "1001010";
						WHEN "0110110" => DUTY_CYCLE(i) <= "1001011";
						WHEN "0110111" => DUTY_CYCLE(i) <= "1001100";
						WHEN "0111000" => DUTY_CYCLE(i) <= "1001100";
						WHEN "0111001" => DUTY_CYCLE(i) <= "1001101";
						WHEN "0111010" => DUTY_CYCLE(i) <= "1001110";
						WHEN "0111011" => DUTY_CYCLE(i) <= "1001110";
						WHEN "0111100" => DUTY_CYCLE(i) <= "1001111";
						WHEN "0111101" => DUTY_CYCLE(i) <= "1001111";
						WHEN "0111110" => DUTY_CYCLE(i) <= "1010000";
						WHEN "0111111" => DUTY_CYCLE(i) <= "1010001";
						WHEN "1000000" => DUTY_CYCLE(i) <= "1010001";
						WHEN "1000001" => DUTY_CYCLE(i) <= "1010010";
						WHEN "1000010" => DUTY_CYCLE(i) <= "1010010";
						WHEN "1000011" => DUTY_CYCLE(i) <= "1010011";
						WHEN "1000100" => DUTY_CYCLE(i) <= "1010011";
						WHEN "1000101" => DUTY_CYCLE(i) <= "1010100";
						WHEN "1000110" => DUTY_CYCLE(i) <= "1010101";
						WHEN "1000111" => DUTY_CYCLE(i) <= "1010101";
						WHEN "1001000" => DUTY_CYCLE(i) <= "1010110";
						WHEN "1001001" => DUTY_CYCLE(i) <= "1010110";
						WHEN "1001010" => DUTY_CYCLE(i) <= "1010111";
						WHEN "1001011" => DUTY_CYCLE(i) <= "1010111";
						WHEN "1001100" => DUTY_CYCLE(i) <= "1011000";
						WHEN "1001101" => DUTY_CYCLE(i) <= "1011000";
						WHEN "1001110" => DUTY_CYCLE(i) <= "1011001";
						WHEN "1001111" => DUTY_CYCLE(i) <= "1011001";
						WHEN "1010000" => DUTY_CYCLE(i) <= "1011010";
						WHEN "1010001" => DUTY_CYCLE(i) <= "1011010";
						WHEN "1010010" => DUTY_CYCLE(i) <= "1011011";
						WHEN "1010011" => DUTY_CYCLE(i) <= "1011011";
						WHEN "1010100" => DUTY_CYCLE(i) <= "1011100";
						WHEN "1010101" => DUTY_CYCLE(i) <= "1011100";
						WHEN "1010110" => DUTY_CYCLE(i) <= "1011101";
						WHEN "1010111" => DUTY_CYCLE(i) <= "1011101";
						WHEN "1011000" => DUTY_CYCLE(i) <= "1011110";
						WHEN "1011001" => DUTY_CYCLE(i) <= "1011110";
						WHEN "1011010" => DUTY_CYCLE(i) <= "1011111";
						WHEN "1011011" => DUTY_CYCLE(i) <= "1011111";
						WHEN "1011100" => DUTY_CYCLE(i) <= "1100000";
						WHEN "1011101" => DUTY_CYCLE(i) <= "1100000";
						WHEN "1011110" => DUTY_CYCLE(i) <= "1100001";
						WHEN "1011111" => DUTY_CYCLE(i) <= "1100001";
						WHEN "1100000" => DUTY_CYCLE(i) <= "1100010";
						WHEN "1100001" => DUTY_CYCLE(i) <= "1100010";
						WHEN "1100010" => DUTY_CYCLE(i) <= "1100011";
						WHEN "1100011" => DUTY_CYCLE(i) <= "1100011";
						WHEN "1100100" => DUTY_CYCLE(i) <= "1100100";
						WHEN OTHERS => DUTY_CYCLE(i) <= "1111111";
					END CASE;
					BRIGHTNESS(i) <= IO_DATA(6 DOWNTO 0);

            END IF;

        END PROCESS;

        -- Update value of LED based on its relation to the timer
        LEDs(i) <= '1' when TIMER < DUTY_CYCLE(i) else '0';

    END GENERATE;
	 
	 
	 PROCESS (EN_signals) BEGIN
	 CASE EN_signals(9 DOWNTO 0) IS
		WHEN "0000000001" => SEL <= 0;
		WHEN "0000000010" => SEL <= 1;
		WHEN "0000000100" => SEL <= 2;
		WHEN "0000001000" => SEL <= 3;
		WHEN "0000010000" => SEL <= 4;
		WHEN "0000100000" => SEL <= 5;
		WHEN "0001000000" => SEL <= 6;
		WHEN "0010000000" => SEL <= 7;
		WHEN "0100000000" => SEL <= 8;
		WHEN "1000000000" => SEL <= 9;
		WHEN OTHERS => SEL <= 0;
	 END CASE;
	 CASE EN_signals(9 DOWNTO 0) IS
		WHEN "0000000000" => CS <= '0';
		WHEN OTHERS => CS <= '1';
	 END CASE;
	 END PROCESS;
	 
    DBG_DUTY_CYCLE <= DUTY_CYCLE(1);
    DBG_TIMER <= TIMER;
	 
	 -- Use LPM function to create bidirectional I/O data bus
    IO_BUS: lpm_bustri
    GENERIC MAP (
      lpm_width => 16
    )
    PORT MAP (
      data     => ("000000000" & BRIGHTNESS(SEL)),
      enabledt => (CS AND NOT(WRITE_EN)),
      tridata  => IO_DATA
    );


END a;

