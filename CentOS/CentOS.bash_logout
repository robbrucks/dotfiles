#   ------------------------------------------------------------
#   Kill the SSH Agent
#   ------------------------------------------------------------

if [[ $(ps --no-headers -fC bash|wc -l) -eq 2 ]]; then
  echo killing it
  ssh-add -D
  ssh-agent -k > /dev/null 2>&1
  unset SSH_AGENT_PID
  unset SSH_AUTH_SOCK
fi
