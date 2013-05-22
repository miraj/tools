
source db.conf
table=


month=`date | awk '{print $2}'`
year=`date | awk '{print $NF}'`
file=`date | sed 's/ /_/g' | sed 's/:/_/g'  | sed 's/....//'`

echo $dir/$year/$month
echo $file

mkdir -p $dir/$year/$month
mysqldump -u$user -p"$pass" -h$host $db $table > $dir/$year/$month/$file.sql



