import sys

_, outfile, infile = sys.argv
with open(infile, "rb") as i:
    ct = i.read(1)[0] + 1
    items = i.read(ct * 2)
    with open(outfile, "wb") as o:
        d = i.read(1)
        while d:
            idx = d[0]
            off = idx * 2
            o.write(items[off:off+2])
            d = i.read(1)