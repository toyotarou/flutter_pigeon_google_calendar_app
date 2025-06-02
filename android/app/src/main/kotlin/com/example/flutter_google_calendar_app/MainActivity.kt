package com.example.flutter_google_calendar_app

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity(){
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        CalendarApi.setUp(flutterEngine.dartExecutor.binaryMessenger, CalendarApiImpl(this))
    }
}
