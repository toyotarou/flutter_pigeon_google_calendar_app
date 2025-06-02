package com.example.flutter_google_calendar_app

import android.os.Build

import android.content.Context
import android.database.Cursor
import android.provider.CalendarContract

import android.content.ContentValues
import java.util.TimeZone
import android.util.Log

class CalendarApiImpl(private val context: Context) : CalendarApi {

    ///
    override fun getPlatformVersion(): String {

        logAvailableCalendars()

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

    ///
    private fun logAvailableCalendars() {
        val projection = arrayOf(
            CalendarContract.Calendars._ID,
            CalendarContract.Calendars.CALENDAR_DISPLAY_NAME,
            CalendarContract.Calendars.ACCOUNT_NAME
        )

        val cursor = context.contentResolver.query(
            CalendarContract.Calendars.CONTENT_URI,
            projection,
            null,
            null,
            null
        )

        cursor?.use {
            while (it.moveToNext()) {
                val id = it.getLong(it.getColumnIndex(CalendarContract.Calendars._ID))
                val name = it.getString(it.getColumnIndex(CalendarContract.Calendars.CALENDAR_DISPLAY_NAME))
                val account = it.getString(it.getColumnIndex(CalendarContract.Calendars.ACCOUNT_NAME))
                Log.d("CalendarList", "使用可能: ID=$id, Name=$name, Account=$account")
            }
        }
    }

    ///
    private fun getFirstCalendarId(): Long? {
        val projection = arrayOf(
            CalendarContract.Calendars._ID,
            CalendarContract.Calendars.CALENDAR_DISPLAY_NAME,
            CalendarContract.Calendars.ACCOUNT_NAME,
            CalendarContract.Calendars.CALENDAR_ACCESS_LEVEL
        )

        val selection = "${CalendarContract.Calendars.VISIBLE} = 1 AND " +
                "${CalendarContract.Calendars.CALENDAR_ACCESS_LEVEL} >= ${CalendarContract.Calendars.CAL_ACCESS_OWNER}"

        val cursor = context.contentResolver.query(
            CalendarContract.Calendars.CONTENT_URI,
            projection,
            selection,
            null,
            null
        )

        cursor?.use {
            while (it.moveToNext()) {
                val id = it.getLong(it.getColumnIndex(CalendarContract.Calendars._ID))
                val name = it.getString(it.getColumnIndex(CalendarContract.Calendars.CALENDAR_DISPLAY_NAME))
                val account = it.getString(it.getColumnIndex(CalendarContract.Calendars.ACCOUNT_NAME))
                Log.d("CalendarList", "選択されたカレンダー: ID=$id, Name=$name, Account=$account")
                return id
            }
        }

        return null
    }

    ///
    override fun addCalendarEvent(event: CalendarEvent) {
        val calendarId = getFirstCalendarId()
        if (calendarId == null) {
            Log.e("CalendarAdd", "カレンダーIDが取得できませんでした")
            return
        }

        Log.d("CalendarAdd", "イベント追加処理開始: ${event.title}")

        val values = ContentValues().apply {
            put(CalendarContract.Events.DTSTART, event.startTimeMillis)
            put(CalendarContract.Events.DTEND, event.endTimeMillis)
            put(CalendarContract.Events.TITLE, event.title)
            put(CalendarContract.Events.DESCRIPTION, event.description)
            put(CalendarContract.Events.EVENT_LOCATION, event.location)
            put(CalendarContract.Events.CALENDAR_ID, calendarId)
            put(CalendarContract.Events.EVENT_TIMEZONE, TimeZone.getDefault().id)
        }

        val uri = context.contentResolver.insert(CalendarContract.Events.CONTENT_URI, values)
        Log.d("CalendarAdd", "イベントを追加しました: URI=$uri")
    }

}
