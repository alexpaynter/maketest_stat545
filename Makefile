# It annoys me that they're just updating the "final" target here in all.
all: report.html

clean:
	rm -f words.txt histogram.tsv histogram.png report.md, report.html

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
	
# new rule for making the report - lists all the dependencies
# how could we refer to a second dependency if we wanted to?
report.html: report.rmd histogram.tsv histogram.png
	Rscript -e 'rmarkdown::render("$<")'

# Optional extensions:

# .PHONY tells make which things are not actual files to be created.
# Reason stated is if you make a file with the same name, e.g. a folder 
#   named clean, it can get confused.
.PHONY: all clean
# .DELETE_ON_ERROR files to delete if an error comes up while making them
# .SECONDARY prevents intermediate files from being deleted (not totally clear on how)