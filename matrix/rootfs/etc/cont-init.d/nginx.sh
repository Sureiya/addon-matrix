#!/usr/bin/with-contenv bashio
# ==============================================================================
# Home Assistant Community Add-on: Matrix
# Configures NGINX for use with Riot
# ==============================================================================

# Generate direct access configuration, if enabled.
if bashio::var.has_value "$(bashio::addon.port 80)"; then
    bashio::config.require.ssl
    bashio::var.json \
        certfile "$(bashio::config 'certfile')" \
        keyfile "$(bashio::config 'keyfile')" \
        leave_front_door_open "^$(bashio::config 'leave_front_door_open')" \
        ssl "^$(bashio::config 'ssl')" \
        | tempio \
            -template /etc/nginx/templates/direct.gtpl \
            -out /etc/nginx/servers/direct.conf
fi
