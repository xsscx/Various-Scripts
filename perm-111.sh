sudo find / -type f -perm +111 | perl -ne 'chomp;$f=$_;$n=$p=$a=0;open(F,"-|","strings","-10","-",$f) and map{$n=1 if/shouldAcceptNew/;$3?$p=1:$a=1 if/(bute((Pid)|Aud))|auditTok/}(<F>);$n and print"\e[",$a?31:$p?33:32,"m$f\e[0m\n"' 2>/dev/null
