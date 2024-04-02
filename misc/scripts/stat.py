from fontTools.otlLib.builder import buildStatTable
from fontTools.ttLib.ttFont import TTFont

paths = [
    "fonts/variable/NovaGothic[wght].ttf",
    "fonts/variable/NovaGothic[wght].otf",
    "fonts/static/NovaGothic-Light.otf",
    "fonts/static/NovaGothic-Regular.otf",
    "fonts/static/NovaGothic-Medium.otf",
    "fonts/static/NovaGothic-Bold.otf",
    "fonts/static/NovaGothic-Light.ttf",
    "fonts/static/NovaGothic-Regular.ttf",
    "fonts/static/NovaGothic-Medium.ttf",
    "fonts/static/NovaGothic-Bold.ttf",
]

axes = [
    dict(
        tag="wght",
        name="Weight",
        values=[
            dict(value=200, name='Light'),
            dict(value=400, name='Regular', flags=0x2, linkedValue=800),
            dict(value=600, name='Medium'),
            dict(value=800, name='Bold'),
        ],
    )
]

for path in paths:
    font = TTFont(path)
    buildStatTable(font, axes=axes)
    font.save(path)