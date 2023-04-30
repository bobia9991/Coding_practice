import collections

Nucleotides = ["A", "C", "G", "T"]

# Check the sequence to make sure it is a DNA String


def valid_Seq(dna_seq):
    tmpSeq = dna_seq.upper()
    for nuc in tmpSeq:
        if nuc not in Nucleotides:
            return False
    return tmpSeq

# Check the frequency of each nucleotide kinds


def countNucFrequency(seq):
    #tmpFreqDict = {"A": 0, "C": 0, "G": 0, "T": 0}
    # for nuc in seq:
    #    tmpFreqDict[nuc] += 1
    # return tmpFreqDict
    return dict(collections.Counter(seq))
