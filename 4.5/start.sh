#!/bin/bash

# We just start the kibana service and then leave consul-template running on the foreground.
# Here we use the CONSUL_URL environment variable that we defined before. Consul template
# expects to find a kibana.ctmpl file in /templates. This is the template that we would
# mount as a volume from our host. The result is then placed in /opt/kibana/config/kibana.yml
# where kibana will be able to read from.

# Note: & added so that kibana runs in a separate process and consul-template runs in this process
kibana &
consul-template -consul-addr=$CONSUL_URL -template="/templates/kibana.ctmpl:/opt/kibana/config/kibana.yml:service kibana restart"