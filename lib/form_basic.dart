import 'package:flutter/material.dart';

class MyApp5 extends StatelessWidget {
  const MyApp5({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FormBasic(),
    );
  }
}

class FormBasic extends StatefulWidget {
  const FormBasic({Key? key}) : super(key: key);

  @override
  _FormBasicState createState() => _FormBasicState();
}

class _FormBasicState extends State<FormBasic> {
  var fKey = GlobalKey<FormState>();
  var txtMatKhau = TextEditingController();
  var txtTaiKhoan = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Đăng nhập hệ thống"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: fKey,
          child: Column(
            children: [
              TextFormField(
                controller: txtTaiKhoan,

                validator: (value){
                  if ( value == null || value.isEmpty){
                    return "Vui lòng nhập tài khoản";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "Nhập tên đăng nhập",
                  labelText: "Tên đăng nhập (*)"
                ),
              ),
              TextFormField(
                controller: txtMatKhau,
                validator: (value){
                  if ( value == null || value.isEmpty){
                    return "Vui lòng nhập mật khẩu";
                  }
                  return null;
                },
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "nhập mật mật khẩu",
                  labelText: "Mật khẫu (*)"
                ),
              ),
              ElevatedButton(
                  onPressed: (){
                    if (fKey.currentState!.validate()){
                      print("not ok");
                    }

                  },
                  child: Text("Đăng nhập")),
            ],
          ),
        ),
      ),
    );
  }
}

