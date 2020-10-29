.PHONY: resume

resume:
	sed -i -e "s/PHONE_NUMBER/+82 10-0000-0000/" -e "s/EMAIL_ADDRESS/email@null.ac.kr/" resume.tex cv.tex
	latexmk -xelatex resume.tex
	sed -i -e "s/+82 10-0000-0000/PHONE_NUMBER/" -e "s/email@null.ac.kr/EMAIL_ADDRESS/" resume.tex cv.tex

clean:
	rm *.aux *.fdb_latexmk *.fls *.log *.out *.pdf
