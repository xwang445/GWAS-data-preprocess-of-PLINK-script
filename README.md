# GWAS-data-preprocess-of-PLINK-script
edit VCF file or non-regular input for plink or GEMMA
-gk 1	Centered GRM	Computes the centered genetic relatedness matrix (default for LMM).
-gk 2	Standardized GRM	Computes the standardized genetic relatedness matrix (used for PCA & mixed models).

plink --file rice --make-bed --out rice
python code to combine: The first 5 columns from rice.fam and The 2nd to last columns from pheno.txt, Merges them side by side into a new .fam file. 
and rename it to rice.fam to replace the old one
gemma -bfile rice -gk 1 -o kin
mv ./output/kin.sXX.txt .
gemma -bfile rice -k kin.cXX.txt -lmm 1 -n 1 2 3 4 5 6 7 8 9 10 -o mlmm_GWAS
