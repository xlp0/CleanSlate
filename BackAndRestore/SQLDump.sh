#! /bin/bash
# Local .env
if [ -f .env ]; then
    # Load Environment Variables
    export $(cat .env | grep -v '#' | awk '/=/ {print $1}')
    # For instance, will be example_kaggle_key
    echo $SOME_KEY
fi

FilePrefix="XLP_WIKI"
DATE=$(date +"%m-%d-%Y_%H_%M_%S_%Z")
DATABASE="my_wiki"
# PASSWORD="STORED IN THE .ENV FILE in the same directory"

echo "Ready to dump SQL content ... "
mysqldump -u root --password=$PASSWORD $DATABASE -c | nice -n 19 gzip > $FilePrefix-$DATE.sql.gz
