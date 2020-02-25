alias k='kubectl'

# Usage
# kk 
# kk <namespace>
kk(){
  NS="--all-namespaces"
  if ! [ -z $1 ]
  then
    NS="-n $1"
    echo "NAMESPACE : "$1
  fi
  echo "-------- SERVICES ----------"
  kubectl get services $NS
  echo "-------- REPLICASETS --------"
  kubectl get rs $NS
  echo "-------- DEPLOYMENT --------"
  kubectl get deployments $NS
  echo "-------- PODS --------------"
  kubectl get pods $NS
}

# Scale down and scale up a deployment to 1
kr() {
  kubectl scale deploy --replicas=0 $1 -n $2
  sleep 0.5
  kubectl scale deploy --replicas=1 $1 -n $2
}

# Tail logs
# Usage: 
# kl <deployment> <namespace>
# kl <deployment> <namespace> <tail>
kl(){
  if ! [ -z $3 ]
  then
    kubectl logs -f -n $2 $(kubectl get pods -n $2 | grep $(kubectl describe deploy $1 -n $2 | grep NewReplicaSet: | awk '{print $2}') | awk '{if ($3 == "Running") {print $1}}') --tail=$3
  else
    kubectl logs -f -n $2 $(kubectl get pods -n $2 | grep $(kubectl describe deploy $1 -n $2 | grep NewReplicaSet: | awk '{print $2}') | awk '{if ($3 == "Running") {print $1}}')
  fi
}

# Open a shell into a running pod
# Usage:
# kx <deployment> <namespace>
kx(){
  podName=`kubectl get pods -n $2 | grep $1 | cut -d ' ' -f 1`
  echo "Getting a shell into $podName in namespace: $2"
  kubectl exec -it $podName -n $2 -- sh
}

kes(){
  kubectl edit service $1 -n $2
}

ked(){
  kubectl edit deploy $1 -n $2
}

ks(){
  kubectl scale deploy $1 -n $2 --replicas=$3
}

kgd(){
  if ! [ -z $1 ] ; then 
    kubectl get deployments -n $1
  else
    kubectl get deployments --all-namespaces
  fi
}

kdd(){
  kubectl delete deployment $1 -n $2
}

kdp(){
  kubectl delete pod $1 -n $2
}

kds(){
  kubectl delete service $1 -n $2
}

kgp(){
  if ! [ -z $1 ] ; then 
    kubectl get pods -n $1
  else
    kubectl get pods --all-namespaces
  fi
}

kgs(){
  if ! [ -z $1 ] ; then 
    kubectl get svc -n $1
  else
    kubectl get svc --all-namespaces
  fi
}