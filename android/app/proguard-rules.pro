# Keep Retrofit/OkHttp/Gson if you use them
-keepattributes Signature
-keepattributes *Annotation*
-keep class com.google.gson.** { *; }
-keep class retrofit2.** { *; }
-dontwarn okhttp3.**

