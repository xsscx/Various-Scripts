 find / \( -perm -o+w \) \( -user root -or -group wheel \)  -exec ls -adl {} \; 2>/dev/null
