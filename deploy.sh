# build images
docker build -t taka5hi/multi-client:latest -t taka5hi/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t taka5hi/multi-server:latest -t taka5hi/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t taka5hi/multi-worker:latest -t taka5hi/multi-worker:$SHA -f ./worker/Dockerfile ./worker

# push images to docker hub
docker push taka5hi/multi-client:latest
docker push taka5hi/multi-client:$SHA
docker push taka5hi/multi-server:latest
docker push taka5hi/multi-server:$SHA
docker push taka5hi/multi-worker:latest
docker push taka5hi/multi-worker:$SHA

# apply configs in k8s dir
kubectl apply -f k8s

# update container images
kubectl set image deployments/server-deployment server=taka5hi/multi-server:$SHA
kubectl set image deployments/client-deployment client=taka5hi/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=taka5hi/multi-worker:$SHA
