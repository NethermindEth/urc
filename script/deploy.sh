#!/bin/sh

# This script deploys the Registry contract using Foundry
set -e

# Deployer private key
export PRIVATE_KEY=${PRIVATE_KEY:-"0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80"}

# Network configuration
export FORK_URL=${FORK_URL:-"http://localhost:8545"}

# Registry contract configuration
export MIN_COLLATERAL_WEI=${MIN_COLLATERAL_WEI:-"1000000000000000000"}
export FRAUD_PROOF_WINDOW=${FRAUD_PROOF_WINDOW:-"86400"} # 1 day in seconds
export UNREGISTRATION_DELAY=${UNREGISTRATION_DELAY:-"86400"} # 1 day in seconds
export SLASH_WINDOW=${SLASH_WINDOW:-"86400"} # 1 day in seconds
export OPT_IN_DELAY=${OPT_IN_DELAY:-"86400"} # 1 day in seconds

# Broadcast transactions
export BROADCAST=${BROADCAST:-true}

# Parameterize broadcasting
export BROADCAST_ARG=""
if [ "$BROADCAST" = "true" ]; then
    BROADCAST_ARG="--broadcast"
fi

# Parameterize log level
export LOG_LEVEL=${LOG_LEVEL:--vvvv}

# Parameterize block gas limit
export BLOCK_GAS_LIMIT=${BLOCK_GAS_LIMIT:-20000000}

# Run the deployment script using forge
forge script script/Deploy.s.sol \
    --fork-url $FORK_URL \
    $BROADCAST_ARG \
    $LOG_LEVEL \
    --private-key $PRIVATE_KEY \
    --block-gas-limit $BLOCK_GAS_LIMIT
