all:
	rm -r docs/;\
	stack build;\
	stack exec site rebuild;\
	staticrypt _site/readings.html rutgers -e -o "_site/readings.html" -f "encrypt.html"
	mv _site/ docs/;\

clean:
	rm -r docs/
