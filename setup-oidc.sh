#!/bin/bash

touch auth_config.json
echo "{\"domain\": \"$OIDC_DOMAIN\", \"clientId\": \"$OIDC_CLIENT_ID\"}" >> auth_config.json
# For "debug" purpose we could add more data here to ensure that they are here available at build time
# echo "{\"domain\": \"$OIDC_DOMAIN\", \"clientId\": \"$OIDC_CLIENT_ID\", \"baseUrl\": \"$BASE_URL\"}" >> auth_config.json