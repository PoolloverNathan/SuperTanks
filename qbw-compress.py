import sys

_, infile, outfile = sys.argv
words = []
wordmap = {}
indices = []
byte = lambda b: bytes((b,))
w2i = lambda w: (w[1] << 8) | w[0]
with open(infile, "rb") as i:
    global data
    data = i.read()
    data = [data[i:i+2] for i in range(0,len(data),2)]
items = set(data)
freqs = {k: 0 for k in items}
for i in data:
    freqs[i] += 1
items = sorted(items, key=freqs.get, reverse=True)
indices = {}
for i in range(len(items)):
    indices[items[i]] = i
with open(outfile, "wb") as o:
    o.write(byte(len(items)))
    o.write(b"".join(items))
    for d in data:
        o.write(byte(indices[d]))