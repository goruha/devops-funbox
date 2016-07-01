 #!/bin/bash

if [ -z "$SSH_2F_SECRET" ]; then
    echo "Please set env variable SSH_2F_SECRET"
    exit 1
fi

code=$(oathtool --base32 --totp "$SSH_2F_SECRET")

commands="
spawn ssh {*}$@
expect \"erification code:\"
send \"$code\n\"
interact
"

expect -c "$commands"
