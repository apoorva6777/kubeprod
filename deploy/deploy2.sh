cd ..
cd infra
cd registry
terraform init
terraform apply --auto-approve
cd ..
cd ..

REPO_NAME_DETAILS="details-ms"
REPO_NAME_RATINGS="product-ms" 
REPO_NAME_PRODUCT="ratings-ms"

cd apps
cd books


#details
cd details

IMAGE_ID=$(docker build -q -t details:v0.1 .)

# Tag the image
docker tag $IMAGE_ID iad.ocir.io/idmaqhrbiuyo/$REPO_NAME_DETAILS:v0.1

# Push the tagged image 
docker push iad.ocir.io/idmaqhrbiuyo/$REPO_NAME_DETAILS:v0.1

cd ..

cd ratings
IMAGE_ID=$(docker build -q -t ratings:v0.1 .)

# Tag the image 
docker tag $IMAGE_ID iad.ocir.io/idmaqhrbiuyo/$REPO_NAME_RATINGS:v0.1

# Push the tagged image
docker push iad.ocir.io/idmaqhrbiuyo/$REPO_NAME_RATINGS:v0.1

cd ..
cd productpage

# Build the Docker image 
IMAGE_ID=$(docker build -q -t product:v0.1 .)

# Tag the image
docker tag $IMAGE_ID iad.ocir.io/idmaqhrbiuyo/$REPO_NAME_PRODUCT:v0.1 

# Push the tagged image
docker push iad.ocir.io/idmaqhrbiuyo/$REPO_NAME_PRODUCT:v0.1

echo "images pushed"





