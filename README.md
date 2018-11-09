# cocoapods-repo-update

cocoapods-repo-update is a CocoaPods plugin that checks your dependencies when you run `pod install` and updates the local specs repositories if needed.

## Background

CocoaPods maintains a local mirror of the master specs repository at `~/.cocoapods/repos/master`. When you run `pod install`, CocoaPods checks your local mirror for all the specs you want and fetches them.

As of CocoaPods 1.0, `pod install` does not update the master specs repo every time it is run. This is because CocoaPods was [hammering Github](https://github.com/CocoaPods/CocoaPods/issues/4989#issuecomment-193772935) with this behavior. Now the specs repo must be explicitly updated with `pod repo update` or `pod install --repo-update`.

[In some cases](https://github.com/CocoaPods/CocoaPods/issues/6033), this change was a bit of an overcorrection. It can be particularly inconvenient when running changes on CI.

This plugin checks if your CocoaPods specs repo needs to be updated when `pod install` is run and updates it if needed. This eliminates the need to run `pod repo update` or `pod install --repo-update` when you change a pod.

## Installation

Install with `gem install`:

    $ gem install cocoapods-repo-update

Or add cocoapods-repo-update to your `Gemfile`:

    gem 'cocoapods-repo-update'

## Usage

cocoapods-repo-update is used by adding it to your `Podfile` like this:

```
source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '11.0'
plugin 'cocoapods-repo-update'

target :MyTarget do
  # Dependencies here
end
```

## Development

Source for the plugin is in `lib/`. Tests are run like this:

```
$ bundle install
$ bundle exec rspec spec/
```
