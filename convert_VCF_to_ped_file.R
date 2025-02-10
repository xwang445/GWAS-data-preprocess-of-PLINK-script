# Function to Convert GT to Genotypic Format
convert_genotype <- function(gt, ref, alt) {
  gsub("0", ref, gsub("1", alt, gsub("\\|", "/", gt)))
}

# Apply Conversion to All Genotype Columns
genotype_cols <- grep("^V[0-9]+$", colnames(snp_vcf), value = TRUE)  # Select genotype columns after 9th column

for (col in genotype_cols) {
  snp_vcf[[col]] <- mapply(convert_genotype, snp_vcf[[col]], snp_vcf$V4, snp_vcf$V5)
}

write.table(snp_vcf, "converted_genotypes.tsv", sep="\t", row.names=FALSE, quote=FALSE)

transposed_snp_df <- read.delim("df_snp_transposed.tsv", sep = "\t", header = F)
dim(transposed_snp_df)
ped_file_first_6col <- data.frame(FID = 0,
                                  IID = sampleids,
                                  PaternalID = 0,
                                  MaternalID = 0,
                                  Sex = "unknown",
                                  Phenotype = "na")
new_ped_df <- cbind(ped_file_first_6col, transposed_snp_df)
new_ped_df_clean <- as.data.frame(lapply(new_ped_df, function(x) gsub("/", "", x)))
write.table(new_ped_df_clean, file = "new_ped_file.txt", quote = FALSE, sep = "\t", row.names = FALSE, col.names = FALSE)
