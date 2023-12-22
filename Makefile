all: histogram.tsv

clean:
	rm -f words.txt histogram.tsv

# prereqs go after the target in the rule - in this case the input file.
# commands have to exist before the commands for targets are run.
# helpful website: https://makefiletutorial.com/
words.txt: /usr/share/dict/words 
	cp $< $@ # dependency symbols - first and second?

histogram.tsv: histogram.r words.txt
	Rscript $<