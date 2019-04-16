awk 'BEGIN{
    for(i=ARGV[1];i>0;--i)
        {printf "\r%3d",i;system("sleep 1")}
    printf "\r%3d\n",i}
'
