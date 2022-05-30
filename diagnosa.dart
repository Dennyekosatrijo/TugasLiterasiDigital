import 'dart:convert';
import 'dart:developer';

//updatelagidanlagi

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:tea_solutions/models/hasilakhirdiagnosa.dart';
import 'package:tea_solutions/models/listgejala.dart';
import 'package:tea_solutions/providers/diagnosa_provider.dart';
import 'package:tea_solutions/service/apidiagnosa.dart';
import 'package:tea_solutions/service/apiteh.dart';
import 'package:tea_solutions/service/apiurl.dart';
import 'package:tea_solutions/tampilan_awal/beranda.dart';
import 'package:tea_solutions/tampilan_diagnosa/card_gejala.dart';
import 'package:tea_solutions/tampilan_diagnosa/hasildiagnosa.dart';
import 'package:tea_solutions/template/custome_template.dart';

class DiagnosaPage extends StatefulWidget {
  const DiagnosaPage({Key? key}) : super(key: key);

  @override
  State<DiagnosaPage> createState() => _DiagnosaPageState();
}

class _DiagnosaPageState extends State<DiagnosaPage> {
  final ApiTeh api = ApiTeh();
  final ApiDiagnosa apiDiagnosa = ApiDiagnosa();

  List<Gejala> listGejala = [];

  late DiagnosaProvider hasil;

  @override
  void dispose() {
    hasil.clearlist();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    hasil = Provider.of<DiagnosaProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onTap: () => {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) {
                return const Beranda();
              }),
            ),
          },
        ),
        title: const Text(
          'Diagnosis Hama Tanaman Teh',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: bggreen,
      ),
      backgroundColor: bgwhite,
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            height: 250,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(70.0),
                bottomLeft: Radius.circular(70.0),
              ),
              boxShadow: const [
                BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2.0,
                    offset: Offset(2.0, 2.0))
              ],
              color: bggreen2,
            ),
            child: Column(
              children: [
                Text(
                  'Pilih gejala yang dimana tanaman teh anda sedang terserang dan juga anda harus mengisikan nilai bobot untuk menentukan keyakinan anda terhadap gejala yang dipilih berdasarkan skala berikut ini:',
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.nunito(fontSize: 14, color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 25,
                                height: 25,
                                decoration: const ShapeDecoration(
                                  shape: CircleBorder(
                                    side: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  color: Colors.transparent,
                                ),
                                child: const Center(
                                  child: Text(
                                    '1',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Sedikit Yakin',
                                style: GoogleFonts.poppins(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Container(
                                width: 25,
                                height: 25,
                                decoration: const ShapeDecoration(
                                  shape: CircleBorder(
                                    side: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  color: Colors.transparent,
                                ),
                                child: const Center(
                                  child: Text(
                                    '2',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Cukup Yakin',
                                style: GoogleFonts.poppins(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Container(
                                width: 25,
                                height: 25,
                                decoration: const ShapeDecoration(
                                  shape: CircleBorder(
                                    side: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  color: Colors.transparent,
                                ),
                                child: const Center(
                                  child: Text(
                                    '3',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Yakin',
                                style: GoogleFonts.poppins(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Container(
                                width: 25,
                                height: 25,
                                decoration: const ShapeDecoration(
                                  shape: CircleBorder(
                                    side: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  color: Colors.transparent,
                                ),
                                child: const Center(
                                  child: Text(
                                    '4',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Sangat Yakin',
                                style: GoogleFonts.poppins(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          FutureBuilder<List<Gejala>?>(
              future: api.getgejala(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final gejala = snapshot.data![index];

                        return CardGejala(gejala: gejala);
                      });
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      primary: bggreen2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                    onPressed: () async {
                      final jsonJawaban = jsonEncode(hasil.listjawaban);
                      final api = ApiDiagnosa();

                      final result = await api.createDiagnosa(jsonJawaban);

                      if (result == null) {
                        print("response cek hasil empty");
                      } else {
                        hasil.saveHasil(result);

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const HasilDiagnosa();
                            },
                          ),
                        );
                      }
                      // bool cekHasil =
                      // createsDiagnosa(jsonJawaban);

                      // if (jsonJawaban.isEmpty) {
                      //   print("response cek hasil empty: $cekHasil");
                      // } else {
                      //   print("response cek hasil : $cekHasil");
                      // }

                      // if (cekHasil) {
                      //   Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) {
                      //         return const HasilDiagnosaPage();
                      //       },
                      //     ),
                      //   );
                      // }
                    },
                    child: Text(
                      'Mulai Diagnosa',
                      style: GoogleFonts.nunito(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void createsDiagnosa(String jsonjawaban) async {
    final String apiUrl = "$api_url/Diagnosa";
    // List<String> listJawaban = [
    //   "${diagnosa.kodeGejala}_${diagnosa.kodeValue}",
    // ];

    // print("jsonJawaban = $jsonjawaban");

    try {
      final response = await post(
        Uri.parse(apiUrl),
        body: {'list_jawaban': jsonjawaban},
      );

      // print(response.statusCode);

      if (response.statusCode == 200) {
        final hasil = json.decode(response.body);
        final dataNya2 = hasil!;
        print("hasilAkhirData = $dataNya2");

        final hasilAkhir = HasilAkhirDiagnosa.fromJson(hasil!);
        final dataNya = hasilAkhir.data;
        print("hasilAkhir = $dataNya");

        // return dataHasil.data;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const HasilDiagnosa();
            },
          ),
        );
      } else {
        print("error ya");
      }

      // log(response.body);
    } catch (e) {
      // Fluttertoast.showToast(msg: e.toString());
      log(e.toString());
    }
  }
}
