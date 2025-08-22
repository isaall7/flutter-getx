import 'package:ade_getx/app/modules/formulir/controllers/formulir_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_core/get_core.dart';

class FormulirOutputView extends StatelessWidget {
   FormulirOutputView({super.key});

  final FormulirController formulir = Get.find<FormulirController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Formulir Output'), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Nama: ${formulir.nameController.text}"),
              SizedBox(height: 10),
              Text("Kursus: ${formulir.selectedContent.value}"),
              SizedBox(height: 10),
              Text("Tanggal Lahir: ${formulir.formattedDate}"),
              SizedBox(height: 10),
              Text("Gender: ${formulir.gender.value}"),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  formulir.clearForm();
                  Get.off(() => FormulirOutputView());
                },
                child: Text("Kembali"),
              ),
            ],
          )
        ),
      ),
    );
  }
  
}