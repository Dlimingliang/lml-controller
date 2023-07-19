#!/usr/bin/env bash
# code generate old version

#set -o errexit
#set -o nounset
#set -o pipefail
#
#SCRIPT_ROOT=$(dirname "${BASH_SOURCE[0]}")/..
#bash "${GOPATH}"/src/github.com/Dlimingliang/code-generator/generate-groups.sh "deepcopy,client,lister,informer" \
#github.com/Dlimingliang/lml-controller/pkg/generated github.com/Dlimingliang/lml-controller/pkg/apis \
#lmlcontroller:v1 \
#--output-base "${SCRIPT_ROOT}/../../.." \
#--go-header-file "${SCRIPT_ROOT}"/hack/boilerplate.go.txt

# code generate new version
# generate the code with:
# --input-pkg-root    以go.mod 里面的module开头, 加pkg目录
# --output-base       设置到src的上一级, output-base + src + 其他俩个pkg将组成目录
# --output-pkg-root   作用配置生成目录, 以go.mod 里面的module开头, 加要生成的目录

set -o errexit
set -o nounset
set -o pipefail

SCRIPT_ROOT=$(dirname "${BASH_SOURCE[0]}")/..
source "${GOPATH}/src/github.com/Dlimingliang/code-generator/kube_codegen.sh"

# deepcopy
kube::codegen::gen_helpers \
    --input-pkg-root github.com/Dlimingliang/lml-controller/pkg/apis \
    --output-base "$(dirname "${BASH_SOURCE[0]}")/../../../.." \
    --boilerplate "${SCRIPT_ROOT}/hack/boilerplate.go.txt"

# clientset、infomers、listers
kube::codegen::gen_client \
    --with-watch \
    --input-pkg-root github.com/Dlimingliang/lml-controller/pkg/apis \
    --output-pkg-root github.com/Dlimingliang/lml-controller/pkg/generated \
    --output-base "$(dirname "${BASH_SOURCE[0]}")/../../../.." \
    --boilerplate "${SCRIPT_ROOT}/hack/boilerplate.go.txt"