#-------------------------------------------
# skrypt do tworzenia kopi zapasowych
# podpinamy do Cronea
# i wywołujemy co X czasu...
# Blazej Kita
#------------------------------------------


#nazwa pliku bedzie zawierala date utworzenia kopi
DT=$(date '+%Y_%m_%d_%H_%M_%S')

#kopie trzymamy przez 14 dni.. wiecej nie trzeba
LASTDT=$(date --date="14 days ago" +"%Y_%m_%d" )


#lokalizacja backupu..
DIR_BACKUP="/home/myUser/backup/"

FILE=$DIR_BACKUP"baza_sql."$DT
TAR=$DIR_BACKUP"pliki_php."$DT

OLD_FILE=$DIR_BACKUP"baza_sql."$LASTDT*
OLD_TAR=$DIR_BACKUP"pliki_php."$LASTDT*


#usun pliki starsze niz 14 dni..
rm $OLD_FILE
rm $OLD_TAR

DB_USER=myUSER
DB_NAME=baza_prod
DB_NAMET=baza_test
DB_PASS=*********t

mysqldump --user=$DB_USER --password=$DB_PASS $DB_NAME > $FILE

#Skopiuj baze produkcyjna do bazy testowej
#mysql --user=$DB_USER --password=$DB_PASS $DB_NAMET < $FILE


tar -cf $FILE.tar $FILE
rm $FILE


#archiwuzuj pliki projektu bez plików multimedialnych
tar -cf $TAR.tar /var/www/public_html/mySite1/app

#dodaj kolejne katalogi do tego samego archiwum...
tar -rf $TAR.tar /var/www/public_html/mySite1/controller
tar -rf $TAR.tar /var/www/public_html/mySite1/model
tar -rf $TAR.tar /var/www/public_html/mySite1/.htaccess
tar -rf $TAR.tar /var/www/public_html/mySite1/index.php5
