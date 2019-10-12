docker build -t crileroro/react-prd-client:latest -t crileroro/react-prd-client:$SHA -f ./client/Dockerfile ./client
docker build -t crileroro/react-prd-server:latest -t crileroro/react-prd-server:$SHA -f ./server/Dockerfile ./server
docker build -t crileroro/react-prd-worker:latest -t crileroro/react-prd-worker:$SHA -f ./worker/Dockerfile ./worker

docker push crileroro/react-prd-client:latest
docker push crileroro/react-prd-server:latest
docker push crileroro/react-prd-worker:latest

docker push crileroro/react-prd-client:$SHA
docker push crileroro/react-prd-server:$SHA
docker push crileroro/react-prd-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=crileroro/react-prd-server:$SHA
kubectl set image deployments/client-deployment client=crileroro/react-prd-client:$SHA
kubectl set image deployments/worker-deployment worker=crileroro/react-prd-worker:$SHA