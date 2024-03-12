from fontTools.ttLib.woff2 import compress

# Usage example
otf_path = 'fonts/variable/NovaGothicVF.otf'
woff2_path = 'fonts/variable/NovaGothicVFWeb.woff2'

# Convert the variable font to WOFF2 format
compress(otf_path, woff2_path)
