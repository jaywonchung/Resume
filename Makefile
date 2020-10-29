.PHONY: resume

resume:
	latexmk -xelatex resume.pdf

clean:
	rm *.aux *.fdb_latexmk *.fls *.log *.out *.pdf
