#!/bin/bash

set -o pipefail && xcodebuild -project TartuWeatherProvider.xcodeproj -scheme TartuWeatherProvider -destination 'platform=iOS Simulator,name=iPhone 11 Pro' CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO clean test build | xcpretty
