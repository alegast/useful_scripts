useful_scripts
==============

some bash and other scripts


rollback_release.sh

I use this script to make fast rollback, if last build was with critical error, etc ...
it will work in typical web sites deploy structure: current, releases. current - symlink to releases/2014-03-25_16-24-45. symlink relocated after each build
there is regexp to check release dir. valid format is 2014-03-25_16-24-45 or 20140325162445. I run it from jenkins interface (works fine for now)


clear_old_releases.sh

Used to clean old releases after each deploy, leave only 5 last. I run it also from jenkins 
