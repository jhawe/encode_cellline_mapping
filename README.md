## Simple script to obtain a ENCODE cell-line mapping
Generate a mapping of cell-lines used in ENCODE to their respective tissue and organism of origin.

### Get ENCODE controlled vocabulary file
```{bash}
wget -O controlled_vocab.txt http://hgdownload.soe.ucsc.edu/goldenPath/encodeDCC/cv.ra
```

### Parse the file and extract cellline to tissue mapping, separate file for available human cell lines
```{bash}
python extract_cellline_mapping.py > cell_line_info.tsv
grep human cell_line_info.tsv > cell_line_info_human.tsv
```
