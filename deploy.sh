docker build -t yasubay/multi-client:latest -t yasubay/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t yasubay/multi-server:latest -t yasubay/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t yasubay/multi-worker:latest -t yasubay/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push yasubay/multi-client:latest
docker push yasubay/multi-server:latest
docker push yasubay/multi-worker:latest

docker push yasubay/multi-client:$SHA
docker push yasubay/multi-server:$SHA
docker push yasubay/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=yasubay/multi-client:$SHA
kubectl set image deployments/server-deployment server=yasubay/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=yasubay/multi-worker:$SHA