# It annoys me that they're just updating the "final" target here in all.
all: histogram.png

clean:
	rm -f words.txt histogram.tsv

# prereqs go after the target in the rule - in this case the input file.
# commands have to exist before the commands for targets are run.
# helpful website: https://makefiletutorial.com/
words.txt: /usr/share/dict/words 
	cp $< $@ # dependency symbols - first and second?

histogram.tsv: histogram.r words.txt
	Rscript $<
	
# here $@ refers to the output file (target)
# just testing a git change.
histogram.png: histogram.tsv
	Rscript -e 'library(ggplot2); qplot(Length, Freq, data=read.delim("$<")); ggsave("$@")'
	rm Rplots.pdf