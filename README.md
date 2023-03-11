
### Go backend masterclass
Golang, Postgres, Redis, Gin, gRPC, Docker, Kubernetes, AWS, CI/CD


## Tool setup on windows
### Using make commands on windows

https://gnuwin32.sourceforge.net/packages/make.htm

1. https://sourceforge.net/projects/gnuwin32/
2. install
3. add to path system variables

### Install scoop to use "migrate":
https://scoop.sh/
```
> Set-ExecutionPolicy RemoteSigned -Scope CurrentUser # Optional: Needed to run a remote script the first time
> irm get.scoop.sh | iex
```

https://github.com/ScoopInstaller/Scoop#readme


### Install "migrate" through scoop
` scoop install migrate `
- add migrate to path system variables (in ~\scoop\apps\migrate\ [version])