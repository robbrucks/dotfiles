#   ------------------------------------------------------------
#   Kill the SSH Agent
#   ------------------------------------------------------------

if [[ -n ${SSH_AGENT_PID} ]]; then
  if [[ `users|tr ' ' '\n'|grep "${USER}"|wc -l` -eq 1 ]]; then
    ssh-add -D
    ssh-agent -k > /dev/null 2>&1
    unset SSH_AGENT_PID
    unset SSH_AUTH_SOCK
  fi
fi
