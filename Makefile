Tese.pdf: Tese.Rnw \
	referencias/bibliografia.bib template/Template_Tese.sty \
	pre-textual/*.Rnw \
	textual/*.Rnw \
	pos-textual/*.Rnw

	Rscript -e 'knitr::knit("Tese.Rnw")'
	xelatex Tese.tex
	# O sinal de "menos" é para ignorar erros e prosseguir
	# Eles não são importantes no caso do bibtex
	-bibtex Tese.aux
	xelatex Tese.tex
	xelatex Tese.tex
	rm *.aux *.bbl *.blg *.log *.toc *.lof *.lot
