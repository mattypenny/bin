FOLDER=/home/matt/sdcard/backups/$(date +%Y%m%d)
mkdir -p $FOLDER

IMAGESFOLDER=/home/matt/sdcard/backups/$(date +%Y)
mkdir -p $IMAGESFOLDER

rsync -av --exclude='/home/matt/salisburyandstonehenge.net/public' --exclude='/home/matt/salisburyandstonehenge.net/static' /home/matt/salisburyandstonehenge.net $FOLDER/salisburyandstonehenge.net
rsync -av /home/matt/salisburyandstonehenge.net/static $IMAGESFOLDER/salisburyandstonehenge.net/static

rsync -av --exclude='/home/matt/mattypenny.net/public' --exclude='/home/matt/mattypenny.net/static' /home/matt/mattypenny.net $FOLDER/mattypenny.net

mkdir -p $IMAGESFOLDER/mattypenny.net/static

rsync -av /home/matt/mattypenny.net/static $IMAGESFOLDER/mattypenny.net/static
