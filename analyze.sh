#!/bin/bash

WORKSPACE="ShowTracker"
SCHEME="ShowTracker"
LOG_FILE=$(mktemp)

xcodebuild -workspace "$WORKSPACE.xcworkspace" -scheme "$SCHEME" > "$LOG_FILE"
swiftlint analyze --compiler-log-path "$LOG_FILE"

rm "$LOG_FILE"
