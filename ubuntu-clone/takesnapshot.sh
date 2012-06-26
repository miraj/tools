


# Make sure your working dir is the partition you want to take snapshot
[[ $# < 1 ]] && { printf "Usage:\n    ./takesnapshot.sh <partition name> <snapshot name> \n\n"; exit 1; }
if [[ $EUID != 0 ]]
then
    echo "This script must be run as root user "
    echo "  try sudo ./takesnapshot.sh <snapshot name> <partition name>"
    exit 1
fi
dir=/mnt/disk
dev=$1

if [[ $2 == "" ]] 
then
    snapshot=~/clone/ubuntu-9.10.tgz 
else
    snapshot=$2
fi

if [[ -f $snapshot ]]
then
	echo "snapshot file ($snapshot) already exists"
	echo "Give a different name"
    	echo "  try sudo ./takesnapshot.sh <snapshot name> <partition name>"
	exit 2
fi

echo "snapshot = $snapshot"

echo mount $dev $dir
mount $dev $dir
if [[ $? != 0 ]] 
then
	echo "Mount failed"
	echo "Exiting......"
	exit 2
fi

cd $dir

tar czvf $snapshot * --exclude=home/*/Downloads/* --exclude=home/*/.local/share/Trash/* --exclude=home/*/sandbox --exclude=home/*/sand --exclude=home/*/Tivo*




