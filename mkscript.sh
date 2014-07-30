#!/bin/bash

touch $1
chmod +x $1
printf "#!/bin/bash\n" >> $1
mvim --remote-tab-silent $1
