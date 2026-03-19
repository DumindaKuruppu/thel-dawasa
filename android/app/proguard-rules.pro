# ML Kit Text Recognition rules to ignore missing optional language modules
-dontwarn com.google.mlkit.vision.text.chinese.**
-dontwarn com.google.mlkit.vision.text.devanagari.**
-dontwarn com.google.mlkit.vision.text.japanese.**
-dontwarn com.google.mlkit.vision.text.korean.**

# General ML Kit and GMS rules
-dontwarn com.google.android.gms.internal.**
-keep class com.google.mlkit.** { *; }
-keep interface com.google.mlkit.** { *; }

# If the build still fails with "Missing classes", this broad rule will allow it to proceed.
# R8 often requires this when libraries have optional dependencies.
-ignorewarnings
