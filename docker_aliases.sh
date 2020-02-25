alias d='docker'
# remove stopped containers and unused / dangling images
alias dclean='docker container rm $(docker container ls -a -q -f status=exited) ; docker image rm $(docker images -f dangling=true -q)'
alias dcon='docker container'
alias dcons='docker container ls -a'
alias dim='docker image'
alias dims='docker image ls'
alias dip='docker inspect -f "{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}"'