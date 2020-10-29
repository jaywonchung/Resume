.PHONY: resume

resume:
	latexmk -xelatex resume.tex

clean:
	rm *.aux *.fdb_latexmk *.fls *.log *.out *.pdf
