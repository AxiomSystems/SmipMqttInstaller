# Installer for SMIP MQTT Gateway Services

The contents of this installer are intended to be merged with the contents of the published Custom Connector for Linux installer, not distributed here for licensing reasons, and output of two related projects, as noted below.

Building this installer without those contents will result in an unusable environment.

## Building the Installer

- Unpack Custom Connector installer like:
    - `mkdir smip-mqtt-gateway`
    - `dpkg-deb --extract ./tiq-gateway.deb ./smip-mqtt-gateway`
    - `dpkg-deb --control ./tiq-gateway.deb ./smip-mqtt-gateway`
- Merge contents of this repo into `smip-mqtt-gateway` over-writing existing files
- Ensure a folder structure like:
```
- [myapp]
-- DEBIAN
--- control
-- opt
--- thinkiq
---- etc
----- <files and folders>
---- services
----- <files and folders>
```
- Build the new install package like:
    - `dpkg-deb -Zgzip --build smip-mqtt-gateway/`

## Updating the MQTT Services

- Build project: [https://github.com/AxiomSystems/SmipMqttService](https://github.com/AxiomSystems/SmipMqttService)
- Copy the output to `opt/thinkiq/services/SmipMqttService`
- Build project: [https://github.com/jwise-mfg/MqttConnectorAdapter](https://github.com/jwise-mfg/MqttConnectorAdapter)
- Copy the output to `opt/thinkiq/services/SouthBridgeService`
- Re-build the installer as above