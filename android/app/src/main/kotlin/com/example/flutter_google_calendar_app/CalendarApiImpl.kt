package com.example.flutter_google_calendar_app

import android.os.Build

import android.content.Context
import android.database.Cursor
import android.provider.CalendarContract

class CalendarApiImpl(private val context: Context) : CalendarApi {

    ///
    override fun getPlatformVersion(): String {
        return "Android ${Build.VERSION.RELEASE}"
    }

    ///
    override fun getCalendarEvents(): List<CalendarEvent> {
        val events = mutableListOf<CalendarEvent>()

        val projection = arrayOf(
            CalendarContract.Events.TITLE,
            CalendarContract.Events.DESCRIPTION,
            CalendarContract.Events.EVENT_LOCATION,
            CalendarContract.Events.DTSTART,
            CalendarContract.Events.DTEND
        )

        val cursor: Cursor? = context.contentResolver.query(
            CalendarContract.Events.CONTENT_URI,
            projection,
            null,
            null,
            "${CalendarContract.Events.DTSTART} ASC"
        )

        cursor?.use {
            val titleIndex = it.getColumnIndex(CalendarContract.Events.TITLE)
            val descIndex = it.getColumnIndex(CalendarContract.Events.DESCRIPTION)
            val locationIndex = it.getColumnIndex(CalendarContract.Events.EVENT_LOCATION)
            val startIndex = it.getColumnIndex(CalendarContract.Events.DTSTART)
            val endIndex = it.getColumnIndex(CalendarContract.Events.DTEND)

            while (it.moveToNext()) {
                val event = CalendarEvent(
                    title = it.getString(titleIndex),
                    description = it.getString(descIndex),
                    location = it.getString(locationIndex),
                    startTimeMillis = it.getLong(startIndex),
                    endTimeMillis = it.getLong(endIndex)
                )
                events.add(event)
            }
        }

        return events
    }

}
