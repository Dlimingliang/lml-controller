#!/usr/bin/env bash

# Copyright 2017 The Kubernetes Authors.
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

#set -o errexit
#set -o nounset
#set -o pipefail
#
#SCRIPT_ROOT=$(dirname "${BASH_SOURCE[0]}")/..
#bash "${GOPATH}"/src/github.com/Dlimingliang/code-generator/generate-groups.sh "deepcopy,client,lister,informer" \
#github.com/Dlimingliang/lml-controller/pkg/generated github.com/Dlimingliang/lml-controller/pkg/apis \
#example.com:v1 \
#--output-base "${SCRIPT_ROOT}/../../.." \
#--go-header-file "${SCRIPT_ROOT}"/hack/boilerplate.go.txt


set -o errexit
set -o nounset
set -o pipefail

SCRIPT_ROOT=$(dirname "${BASH_SOURCE[0]}")/..
source "${GOPATH}/src/github.com/Dlimingliang/code-generator/kube_codegen.sh"

kube::codegen::gen_helpers \
    # 与go.mod 里面的module相同
    --input-pkg-root github.com/Dlimingliang/lml-controller/pkg/apis \
    # 设置到src的上一级,连接--input-pkg-root 组成目录
    --output-base "$(dirname "${BASH_SOURCE[0]}")/../../../.." \
    --boilerplate "${SCRIPT_ROOT}/hack/boilerplate.go.txt"

kube::codegen::gen_client \
    --with-watch \
    # 与go.mod 里面的module相同
    --input-pkg-root github.com/Dlimingliang/lml-controller/pkg/apis \
    # 配置生成目录,也以go.mod开头
    --output-pkg-root github.com/Dlimingliang/lml-controller/pkg/generated \
     # 设置到src的上一级,连接--input-pkg-root 组成目录
    --output-base "$(dirname "${BASH_SOURCE[0]}")/../../../.." \
    --boilerplate "${SCRIPT_ROOT}/hack/boilerplate.go.txt"