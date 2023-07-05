import sys

_, infile, outfile = sys.argv
cols = []
with open(infile, "rb") as i:
    d = i.read(3)
    while d:
        r, g, b = d
        r, g, b = r >> 3, g >> 3, b >> 3
        n = (b << 10) | (g << 5) | r
        l = n & 255
        h = n >> 8
        cols.append((l, h))
        d = i.read(3)
#last = cols.pop()
#while cols[-1] == last:
#    cols.pop()
ll, lh = cols.pop()
lh |= 0x80 # set negative flag on high byte, which ends table
cols.append((ll, lh))
with open(outfile, "wb") as o:
    for col in cols:
        o.write(bytes(col))
