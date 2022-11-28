package com.example.native_channel_example

import android.net.ConnectivityManager
import android.net.Network
import android.net.NetworkCapabilities
import android.os.Build
import android.util.Log
import io.flutter.embedding.android.FlutterActivity

import androidx.annotation.NonNull
import androidx.annotation.RequiresApi
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
    private val deviceChannel = "com.example.native_channel_example/device"
    private val wifiChannel = "com.example.native_channel_example/wifi"

    private class MyCatApi: Pigeon.CatApi{
        override fun getCats(): MutableList<Pigeon.Cat> {
            val cats = mutableListOf<Pigeon.Cat>()
            cats.add(Pigeon.Cat().apply {
                name = "Tom"
                age = 1
            })
            cats.add(Pigeon.Cat().apply {
                name = "Jerry"
                age = 2
            })
            return cats
        }

    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        Pigeon.CatApi.setup(flutterEngine.dartExecutor.binaryMessenger, MyCatApi())

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, deviceChannel).setMethodCallHandler { call, result ->
            Log.i("MainActivity", "call.method: ${call.method}")
            if (call.method == "getDeviceNameFromNative") {
                result.success(android.os.Build.MODEL);
            } else {

                result.notImplemented()
            }
        }

        EventChannel(flutterEngine.dartExecutor.binaryMessenger, wifiChannel).setStreamHandler(
            object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    monitorNetworkStatus(events)
                }

                override fun onCancel(arguments: Any?) {

                }
            }
        )
    }

    private fun monitorNetworkStatus(events: EventChannel.EventSink?) {
        val connectivityManager =
            getSystemService(CONNECTIVITY_SERVICE) as ConnectivityManager


        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            val network = connectivityManager.activeNetwork
            if (network == null) {
                runOnUiThread {
                    events?.success("Lost")
                }
            }
            connectivityManager.registerDefaultNetworkCallback(object :
                ConnectivityManager.NetworkCallback() {
                override fun onAvailable(network: Network) {
                    runOnUiThread {
                        events?.success("Connected")
                    }
                }


                override fun onLost(network: Network) {
                    runOnUiThread {
                        events?.success("Lost")
                    }
                }

            })
        } else {
            runOnUiThread { events?.success("Unknown") }
        }
    }
}
