import pandas as pd

# Define file paths
input_file = "vcf_wo_header.tsv"  # Large SNP file
rice_file = "rice_geno.txt"  # Rice genotype metadata
output_file = "new_ped_file.tsv"  # Final output file

# Step 1: Load the large SNP matrix and remove the first 9 columns
print("Loading SNP data and removing first 9 columns...")
df_snp = pd.read_csv(input_file, sep="\t", header=None, usecols=range(9, 1504))  # Load only needed columns

# Step 2: Transpose the matrix efficiently
print("Transposing SNP matrix...")
df_snp_transposed = df_snp.T  # Transpose

df_snp_transposed.to_csv("df_snp_transposed.tsv", sep="\t", index=False, header=False)

# Step 3: Load the first 6 columns from rice_geno.txt
print("Loading rice genotype metadata...")
df_rice = pd.read_csv(rice_file, sep=" ", header=None, usecols=range(6))  # Load only first 6 columns

# Step 4: Combine rice metadata with transposed SNP data
print("Combining rice metadata with SNP genotypes...")
df_final = pd.concat([df_rice, df_snp_transposed], axis=1)

# Step 5: Save the final output file
print(f"Saving final output to {output_file}...")
df_final.to_csv(output_file, sep="\t", index=False, header=False)

print("Processing completed successfully! 🚀")
