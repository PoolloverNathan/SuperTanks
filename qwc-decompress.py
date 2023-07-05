import sys

_, outfile, infile = sys.argv
with open(infile, "rb") as f:
    with open(outfile, "wb") as o:
        d = f.read(3)
        while d:
            ct, b1, b2 = d
            b = bytes((b1, b2))
            o.write(b * (ct + 1))
            d = f.read(3)