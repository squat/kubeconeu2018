# KubeCon EU 2018

This repository contains the demo code for my KubeCon EU 2018 talk about automating GPU infrastructure for Kubernetes on Container Linux.

## Prerequisites

You will need a Google Cloud account with available quota for NVIDIA GPUs.

## Getting Started

Edit the `require.tf` Terraform file and uncomment and add the details for your Google Cloud project:

```sh
$EDITOR require.tf
```

Modify the provided `terraform.tfvars` file to suit your project:

```sh
$EDITOR terraform.tfvars
```

## Running

1. create cluster:

    ```sh
    terraform apply --auto-approve
    ```

2. get nodes:

    ```sh
    export KUBECONFIG="$(pwd)"/assets/auth/kubeconfig
    watch -n 1 kubectl get nodes
    ```

3. create GPU manifests:

    ```sh
    kubectl apply -R -f manifests
    ```

4. check status of driver installer:

    ```sh
    kubectl logs $(kubectl get pods -n kube-system | grep nvidia-driver-installer | awk '{print $1}') -c modulus -n kube-system -f
    ```

5. check status of device plugin:

    ```sh
    kubectl logs $(kubectl get pods -n kube-system | grep nvidia-gpu-device-plugin | awk '{print $1}' | head -n1 | tail -n1) -n kube-system -f
    ```

6. verify worker node has allocatable GPUs:

    ```sh
    kubectl describe node $(kubectl get nodes | grep worker | awk '{print $1}')
    ```

7. let's inspect the GPU workload:

    ```sh
    less manifests/darkapi.yaml
    ```

8. let's see if the GPU workload has been scheduled:

    ```sh
    watch -n 2 kubectl get pods
    kubectl logs $(kubectl get pods | grep darkapi | awk '{print $1}') -f
    ```

9. for fun, let's test the GPU workload:

    ```sh
    export INGRESS=$(terraform output | grep ingress_static_ip | awk '{print $3}')
    ~/code/darkapi/client http://$INGRESS/api/yolo
    ```

10. finally, let's clean up:

    ```sh
    terraform destroy --auto-approve
    ```
