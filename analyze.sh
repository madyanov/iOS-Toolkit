#!/bin/bash

WORKSPACE=""
SCHEME=""
LOG_FILE=$(mktemp)

xcodebuild clean build -workspace "$WORKSPACE.xcworkspace" -scheme "$SCHEME" > "$LOG_FILE"
swiftlint analyze --compiler-log-path "$LOG_FILE"

rm "$LOG_FILE"
