all: words.txt

clean:
	rm -f words.txt

# input file goes in the command line
words.txt: /usr/share/dict/words 
	cp $< $@ #input and output symbols.

histogram.tsv: histogram.r words.txt
	Rscript $<