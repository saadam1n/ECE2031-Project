import math

with open("lut-vhd.txt", "w") as f:
    f.write("CASE IO_DATA(6 downto 0) IS\n")

    for i in range(101):
        linear = bin(i)[2:].zfill(7)

        gamma = int(100 * math.pow(i / 100, 1.0 / 2.2))
        gamma = bin(gamma)[2:].zfill(7)


        f.write(f"\tWHEN \"{linear}\" => DUTY_CYCLE(i) <= \"{gamma}\";\n")

    f.write("\tWHEN OTHERS => DUTY_CYCLE(i) <= \"1111111\";\n")
    f.write("END CASE;\n")