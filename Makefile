help:
	@echo "###"
	@echo "# Build targets for Nova Gothic"
	@echo "###"
	@echo
	@echo "  make build:  Builds the fonts and places them in the fonts/ directory"
	@echo "  make zip:  Zip all fonts into a zip"
	@echo

init: requirements.txt
	pip install -Ur requirements.txt
	touch init.stamp

build: build.stamp

build.stamp: init.stamp
	fontmake -f src/NovaGothic.glyphspackage -o variable-cff2 --output-dir fonts/variable
	fontmake -i -f src/NovaGothic.glyphspackage -o otf-cff2 --output-dir fonts/static
	python misc/scripts/gen_woff2.py
	touch build.stamp

ufo: ufo.stamp

ufo.stamp: init.stamp
	fontmake -f src/NovaGothic.glyphspackage -o ufo --output-dir fonts-temp/master-ufo

zip: build.stamp
	cp -rf fonts NovaGothic
	zip -r NovaGothic.zip NovaGothic
	rm -rf NovaGothic

clean:
	rm -rf fonts
	rm -rf fonts-temp
	rm build.stamp
	rm ufo.stamp

update:
	pip install -Ur requirements.txt
