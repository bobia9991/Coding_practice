#!/usr/bin/env python
from csv import DictReader, DictWriter
with open("Lab_primers.tsv") as f_in:
    reader = DictReader(f_in, delimiter="\t")
    rows = list(reader)
compare = lambda txt1, txt2: sum(a != b for a, b in zip(txt1, txt2))
with open("primer_collision_py.txt", "wt") as f_out:
    writer = DictWriter(f_out, fieldnames=reader.fieldnames, delimiter="\t", lineterminator="\n")
    for line1 in range(len(rows)):
        for line2 in range(line1+1, len(rows)):
            i7_diff = compare(rows[line1]["index"], rows[line2]["index"])
            i5_diff = compare(rows[line1]["index2"], rows[line2]["index2"])
            if i7_diff < 3 and i5_diff < 3:
                writer.writerow(rows[line1])
                writer.writerow(rows[line2])