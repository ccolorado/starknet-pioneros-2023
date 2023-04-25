Cairo development environment Container

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

# Run
./vm-upsert
```
