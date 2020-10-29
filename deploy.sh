docker build -t matthv/multi-client:latest -t matthv/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t matthv/multi-server:latest -t matthv/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t matthv/multi-worker:latest -t matthv/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push matthv/multi-client:latest
docker push matthv/multi-server:latest
docker push matthv/multi-worker:latest

docker push matthv/multi-client:$SHA
docker push matthv/multi-server:$SHA
docker push matthv/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=matthv/multi-server:$SHA
kubectl set image deployments/client-deployment client=matthv/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=matthv/multi-worker:$SHA
