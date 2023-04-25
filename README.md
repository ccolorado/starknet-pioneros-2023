Cairo development environment Container
Requires a functional docker setup

```bash
# Step 1:
# Rename env.sample file to env

mv env.sample env

# Step 2
# Fill up the volumne details ($STORAGE_DIR and $MOUNTPOINT_DIR)

STORAGE_DIR="path the directory you want to share with your container"
MOUNTPOINT_DIR="mont point for $STORAGE_DIR"
IMAGE_NAME="starknetes-cairo-goerli"
CONTAINER_NAME="starknetes_c1"

# Usage

./vm-upsert  # Completely handles the life cycle of the containers and images by:
             # 1. Fully reset dev environment and connects to container
             # 2. Preemptively stops and destroys containers and images
             # 3. Preemptively creates and starts containers
             # 4. Connects to fresh container

# Granularly available helpers
./vm-connect # connects to the build and running container [Requires successful vm-start]
./vm-create  # discards image build and creates it again [Can be run independently]
./vm-destroy # stops container or destroys containers depending on state [Requires a vm-start or vm-create]
./vm-start   # starts built container [Requires successful vm-create]

```
