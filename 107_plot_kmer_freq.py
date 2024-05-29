import os

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
import argparse
from io import BytesIO
import IPython.display as display



parser = argparse.ArgumentParser(description="Plot the kmer frequency from Jellyfish or kmerfreq")
parser.add_argument("--kmerfreq", help="The output file from kmerfreq")
parser.add_argument("--k", help="The value of K", default=17, type=int)
parser.add_argument("--cutoff", help="The cutoff used for cutting the reads", default=10, type=int)
args = parser.parse_args()

if __name__ == '__main__':
    data = open(args.kmerfreq).read().split("\n")
    df = [a for a in data if '#' not in a and len(a) > 0]
    header = data[6][1:].split()
    df = [a.split() for a in df]
    df = pd.DataFrame(df, columns=header)

    df["Kmer_Frequency"] = df["Kmer_Frequency"].astype(int)
    df["Kmer_Species_Number"] = df["Kmer_Species_Number"].astype(int)
    df["Kmer_Individual_Number"] = df["Kmer_Individual_Number"].astype(np.int64)

    # Exclude the non relevant reads
    df_excluded = df[df['Kmer_Frequency'] >= args.cutoff]

    df = df[df['Kmer_Frequency'] <= 200]
    plt.figure(figsize=(12, 6))
    plt.xlabel("Frequency")
    plt.ylabel("Number")
    sns.lineplot(df, x='Kmer_Frequency', y='Kmer_Species_Number')
    plt.axvline(x=args.cutoff, color='red', linewidth=1, linestyle='--')
    plt.ylim(0, 100000000)
    plt.savefig(args.kmerfreq.replace(".stat", ".stat.png"))

    kmer_count = df_excluded['Kmer_Species_Number'].sum()
    report = {
        'Accession number': os.path.basename(args.kmerfreq.replace('.stat', '')),
        'k': args.k,
        'Cut off': f"{args.cutoff}",
        'k-mer count': f"{kmer_count:,} bp",
        'estimated genome size': f"{(kmer_count-1+17):,} bp"
    }

    svg_buffer = BytesIO()
    plt.savefig(svg_buffer, format='svg')
    svg_buffer.seek(0)
    html = (f'<svg width="864pt" height="432pt">{svg_buffer.read().decode()}</svg>')
    html = f"""<!DOCTYPE html><html><head><title></title></head><body style='text-align: center'>
    <h1>{os.path.basename(args.kmerfreq.replace('.stat', ''))}</h1>
    <div style='text-align: center'>
    <table style='display: inline-block'>
        {''.join(['<tr><td><b>' + a + '</b></td><td>' + str(report[a]) + '</td></tr>' for a in report])}
    </table>
    </div>
    {html}
    </body></html>"""
    plt.close()


    with open(args.kmerfreq.replace('.stat', '.stat.html'), 'w') as f:
        f.write(html)
    #plt.show()

    print("Done")
    print()
