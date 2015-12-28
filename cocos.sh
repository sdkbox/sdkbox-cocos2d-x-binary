#!/bin/bash
CURRENT_DIR=$(cd "$(dirname $0)" && pwd)
${CURRENT_DIR}/tools/cocos2d-console/bin/cocos $*
