GeoSample-iOS
=============

This is a bare-bones sample application that shows you how to create a user account then create checkins based on the user's current location. These checkins are stored within [Kii Cloud](http://developer.kii.com) and retrieved each time the user logs in. Checkins are available across devices, and this sample can easily be extended with further functionality, social layers, and better UX to become a full-fledged application.

This sample is built on top of [Kii Cloud](http://developer.kii.com) so you don't need to do any backend setup or coding, you can just plug in the easy-to-use Kii SDK and you're up and running!

#### KiiToolkit
This sample also utilizes the open-source [KiiToolkit](https://github.com/KiiPlatform/KiiToolkit-iOS) library for even faster development. This provides a login view that plugs directly into Kii Cloud, as well as some UI elements that allos us to create this entire app in a single class with only a few added methods!

## Getting Started
If you want to get up and running quickly, simply:

* Check out the code
* Plug in your [Kii Cloud](http://developer.kii.com) App ID and App Key to the method `beginWithID:andKey:` in **AppDelegate.m**
  * _To get an App ID and App Key, see: [Registering your App on the Kii Developer Portal](http://documentation.kii.com/en/starts/ios/) (it's free!)_
* Build & run!

## Next Steps

This is a great way to get your new geolocation app up and running even faster with [Kii Cloud](http://developer.kii.com), so have fun building, feel free to contribute and let us know what you think!
