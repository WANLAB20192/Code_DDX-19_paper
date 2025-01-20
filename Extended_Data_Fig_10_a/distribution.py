import os
from collections import defaultdict, Counter

def read_fasta(file_path):
    print(f"Reading file: {file_path}")
    with open(file_path, 'r') as f:
        sequences = []
        seq = ""
        for line in f:
            if line.startswith(">"):
                if seq:
                    sequences.append(seq)
                    seq = ""
            else:
                seq += line.strip()
        if seq:
            sequences.append(seq)
    print(f"Found {len(sequences)} sequences")
    return sequences

def analyze_sequences(sequences):
    length_distribution = defaultdict(list)
    for seq in sequences:
        length = len(seq)
        first_base = seq[0] if seq else None
        length_distribution[length].append(first_base)
    return length_distribution

def calculate_base_proportions(length_distribution):
    proportions = {}
    for length, bases in length_distribution.items():
        base_count = Counter(bases)
        total = sum(base_count.values())
        proportions[length] = {base: base_count.get(base, 0) / total for base in 'AGCT'}
    return proportions

def save_length_distribution(file_path, length_distribution):
    output_file = file_path.replace('.fasta', '_length_distribution.txt')
    with open(output_file, 'w') as f:
        for length, bases in length_distribution.items():
            f.write(f"{length}\t{len(bases)}\n")
    print(f"Saved length distribution to {output_file}")

def save_base_proportions(file_path, base_proportions):
    output_file = file_path.replace('.fasta', '_base_proportions.txt')
    with open(output_file, 'w') as f:
        f.write("Length\tA\tG\tC\tT\n")
        for length, proportions in base_proportions.items():
            f.write(f"{length}\t{proportions.get('A', 0):.4f}\t{proportions.get('G', 0):.4f}\t{proportions.get('C', 0):.4f}\t{proportions.get('T', 0):.4f}\n")
    print(f"Saved base proportions to {output_file}")

def main():
    directory = '/public/home/lxr/app-1_small_RNA/distribution/cutadapt'  #
    print(f"Scanning directory: {directory}")
    fasta_files = [f for f in os.listdir(directory) if f.endswith('.fasta')]

    if not fasta_files:
        print("No FASTA files found.")
        return

    for fasta_file in fasta_files:
        file_path = os.path.join(directory, fasta_file)
        sequences = read_fasta(file_path)
        if not sequences:
            print(f"No sequences found in {fasta_file}")
            continue
        length_distribution = analyze_sequences(sequences)
        base_proportions = calculate_base_proportions(length_distribution)
        
        save_length_distribution(file_path, length_distribution)
        save_base_proportions(file_path, base_proportions)
        
        print(f"Processed: {fasta_file}")

if __name__ == "__main__":
    main()
