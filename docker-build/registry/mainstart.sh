#!/bin/sh
# Copyright 2019 Nokia
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

file_names="${REGISTRY_CONFIG}"
/usr/bin/wait-for-files "${file_names}"
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

ip_addr=`ip -4 addr list ${INTERFACE_NAME} | awk '$1 ~ /^inet/ { sub("/.*", "", $2); print $2 }'`;
export REGISTRY_HTTP_ADDR=${ip_addr}:${REGISTRY_PORT}

registry serve ${REGISTRY_CONFIG};
