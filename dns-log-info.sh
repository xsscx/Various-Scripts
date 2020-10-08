awk '{ print $8}' queries | sort | uniq -c | sort -nr | head -n 100
