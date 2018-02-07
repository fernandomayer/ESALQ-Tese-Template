# Tese.pdf: Tese.Rnw \
# 	referencias/bibliografia.bib template/Template_Tese.sty \
# 	pre-textual/TodasInformações.Rnw pre-textual/Agradecimentos.Rnw \
# 	pre-textual/Biografia.Rnw pre-textual/Dedicatoria.Rnw \
# 	pre-textual/Epigrafe.Rnw pre-textual/ListaAbreviaturas.Rnw \
# 	pre-textual/ListaSimbolos.Rnw pre-textual/Resumo.Rnw \
# 	textual/Introdução.Rnw textual/MatMet.Rnw textual/Resultados.Rnw \
# 	textual/Discussão.Rnw \
# 	pos-textual/Anexos.Rnw pos-textual/Apêndices.Rnw
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
