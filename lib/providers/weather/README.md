## About the provider structure

The state file will be a part file of the provider file.

When creating weather related state and ChangeNotifier,create a weather folder underthe providers folder and create weather_state.dart and weather_provider.dart files under the weather folder.

And the weather_state.dart is a part file of weather_provider.dart.

At this time weather_state.dart uses 'part of' directive to indicate that it is a part of weather_provider.dart, and weather_provider.dart uses part directive to indicate that weather_state.dart is its part.

The point to note is that the packages  required for the part file cannot be imported from the part file, but must be imported from the 'part of' file.