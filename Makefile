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
	fontmake -f src/NovaGothic.glyphspackage -o variable --output-path "fonts/variable/NovaGothic[wght].ttf" --filter DecomposeTransformedComponentsFilter
	fontmake -f src/NovaGothic.glyphspackage -o variable-cff2 --output-path "fonts/variable/NovaGothic[wght].otf" --filter DecomposeTransformedComponentsFilter
	fontmake -i -f src/NovaGothic.glyphspackage -o ttf --output-dir fonts/static --filter DecomposeTransformedComponentsFilter
	fontmake -i -f src/NovaGothic.glyphspackage -o otf --output-dir fonts/static --filter DecomposeTransformedComponentsFilter 
	python misc/scripts/gen_woff2.py
	touch build.stamp

ufo: ufo.stamp

ufo.stamp: init.stamp
	fontmake -f src/NovaGothic.glyphspackage -o ufo --output-dir fonts-temp/master-ufo

zip: build.stamp
	cp -rf fonts NovaGothic
	zip -r NovaGothic.zip NovaGothic
	rm -rf NovaGothic

test: build.stamp
	fontbakery check-universal fonts/variable/NovaGothic[wght].otf

cleanbuild:
	rm -rf fonts
	rm build.stamp

cleanufo:
	rm -rf fonts-temp
	rm ufo.stamp

update:
	pip install -Ur requirements.txt
