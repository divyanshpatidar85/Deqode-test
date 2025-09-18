# #!/bin/bash

# # Deploy Hello World Application to Nomad Cluster

# SERVER_IP=$(terraform output -raw nomad_server_public_ips | jq -r '.[0]')
# BOOTSTRAP_TOKEN=$(terraform output -raw nomad_bootstrap_token)

# echo "Deploying Hello World application to Nomad cluster..."
# echo "Server IP: $SERVER_IP"

# # Set Nomad environment variables
# export NOMAD_ADDR="http://$SERVER_IP:4646"
# export NOMAD_TOKEN="$BOOTSTRAP_TOKEN"

# # Wait for cluster to be ready
# echo "Waiting for Nomad cluster to be ready..."
# for i in {1..30}; do
#     if nomad node status > /dev/null 2>&1; then
#         echo "Cluster is ready!"
#         break
#     fi
#     echo "Waiting... ($i/30)"
#     sleep 10
# done

# # Check cluster status
# echo -e "\n=== Cluster Status ==="
# nomad node status
# echo -e "\n=== Server Members ==="
# nomad server members

# # Deploy the hello-world job
# echo -e "\n=== Deploying Hello World Application ==="
# nomad job run jobs/hello-world.nomad

# # Wait for deployment
# echo "Waiting for deployment to complete..."
# for i in {1..20}; do
#     STATUS=$(nomad job status hello-world | grep "Status" | awk '{print $3}')
#     if [ "$STATUS" = "running" ]; then
#         echo "Deployment successful!"
#         break
#     fi
#     echo "Deployment status: $STATUS ($i/20)"
#     sleep 5
# done

# # Show job status
# echo -e "\n=== Job Status ==="
# nomad job status hello-world

# # Get application URL
# CLIENT_IP=$(terraform output -raw nomad_client_public_ips | jq -r '.[0]')
# echo -e "\n=== Access Information ==="
# echo "Nomad UI: http://$SERVER_IP:4646"
# echo "Nomad Token: $BOOTSTRAP_TOKEN"
# echo "Hello World App: http://$CLIEN#!/bin/bash

# # Ensure jq is installed
# if ! command -v jq &> /dev/null; then
#     echo "jq not found. Installing..."
#     sudo apt-get update && sudo apt-get install -y jq
# fi

# # Deploy Hello World Application to Nomad Cluster

# SERVER_IP=$(terraform output -raw nomad_server_public_ips | jq -r '.[0]')
# BOOTSTRAP_TOKEN=$(terraform output -raw nomad_bootstrap_token)

# echo "Deploying Hello World application to Nomad cluster..."
# echo "Server IP: $SERVER_IP"

# # Set Nomad environment variables
# export NOMAD_ADDR="http://$SERVER_IP:4646"
# export NOMAD_TOKEN="$BOOTSTRAP_TOKEN"

# # Wait for cluster to be ready
# echo "Waiting for Nomad cluster to be ready..."
# for i in {1..30}; do
#     if nomad node status > /dev/null 2>&1; then
#         echo "Cluster is ready!"
#         break
#     fi
#     echo "Waiting... ($i/30)"
#     sleep 10
#     if [ $i -eq 30 ]; then
#         echo "Nomad cluster did not become ready in time."
#         exit 1
#     fi
# done

# # Check cluster status
# echo -e "\n=== Cluster Status ==="
# nomad node status
# echo -e "\n=== Server Members ==="
# nomad server members

# # Deploy the hello-world job
# echo -e "\n=== Deploying Hello World Application ==="
# if [ ! -f jobs/hello-world.nomad ]; then
#     echo "Job file jobs/hello-world.nomad not found!"
#     exit 1
# fi
# nomad job run jobs/hello-world.nomad

# # Wait for deployment
# echo "Waiting for deployment to complete..."
# for i in {1..20}; do
#     STATUS=$(nomad job status hello-world | awk '/Status/ {print $2; exit}')
#     if [ "$STATUS" = "running" ]; then
#         echo "Deployment successful!"
#         break
#     fi
#     echo "Deployment status: $STATUS ($i/20)"
#     sleep 5
#     if [ $i -eq 20 ]; then
#         echo "Deployment did not complete in time."
#         exit 1
#     fi
# done

# # Show job status
# echo -e "\n=== Job Status ==="
# nomad job status hello-world

# # Get application URL
# CLIENT_IP=$(terraform output -raw nomad_client_public_ips | jq -r '.[0]')
# echo -e "\n=== Access Information ==="
# echo "Nomad UI: http://$SERVER_IP:4646"
# echo "Nomad Token: $BOOTSTRAP_TOKEN"
# echo "Hello World App: http://$CLIENT_IP:8080"
# echo -e "\nNote: Use the token above to access the Nomad UI"#!/bin/bash

# # Ensure jq is installed
# if ! command -v jq &> /dev/null; then
#     echo "jq not found. Installing..."
#     sudo apt-get update && sudo apt-get install -y jq
# fi

# # Deploy Hello World Application to Nomad Cluster

# SERVER_IP=$(terraform output -raw nomad_server_public_ips | jq -r '.[0]')
# BOOTSTRAP_TOKEN=$(terraform output -raw nomad_bootstrap_token)

# echo "Deploying Hello World application to Nomad cluster..."
# echo "Server IP: $SERVER_IP"

# # Set Nomad environment variables
# export NOMAD_ADDR="http://$SERVER_IP:4646"
# export NOMAD_TOKEN="$BOOTSTRAP_TOKEN"

# # Wait for cluster to be ready
# echo "Waiting for Nomad cluster to be ready..."
# for i in {1..30}; do
#     if nomad node status > /dev/null 2>&1; then
#         echo "Cluster is ready!"
#         break
#     fi
#     echo "Waiting... ($i/30)"
#     sleep 10
#     if [ $i -eq 30 ]; then
#         echo "Nomad cluster did not become ready in time."
#         exit 1
#     fi
# done

# # Check cluster status
# echo -e "\n=== Cluster Status ==="
# nomad node status
# echo -e "\n=== Server Members ==="
# nomad server members

# # Deploy the hello-world job
# echo -e "\n=== Deploying Hello World Application ==="
# if [ ! -f jobs/hello-world.nomad ]; then
#     echo "Job file jobs/hello-world.nomad not found!"
#     exit 1
# fi
# nomad job run jobs/hello-world.nomad

# # Wait for deployment
# echo "Waiting for deployment to complete..."
# for i in {1..20}; do
#     STATUS=$(nomad job status hello-world | awk '/Status/ {print $2; exit}')
#     if [ "$STATUS" = "running" ]; then
#         echo "Deployment successful!"
#         break
#     fi
#     echo "Deployment status: $STATUS ($i/20)"
#     sleep 5
#     if [ $i -eq 20 ]; then
#         echo "Deployment did not complete in time."
#         exit 1
#     fi
# done

# # Show job status
# echo -e "\n=== Job Status ==="
# nomad job status hello-world

# # Get application URL
# CLIENT_IP=$(terraform output -raw nomad_client_public_ips | jq -r '.[0]')
# echo -e "\n=== Access Information ==="
# echo "Nomad UI: http://$SERVER_IP:4646"
# echo "Nomad Token: $BOOTSTRAP_TOKEN"
# echo "Hello World App: http://$CLIENT_IP:8080"
# echo -e "\nNote: Use the token above to access the Nomad UI"#!/bin/bash

# # Ensure jq is installed
# if ! command -v jq &> /dev/null; then
#     echo "jq not found. Installing..."
#     sudo apt-get update && sudo apt-get install -y jq
# fi

# # Deploy Hello World Application to Nomad Cluster

# SERVER_IP=$(terraform output -raw nomad_server_public_ips | jq -r '.[0]')
# BOOTSTRAP_TOKEN=$(terraform output -raw nomad_bootstrap_token)

# echo "Deploying Hello World application to Nomad cluster..."
# echo "Server IP: $SERVER_IP"

# # Set Nomad environment variables
# export NOMAD_ADDR="http://$SERVER_IP:4646"
# export NOMAD_TOKEN="$BOOTSTRAP_TOKEN"

# # Wait for cluster to be ready
# echo "Waiting for Nomad cluster to be ready..."
# for i in {1..30}; do
#     if nomad node status > /dev/null 2>&1; then
#         echo "Cluster is ready!"
#         break
#     fi
#     echo "Waiting... ($i/30)"
#     sleep 10
#     if [ $i -eq 30 ]; then
#         echo "Nomad cluster did not become ready in time."
#         exit 1
#     fi
# done

# # Check cluster status
# echo -e "\n=== Cluster Status ==="
# nomad node status
# echo -e "\n=== Server Members ==="
# nomad server members

# # Deploy the hello-world job
# echo -e "\n=== Deploying Hello World Application ==="
# if [ ! -f jobs/hello-world.nomad ]; then
#     echo "Job file jobs/hello-world.nomad not found!"
#     exit 1
# fi
# nomad job run jobs/hello-world.nomad

# # Wait for deployment
# echo "Waiting for deployment to complete..."
# for i in {1..20}; do
#     STATUS=$(nomad job status hello-world | awk '/Status/ {print $2; exit}')
#     if [ "$STATUS" = "running" ]; then
#         echo "Deployment successful!"
#         break
#     fi
#     echo "Deployment status: $STATUS ($i/20)"
#     sleep 5
#     if [ $i -eq 20 ]; then
#         echo "Deployment did not complete in time."
#         exit 1
#     fi
# done

# # Show job status
# echo -e "\n=== Job Status ==="
# nomad job status hello-world

# # Get application URL
# CLIENT_IP=$(terraform output -raw nomad_client_public_ips | jq -r '.[0]')
# echo -e "\n=== Access Information ==="
# echo "Nomad UI: http://$SERVER_IP:4646"
# echo "Nomad Token: $BOOTSTRAP_TOKEN"
# echo "Hello World App: http://$CLIENT_IP:8080"
# echo -e "\nNote: Use the token above to access the Nomad UI"#!/bin/bash

# # Ensure jq is installed
# if ! command -v jq &> /dev/null; then
#     echo "jq not found. Installing..."
#     sudo apt-get update && sudo apt-get install -y jq
# fi

# # Deploy Hello World Application to Nomad Cluster

# SERVER_IP=$(terraform output -raw nomad_server_public_ips | jq -r '.[0]')
# BOOTSTRAP_TOKEN=$(terraform output -raw nomad_bootstrap_token)

# echo "Deploying Hello World application to Nomad cluster..."
# echo "Server IP: $SERVER_IP"

# # Set Nomad environment variables
# export NOMAD_ADDR="http://$SERVER_IP:4646"
# export NOMAD_TOKEN="$BOOTSTRAP_TOKEN"

# # Wait for cluster to be ready
# echo "Waiting for Nomad cluster to be ready..."
# for i in {1..30}; do
#     if nomad node status > /dev/null 2>&1; then
#         echo "Cluster is ready!"
#         break
#     fi
#     echo "Waiting... ($i/30)"
#     sleep 10
#     if [ $i -eq 30 ]; then
#         echo "Nomad cluster did not become ready in time."
#         exit 1
#     fi
# done

# # Check cluster status
# echo -e "\n=== Cluster Status ==="
# nomad node status
# echo -e "\n=== Server Members ==="
# nomad server members

# # Deploy the hello-world job
# echo -e "\n=== Deploying Hello World Application ==="
# if [ ! -f jobs/hello-world.nomad ]; then
#     echo "Job file jobs/hello-world.nomad not found!"
#     exit 1
# fi
# nomad job run jobs/hello-world.nomad

# # Wait for deployment
# echo "Waiting for deployment to complete..."
# for i in {1..20}; do
#     STATUS=$(nomad job status hello-world | awk '/Status/ {print $2; exit}')
#     if [ "$STATUS" = "running" ]; then
#         echo "Deployment successful!"
#         break
#     fi
#     echo "Deployment status: $STATUS ($i/20)"
#     sleep 5
#     if [ $i -eq 20 ]; then
#         echo "Deployment did not complete in time."
#         exit 1
#     fi
# done

# # Show job status
# echo -e "\n=== Job Status ==="
# nomad job status hello-world

# # Get application URL
# CLIENT_IP=$(terraform output -raw nomad_client_public_ips | jq -r '.[0]')
# echo -e "\n=== Access Information ==="
# echo "Nomad UI: http://$SERVER_IP:4646"
# echo "Nomad Token: $BOOTSTRAP_TOKEN"
# echo "Hello World App: http://$CLIENT_IP:8080"
# echo -e "\nNote: Use the token above to access the Nomad UI"#!/bin/bash

# # Ensure jq is installed before anything else
# if ! command -v jq &> /dev/null; then
#     echo "jq not found. Installing..."
#     sudo apt-get update && sudo apt-get install -y jq
# fiSERVER_IP=$(terraform output -raw nomad_server_public_ips)
# CLIENT_IP=$(terraform output -raw nomad_client_public_ips)SERVER_IP=$(terraform output -raw nomad_server_public_ips)
# CLIENT_IP=$(terraform output -raw nomad_client_public_ips)#!/bin/bash

# # Ensure jq is installed before anything else
# if ! command -v jq &> /dev/null; then
#     echo "jq not found. Installing..."
#     sudo apt-get update && sudo apt-get install -y jq
# fi

# # Get IPs (adjust as needed based on your output)
# SERVER_IP=$(terraform output -raw nomad_server_public_ips)
# CLIENT_IP=$(terraform output -raw nomad_client_public_ips)
# BOOTSTRAP_TOKEN=$(terraform output -raw nomad_bootstrap_token)

# echo "Deploying Hello World application to Nomad cluster..."
# echo "Server IP: $SERVER_IP"

# # ...rest of your script...#!/bin/bash

# # Ensure jq is installed before anything else
# if ! command -v jq &> /dev/null; then
#     echo "jq not found. Installing..."
#     sudo apt-get update && sudo apt-get install -y jq
# fi

# # Get IPs and token (assuming outputs are single values, not arrays)
# SERVER_IP=$(terraform output -raw nomad_server_public_ips)
# CLIENT_IP=$(terraform output -raw nomad_client_public_ips)
# BOOTSTRAP_TOKEN=$(terraform output -raw nomad_bootstrap_token)

# echo "Deploying Hello World application to Nomad cluster..."
# echo "Server IP: $SERVER_IP"

# # Set Nomad environment variables
# export NOMAD_ADDR="http://$SERVER_IP:4646"
# export NOMAD_TOKEN="$BOOTSTRAP_TOKEN"

# # Wait for cluster to be ready
# echo "Waiting for Nomad cluster to be ready..."
# for i in {1..30}; do
#     if nomad node status > /dev/null 2>&1; then
#         echo "Cluster is ready!"
#         break
#     fi
#     echo "Waiting... ($i/30)"
#     sleep 10
#     if [ $i -eq 30 ]; then
#         echo "Nomad cluster did not become ready in time."
#         exit 1
#     fi
# done

# # Check cluster status
# echo -e "\n=== Cluster Status ==="
# nomad node status
# echo -e "\n=== Server Members ==="
# nomad server members

# # Deploy the hello-world job
# echo -e "\n=== Deploying Hello World Application ==="
# if [ ! -f jobs/hello-world.nomad ]; then
#     echo "Job file jobs/hello-world.nomad not found!"
#     exit 1
# fi
# nomad job run jobs/hello-world.nomad

# # Wait for deployment
# echo "Waiting for deployment to complete..."
# for i in {1..20}; do
#     STATUS=$(nomad job status hello-world | awk '/Status/ {print $2; exit}')
#     if [ "$STATUS" = "running" ]; then
#         echo "Deployment successful!"
#         break
#     fi
#     echo "Deployment status: $STATUS ($i/20)"
#     sleep 5
#     if [ $i -eq 20 ]; then
#         echo "Deployment did not complete in time."
#         exit 1
#     fi
# done

# # Show job status
# echo -e "\n=== Job Status ==="
# nomad job status hello-world

# # Show access info
# echo -e "\n=== Access Information ==="
# echo "Nomad UI: http://$SERVER_IP:4646"
# echo "Nomad Token: $BOOTSTRAP_TOKEN"
# echo "Hello World App: http://$CLIENT_IP:8080"
# echo -e "\nNote: Use the token above to access the Nomad UI"T_IP:8080"
# echo -e "\nNote: Use the token above to access the Nomad UI"


#!/bin/bash

# Ensure jq is installed before anything else
if ! command -v jq &> /dev/null; then
    echo "jq not found. Installing..."
    sudo apt-get update && sudo apt-get install -y jq
fi

# Get IPs and token (assuming outputs are single values, not arrays)
SERVER_IP=$(terraform output -raw nomad_server_public_ips)
CLIENT_IP=$(terraform output -raw nomad_client_public_ips)
BOOTSTRAP_TOKEN=$(terraform output -raw nomad_bootstrap_token)

echo "Deploying Hello World application to Nomad cluster..."
echo "Server IP: $SERVER_IP"

# Set Nomad environment variables
export NOMAD_ADDR="http://$SERVER_IP:4646"
export NOMAD_TOKEN="$BOOTSTRAP_TOKEN"

# Wait for cluster to be ready
echo "Waiting for Nomad cluster to be ready..."
for i in {1..30}; do
    if nomad node status > /dev/null 2>&1; then
        echo "Cluster is ready!"
        break
    fi
    echo "Waiting... ($i/30)"
    sleep 10
    if [ $i -eq 30 ]; then
        echo "Nomad cluster did not become ready in time."
        exit 1
    fi
done

# Check cluster status
echo -e "\n=== Cluster Status ==="
nomad node status
echo -e "\n=== Server Members ==="
nomad server members

# Deploy the hello-world job
echo -e "\n=== Deploying Hello World Application ==="
if [ ! -f jobs/hello-world.nomad ]; then
    echo "Job file jobs/hello-world.nomad not found!"
    exit 1
fi
nomad job run jobs/hello-world.nomad

# Wait for deployment
echo "Waiting for deployment to complete..."
for i in {1..20}; do
    STATUS=$(nomad job status hello-world | awk '/Status/ {print $2; exit}')
    if [ "$STATUS" = "running" ]; then
        echo "Deployment successful!"
        break
    fi
    echo "Deployment status: $STATUS ($i/20)"
    sleep 5
    if [ $i -eq 20 ]; then
        echo "Deployment did not complete in time."
        exit 1
    fi
done

# Show job status
echo -e "\n=== Job Status ==="
nomad job status hello-world

# Show access info
echo -e "\n=== Access Information ==="
echo "Nomad UI: http://$SERVER_IP:4646"
echo "Nomad Token: $BOOTSTRAP_TOKEN"
echo "Hello World App: http://$CLIENT_IP:8080"
echo -e "\nNote: Use the token above to access the Nomad UI"#!/bin/bash

# Get first server and client IPs from Terraform output (no jq)
SERVER_IP=$(terraform output -json nomad_server_public_ips | grep -oE '"[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+"' | head -n1 | tr -d '"')
CLIENT_IP=$(terraform output -json nomad_client_public_ips | grep -oE '"[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+"' | head -n1 | tr -d '"')
BOOTSTRAP_TOKEN=$(terraform output -raw nomad_bootstrap_token)

echo "Deploying Hello World application to Nomad cluster..."
echo "Server IP: $SERVER_IP"

# Set Nomad environment variables
export NOMAD_ADDR="http://$SERVER_IP:4646"
export NOMAD_TOKEN="$BOOTSTRAP_TOKEN"

# Wait for cluster to be ready
echo "Waiting for Nomad cluster to be ready..."
for i in {1..30}; do
    if nomad node status > /dev/null 2>&1; then
        echo "Cluster is ready!"
        break
    fi
    echo "Waiting... ($i/30)"
    sleep 10
    if [ $i -eq 30 ]; then
        echo "Nomad cluster did not become ready in time."
        exit 1
    fi
done

# Check cluster status
echo -e "\n=== Cluster Status ==="
nomad node status
echo -e "\n=== Server Members ==="
nomad server members

# Deploy the hello-world job
echo -e "\n=== Deploying Hello World Application ==="
if [ ! -f jobs/hello-world.nomad ]; then
    echo "Job file jobs/hello-world.nomad not found!"
    exit 1
fi
nomad job run jobs/hello-world.nomad

# Wait for deployment
echo "Waiting for deployment to complete..."
for i in {1..20}; do
    STATUS=$(nomad job status hello-world | awk '/Status/ {print $2; exit}')
    if [ "$STATUS" = "running" ]; then
        echo "Deployment successful!"
        break
    fi
    echo "Deployment status: $STATUS ($i/20)"
    sleep 5
    if [ $i -eq 20 ]; then
        echo "Deployment did not complete in time."
        exit 1
    fi
done

# Show job status
echo -e "\n=== Job Status ==="
nomad job status hello-world

# Show access info
echo -e "\n=== Access Information ==="
echo "Nomad UI: http://$SERVER_IP:4646"
echo "Nomad Token: $BOOTSTRAP_TOKEN"
echo "Hello World App: http://$CLIENT_IP:8080"
echo -e "\nNote: Use the token above to access the Nomad UI"
