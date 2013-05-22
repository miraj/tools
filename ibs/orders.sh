source db.conf

file=$1

for id in `cat $file`
do
	#echo $id
	query="select name, add_1_d, add_2_d, town_d, county_d, postcode_d, country_d, phone, mobile, email, time from cube_CubeCart_order_sum where cart_order_id = \"$id\""
	mysql -u$user -p"$pass" -h$host $db -e"$query" --delimiter=":" --batch | sed '1d' > /tmp/$$
	t=`awk -F'\t' '{print $11}' /tmp/$$`
	tt=`./printtime.tcl $t`
    printf "$tt\t"
	awk -F'\t' '{printf "%s\t%s,%s,%s,%s,%s,%s\t%s\t%s\t%s\t", $1, $2, $3, $4, $5, $6, $7, $8, $9, $10 }' /tmp/$$
	echo $id
 
done


#cart_order_id	customer_id	name	add_1	add_2	town	county	postcode	country	name_d	add_1_dadd_2_d	town_d	county_d	postcode_d	country_d	phone	mobile	subtotal	prod_total	total_tax	total_ship	status	sec_order_id	ip	time	email	comments	ship_date	shipMethod	gateway	currency	customer_comments
