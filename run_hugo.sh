
Theme=hyde

echo $Theme

cd ~/salisburyandstonehenge.net
# hugo server -w  --renderToDisk --theme hyde --verbose
hugo server -w  --renderToDisk --theme $Theme --verbose --cleanDestinationDir
# hugo server -w  --renderToDisk  --verbose
