package com.flutereshare.flutereshare;

import android.content.BroadcastReceiver;
import android.os.Bundle;
import android.os.Environment;
import android.util.Log;

import com.eshare.api.EShareAPI;
import com.eshare.api.bean.Device;
import com.eshare.api.callback.ConnectDeviceCallback;
import com.eshare.api.callback.FindDeviceCallback;
import com.eshare.api.utils.EShareException;
import com.google.gson.Gson;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.JSONUtil;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  private final String GET_DEVICE_CHANNEL="GET_DEVICE_CHANNEL";
  private final String GET_DEVICE_CHANNEL_TRY_TO_CONNECT="GET_DEVICE_CHANNEL_TRYTOCONNECT";
  private final String GET_DEVICE_CHANNEL_FILE="GET_DEVICE_CHANNEL_FILE";
  private final String SHOWFILE="SHOWFILE";
  private ExecutorService pool  = Executors.newFixedThreadPool(3);
  private List<Entity> files = new ArrayList<>();
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    new MethodChannel(getFlutterView(), GET_DEVICE_CHANNEL).setMethodCallHandler(
            new MethodCallHandler() {
              @Override
              public void onMethodCall(MethodCall call, final MethodChannel.Result result) {
                switch (call.method){
                  case "GET_DEVICE_CHANNEL_Fx":
                    getdevice(result);
                    break;
                  case "GET_DEVICE_CHANNEL_TRYTOCONNECT":
                    get_device_channel_trytoconnect(call,result);
                    break;
                  case "GET_DEVICE_CHANNEL_FILE":
                    get_file_channel(call,result);
                    break;
                  case "SHOWFILE":
                    showfile(call,result);
                    break;
                }

              }
            }
    );
  }

  private void getdevice(final MethodChannel.Result result) {
    pool.execute(new Runnable() {
      @Override
      public void run() {
        EShareAPI.init(MainActivity.this).device().findDevices(new FindDeviceCallback() {
          @Override
          public void onSuccess(final List<Device> list) {
            Log.i(Thread.currentThread().getName(), list.toString());
            result.success(new Gson().toJson(list));
          }

          @Override
          public void onError(EShareException e) {

          }
        });
      }
    });

  }
  private void get_device_channel_trytoconnect(final MethodCall call,final MethodChannel.Result result) {
    pool.execute(new Runnable() {
      @Override
      public void run() {
        Log.i("MainActivity_",call.argument("date").toString());
        try {
          Device device = new  Gson().fromJson(call.argument("date").toString(),Device.class);
          EShareAPI.init(MainActivity.this).device().connectDevice(device, new ConnectDeviceCallback() {
            @Override
            public void onSuccess(Device device) {
              result.success("ok");
            }

            @Override
            public void onError(EShareException e) {

            }
          });
        } catch (Exception e) {
          e.printStackTrace();
        }
      }
    });

  }
  private void showfile(final MethodCall call,final MethodChannel.Result result) {
    pool.execute(new Runnable() {
      @Override
      public void run() {
        Log.i("MainActivity_",call.argument("date").toString());
        String path = call.argument("date").toString();
        try {
          EShareAPI.init(MainActivity.this).media().openFile(new File(path));
        } catch (Exception e) {
          e.printStackTrace();
        }
      }
    });

  }
  private void get_file_channel(final MethodCall call,final MethodChannel.Result result) {
    files.clear();
    pool.execute(new Runnable() {
      @Override
      public void run() {
        Log.i("MainActivity_",call.argument("date").toString());
        final String type = call.argument("date").toString();
        try {
          pool.execute(new Runnable() {
            @Override
            public void run() {
              try {
                File file = new File(Environment.getExternalStorageDirectory().getPath()+"/test");
                if (file!=null){
                  File[] fileList = file.listFiles();
                  for (File f:fileList) {
                    if (f.getName().endsWith(type)){
                      Entity entity = new Entity();
                      entity.setName(f.getName());
                      entity.setPath(f.getPath());
                      files.add(entity);
                      Log.i(MainActivity.class.getName(),f.toString());
                    }
                  }
                  result.success(new Gson().toJson(files));
                }
              } catch (Exception e) {
                e.printStackTrace();
              }

            }
          });
        } catch (Exception e) {
          e.printStackTrace();
        }
      }
    });

  }
//
//    new EventChannel(getFlutterView(), GET_DEVICE_CHANNEL).setStreamHandler(
//            new EventChannel.StreamHandler() {
//              @Override
//              public void onListen(Object arguments,final EventChannel.EventSink events) {
//                EShareAPI.init(MainActivity.this).device().findDevices(new FindDeviceCallback() {
//                  @Override
//                  public void onSuccess(List<Device> list) {
//                    Log.d("MainActivity", list.toString());
//                    events.success(new Gson().toJson(list));
//                  }
//
//                  @Override
//                  public void onError(EShareException e) {
//                    events.error(e.getMessage(),"",null);
//                  }
//                });
//              }
//
//              @Override
//              public void onCancel(Object arguments) {
//
//              }
//            }
//    );
}
