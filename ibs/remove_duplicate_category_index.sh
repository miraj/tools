
# Script to fix the duplicate entry problem in IBS cubecart
source db.conf

query='select *  from cube_CubeCart_cats_idx'
mysql -u$user -p"$pass" -h$host $db -e"$query" --batch > /tmp/$$.cat
file=/tmp/dup.$$

sort -k2,3 /tmp/$$.cat | uniq -c -f 1 | awk '$1 != 1' | awk '{print $2}' > $file

for dup in `cat $file`
do
	echo $dup
	mysql  -uislamtcb_cube5 -p'HM2Tk~E}b.&s'  -hislamicbookshelf.com  islamtcb_cubecar -e "delete from cube_CubeCart_cats_idx where id = $dup"
done
