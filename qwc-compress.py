import sys

_, infile, outfile = sys.argv
with open(infile, "rb") as f:
    with open(outfile, "wb") as o:
        rc = 0
        l = f.read(2)
        d = f.read(2)
        while d:
            if d == l:
                # data is the same, so run length increases
                rc += 1
                #print(d, "=", l, "rc", rc)
            else:
                # data is different, so write data and reset run length
                #print(l, "->", d, "write rc", rc, "-", bytes((rc,)) + l)
                o.write(bytes((rc,)))
                o.write(l)
                rc = 0
            l = d
            d = f.read(2)
        #print(l, "finally write rc", rc, "-", bytes((rc,)) + l)
        o.write(bytes((rc,)))
        o.write(l)
        o.flush()