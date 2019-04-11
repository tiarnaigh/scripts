function ck {
  sources=$( ip route get 8.8.8.8 | grep '8.8.8.8' | awk '{print $7}' )
  [[ -z "$sources" ]] &&  sources=$( route PRINT | grep ' 0.0.0.0' | awk '{print $4}' )
  [[ -n "$3" ]] && sources="$3"
  for source in $(echo "$sources" | sed 's/,/ /g' )
  do
    curl="curl --interface $source"
    for add in $(echo "$1" | sed 's/,/ /g' )
    do
      for port in $(echo "$2" | sed 's/,/ /g' )
      do
        echo ""
        mesg="$add $port : "
        [[ -n "$source" ]]  && mesg="$source ==> $mesg"
        # This is weird. gets "no route to host" error, when the server is
        # not listening (instead of connection refused), so only check
        # timeout as error
        result=$( $curl -v -m 5 https://${add}:${port} 2>&1 )
        rc="$?"
        if [[ "$rc" = "28" ]]
        then
           #timeout out
           echo "$curl -v -m 5 https://${add}:${port}"
           echo -e "$mesg \e[91mFail\e[0m"
        elif [[ "$rc" = "7" ]]
        then
           #instead of "connection refused"
           echo -e "$mesg \e[36mLikely Success\e[0m"
        elif echo "$result" | tr '\n' ' ' | egrep 'Trying.* [Cc]onnected' > /dev/null
        then
           #instead of "connection refused"
           echo -e "$mesg \e[32mSuccess\e[0m"
        else
           echo "$curl -v -m 5 https://${add}:${port}"
           echo -e "$mesg \e[93mUnknown\e[0m"
        fi
      done #port
    done #address
  done #source
}
