# Step 1
# go to hub.docker.com
# sign up for an account
# login
# create a repository
# give it a name
# then get the image repository name to use when we create our image (youname/nameofimage)
# On the right you'll see "To push a new tag to this repository"

# ==== Open terminal/command line to Create our image =====
# Build your image first
docker build -t pauloclouddev/random-emoji-app .

# Tag your image
docker tag pauloclouddev/random-emoji-app:latest pauloclouddev/random-emoji-app:1.0

# Make sure to login to docker hub in the terminal
# Go through the login process: enter username and password...then you'll be ready to push your image

docker login

# Push image
docker push yourusername/imagename:tag # add tag if you have one, if none it will default to lastest tag

