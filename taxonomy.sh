#!/bin/bash

cd ..

module load unsupported
module load donata/miniconda/3/3
source activate qiime2-2017.8

set -u

wget -O "gg-13-8-99-515-806-nb-classifier.qza" "https://data.qiime2.org/2017.8/common/gg-13-8-99-515-806-nb-classifier.qza"

qiime feature-classifier classify-sklearn \
  --i-classifier gg-13-8-99-515-806-nb-classifier.qza \
  --i-reads rep-seqs.qza \
  --o-classification taxonomy.qza

qiime metadata tabulate \
  --m-input-file taxonomy.qza \
  --o-visualization taxonomy.qzv

qiime taxa barplot \
  --i-table table.qza \
  --i-taxonomy taxonomy.qza \
  --m-metadata-file sample-metadata.txt \
  --o-visualization taxa-bar-plots.qzv

qiime taxa collapse \
  --i-table table.qza \
  --i-taxonomy taxonomy.qza \
  --p-level 6 \
  --o-collapsed-table table-l6.qza

qiime taxa collapse \
  --i-table table.qza \
  --i-taxonomy taxonomy.qza \
  --p-level 5 \
  --o-collapsed-table table-l5.qza

qiime taxa collapse \
  --i-table table.qza \
  --i-taxonomy taxonomy.qza \
  --p-level 4 \
  --o-collapsed-table table-l4.qza

qiime taxa collapse \
  --i-table table.qza \
  --i-taxonomy taxonomy.qza \
  --p-level 3 \
  --o-collapsed-table table-l3.qza

qiime taxa collapse \
  --i-table table.qza \
  --i-taxonomy taxonomy.qza \
  --p-level 2 \
  --o-collapsed-table table-l2.qza

qiime tools export \
	table-l6.qza \
	--output-dir exported-table-l6

qiime tools export \
        table-l5.qza \
        --output-dir exported-table-l5

qiime tools export \
        table-l4.qza \
        --output-dir exported-table-l4

qiime tools export \
        table-l3.qza \
        --output-dir exported-table-l3

qiime tools export \
        table-l2.qza \
        --output-dir exported-table-l2

biom convert -i exported-table-l6/feature-table.biom -o exported-table-l6/feature-table.txt --table-type="OTU table" --to-tsv
biom convert -i exported-table-l5/feature-table.biom -o exported-table-l5/feature-table.txt --table-type="OTU table" --to-tsv
biom convert -i exported-table-l4/feature-table.biom -o exported-table-l4/feature-table.txt --table-type="OTU table" --to-tsv
biom convert -i exported-table-l3/feature-table.biom -o exported-table-l3/feature-table.txt --table-type="OTU table" --to-tsv
biom convert -i exported-table-l2/feature-table.biom -o exported-table-l2/feature-table.txt --table-type="OTU table" --to-tsv

mkdir taxonomy
mv tax*.qz* taxonomy/
mv table-* taxonomy/
mv exported* taxonomy/
mv gg* taxonomy/

echo done

