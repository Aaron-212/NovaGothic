help:
	@echo "###"
	@echo "# Build targets for Nova Gothic"
	@echo "###"
	@echo
	@echo "  make build:  Builds the fonts and places them in the fonts/ directory"
	@echo "  make zip:  Zip static fonts into a zip"
	@echo

build: build.stamp

build.stamp: init.stamp
	fontmake -f src/NovaGothic.glyphspackage -o variable --output-dir fonts/variable && fontmake -i -f src/NovaGothic.glyphspackage -o otf --output-dir fonts/static && touch build.stamp

init: requirements.txt
	pip install -Ur requirements.txt
	touch init.stamp

zip: build.stamp
	cp -rf fonts NovaGothic
	zip -r NovaGothic.zip NovaGothic
	rm -rf NovaGothic

clean:
	rm -rf fonts
	rm build.stamp

update:
	pip install -Ur requirements.txt

manual_release: build.stamp
	@echo "Creating release files manually is contraindicated."
	@echo "Please use the CI for releases instead."
	cd fonts; for family in *; do VERSION=`font-v report $$family/unhinted/ttf/* | grep Version | sort -u  | awk '{print $$2}'`; zip -r ../$$family-v$$VERSION.zip $$family; done