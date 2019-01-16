## Scripts to obtain a ENCODE cell-line mapping
Generate a mapping of cell-lines used in ENCODE to their respective tissue of origin.

### GTEx tissues
The list of GTEx tissues was manually obtained from 

https://gtexportal.org/home/tissueSummaryPage

and copied to the file 'gtex_tissues.tsv' which has been added to the repository


### ENCODE controlled vocabulary file
ENCODE controlled vocbulary was downloaded directly from ENCODE goldenPath.
Some information regarding this file can be found in the ENCODE FAQ under:

https://genome.ucsc.edu/encode/FAQ/index.html#release6

We use the 'term', 'tissue' and 'tag' fields to annotate the cell-lines to GTEx tissues
and filter for 'type'=='Cell Line' to obtain only cell-line information.

```{bash}
wget -O controlled_vocab.txt http://hgdownload.soe.ucsc.edu/goldenPath/encodeDCC/cv.ra
```

### Parse the file and extract cellline to tissue mapping, separate file for available human cell lines
The final files (cellines_annotated.tsv and gtex_annotated.tsv) contain the cell-lines annotated with 
gtex tissues and the GTEx tissues annotated with celllines, respectively.

In the annotating process, we filter out any rows in the cell-line information where tissue corresponds
either to iPSC, ESC or melanoma or no tissue annotation was availabel for the cell-type.

The resulting lists have been sanity checked as far as possible, however, there is no guarantee regarding correctness
and completeness of the results.
 
```{bash}
python scripts/extract_cellline_mapping.py > cell_line_info.tsv
grep human cell_line_info.tsv > cell_line_info_human.tsv

Rscript scripts/match_celllines_to_gtex.R
```
