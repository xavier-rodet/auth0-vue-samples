#!/bin/bash

touch auth_config.json
echo "{\"domain\": \"$OIDC_DOMAIN\", \"clientId\": \"$OIDC_CLIENT_ID\", \"baseUrl\": \"$BASE_URL\"}" >> auth_config.json
