awk '{ print $8}' queries | sort | uniq -c | sort -nr 
