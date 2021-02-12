function setip ()
    set ip (ip addr | grep inet6 | grep 'scope global dynamic mngtmpaddr' | awk '{print($2)}' | string split '/' | tail -n 2 | head -n 1)
    echo $ip
    cfcli edit -t AAAA bohm-bawerk $ip
end
