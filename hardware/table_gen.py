import math

with open("gamma_table.mif", "w") as f:
    # size of memory block
    f.write("DEPTH = 101;\n")
    # size of each word within block
    f.write("WIDTH = 8;\n")
    # format to describe addresses with
    f.write("ADDRESS_RADIX = BIN;\n")
    # format to describe data with
    f.write("DATA_RADIX = BIN;\n")

    f.write("\n\n")
    f.write("BEGIN;\n")
    f.write("\n\n")

    # we want to format things nicely
    # so we pad zeros to addresses/values
    expected_len = len(bin(100)[2:])

    for i in range(101):
        g = int(100 * math.pow(i / 100, 1.0 / 2.2))

        addr = bin(i)[2:]
        addr = "0" * (expected_len - len(addr)) + addr

        mapping = bin(g)[2:]
        mapping = "0" * (expected_len - len(mapping)) + mapping



        f.write(f"{addr} = {mapping}; -- {i}\t-> {g}\n") 

    f.write("\n\n")
    f.write("END;\n")