import sys

_, name = sys.argv
with open(name, "rb") as f:
    global data
    data = bytearray(f.read())
for i in range(len(data)):
    data[i] = (data[i] >> 3) << 3
with open(name, "wb") as f:
    f.write(data)