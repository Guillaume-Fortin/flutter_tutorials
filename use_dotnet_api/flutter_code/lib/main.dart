import 'dart:ffi';

import 'package:dotnet_in_flutter_app/my_dotnet_api.dart';
import 'package:ffi/ffi.dart';
import 'package:flutter/material.dart';
import 'package:win32/win32.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Use DotNet Api Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Use DotNet Api Demo Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _addResult = 0;
  String? _echoText;
  DateTime? _date;

  @override
  void initState() {
    super.initState();

    _callDotNetApi();
  }

  @override
  Widget build(BuildContext context) {
    final date = _date;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (date != null)
              Text(
                'Call API with Date: $_date',
              ),
            if (date != null)
              Text(
                'Result fo Add function:\n${date.minute} + ${date.second}=$_addResult',
                style: Theme.of(context).textTheme.headline4,
              ),
            if (date != null)
              Text(
                'Result for Echo function:\n$_echoText',
                style: Theme.of(context).textTheme.headline4,
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _callDotNetApi,
        tooltip: 'Call DotNet Api',
        child: const Icon(Icons.call),
      ),
    );
  }

  void _callDotNetApi() {
    MyDotNetApi? myDotNetApi;

    // ignore: prefer_final_locals
    var hr = CoInitializeEx(
        nullptr, COINIT_APARTMENTTHREADED | COINIT_DISABLE_OLE1DDE);
    if (SUCCEEDED(hr)) {
      try {
        myDotNetApi = MyDotNetApi.createInstance();
      } catch (e) {
        debugPrint(e.toString());
      }
    }

    if (myDotNetApi != null) {
      DateTime date = DateTime.now();

      final addResultPtr = calloc<Int32>();

      myDotNetApi.add(date.minute, date.second, addResultPtr);

      final addResult = addResultPtr.value;

      free(addResultPtr);

      final textPtr = "Hello $date".toNativeUtf16();

      Pointer<Pointer<Utf16>> echoTextPtrPtr = calloc<Pointer<Utf16>>();

      myDotNetApi.echo(textPtr, echoTextPtrPtr);

      final String echoText = echoTextPtrPtr.value.toDartString();
      setState(() {
        _date = date;
        _addResult = addResult;
        _echoText = echoText;
      });

      free(textPtr);
      free(echoTextPtrPtr.value);
      free(echoTextPtrPtr);

      myDotNetApi.Release();
      myDotNetApi = null;
    }

    if (SUCCEEDED(hr)) {
      CoUninitialize();
    }
  }
}
