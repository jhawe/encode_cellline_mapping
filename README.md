## Simple script to obtain a ENCODE cell-line mapping
Generate a mapping of cell-lines used in ENCODE to their respective tissue and organism of origin.

### GTEx tissues
The list of GTEx tissues was manually obtained from 

https://gtexportal.org/home/tissueSummaryPage

and copied to the file 'gtex_tissues.tsv' which has been added to the repository


### ENCODE controlled vocabulary file
ENCODE controlled vocbulary was downloaded directly from ENCODE goldenPaht.
Some information regarding this file can be found in the ENCODE FAQ under:

https://genome.ucsc.edu/encode/FAQ/index.html#release6

```{bash}
wget -O controlled_vocab.txt http://hgdownload.soe.ucsc.edu/goldenPath/encodeDCC/cv.ra
```

### Parse the file and extract cellline to tissue mapping, separate file for available human cell lines
```{bash}
python scripts/extract_cellline_mapping.py > cell_line_info.tsv
grep human cell_line_info.tsv > cell_line_info_human.tsv
```
