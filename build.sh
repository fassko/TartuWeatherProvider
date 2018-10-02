#!/bin/bash

set -o pipefail && xcodebuild -project TartuWeatherProvider.xcodeproj -scheme TartuWeatherProvider-iOS -destination 'platform=iOS Simulator,name=iPhone X' CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO clean test build | xcpretty
set -o pipefail && xcodebuild -project TartuWeatherProvider.xcodeproj -scheme TartuWeatherProvider-tvOS CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO clean build | xcpretty
set -o pipefail && xcodebuild -project TartuWeatherProvider.xcodeproj -scheme TartuWeatherProvider-watchOS CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO clean build | xcpretty
set -o pipefail && xcodebuild -project TartuWeatherProvider.xcodeproj -scheme TartuWeatherProvider-macOS CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO clean build | xcpretty
