package com.example.native_channel_example

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.net.ConnectivityManager
import android.util.Log
import android.widget.Toast

class NetworkChangeReceiver : BroadcastReceiver() {

    override fun onReceive(context: Context, intent: Intent) {
        val connectivityManager = context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
        val activeNetwork = connectivityManager.activeNetworkInfo
        val isConnected = activeNetwork != null && activeNetwork.isConnectedOrConnecting
        if (isConnected) {
            val networkType = activeNetwork?.type
            if (networkType == ConnectivityManager.TYPE_WIFI) {
                Log.d("Network Available", "WIFI")
                Toast.makeText(context, "Wifi enabled", Toast.LENGTH_SHORT).show()
            } else if (networkType == ConnectivityManager.TYPE_MOBILE) {
                Log.d("Network Available", "WIFI")

                Toast.makeText(context, "Wifi disabled", Toast.LENGTH_SHORT).show()
            }
        } else {
            Log.d("Network Available", "WIFI")

            Toast.makeText(context, "Network Available", Toast.LENGTH_SHORT).show()
        }
    }
}