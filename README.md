## Using powerlinego

If you use windows powerline terminal, please install font: Cascadia Code PL for better experience.


## Make docker images
```
docker build -t skyshinesdocker/tina_env \
-f Docker/tina_env.dockerfile \
--network host  .
```

skyshinesdocker: docker account username  

tina_env: docker image name  

Docker/tina_env.dockerfile: docker config file  

### !!!Please change docker account username to yours.    


## Make container  && Mount file folder

```
docker run -it --name tina_build --net=host \
-v ~/tina_d1_h:/mnt skyshinesdocker/tina_env
```

tina_build: docker container name   
~/tina_d1_h:/mnt: mount tina sdk location to container's mnt folder  
skyshinesdocker/tina_env: builded docker image  
### !!!Please change docker account username to yours. 

## Add vuser
```
passwd vuser
```

## Start container && Enter container
```
docker start tina_build
docker exec -it -u root tina_build bash
```

