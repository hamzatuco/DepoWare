// ignore_for_file: file_names
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import '../firebase_options.dart';

class Transakcije extends StatefulWidget {
  const Transakcije({Key? key}) : super(key: key);

  @override
  State<Transakcije> createState() => _TransakcijeState();
}

class _TransakcijeState extends State<Transakcije> {
  String activeCollection = 'ulaz';

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  Future<void> _switchCollection(String collection) async {
    setState(() {
      activeCollection = collection;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Text('TRANSAKCIJE',
                  style: GoogleFonts.poppins(
                    fontSize: 35,
                    fontWeight: FontWeight.w800,
                    color: Colors.deepPurple,
                  )),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 45, 25),
                child: SizedBox(
                  height: 40, //height of button
                  width: 100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.withOpacity(0.5),
                      textStyle: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () => _switchCollection('ulaz'),
                    child: Text('Ulaz'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 25),
                child: SizedBox(
                  height: 40, //height of button
                  width: 100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.withOpacity(0.9),
                      textStyle: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () => _switchCollection('izlaz'),
                    child: Text('Izlaz'),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection(activeCollection)
                  .orderBy('datumDodavanja', descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const Center(child: CircularProgressIndicator());
                  default:
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        Map<String, dynamic> data = snapshot.data!.docs[index]
                            .data()! as Map<String, dynamic>;
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            height: 150,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.deepPurple.withOpacity(0.20),
                                border: Border.all(
                                    color: Colors.deepPurple, width: 1.5),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ListTile(
                                title: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: Text(
                                    data['artikal'],
                                    style: GoogleFonts.archivo(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 12, 0, 0),
                                        child: Text(
                                          'Marka: ${data['marka']}',
                                          style: GoogleFonts.archivo(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 12, 0, 0),
                                        child: activeCollection == 'ulaz'
                                            ? Text(
                                                'Nabavljac: ${data.containsKey('nabavljac') ? data['nabavljac'] : ''}',
                                                style: GoogleFonts.archivo(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )
                                            : activeCollection == 'izlaz'
                                                ? Text(
                                                    'Kupac: ${data.containsKey('kupac') ? data['kupac'] : ''}',
                                                    style: GoogleFonts.archivo(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  )
                                                : Container(),
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 12, 0, 0),
                                        child: activeCollection == 'ulaz'
                                            ? Text(
                                                'Nabavna cijena: ${data.containsKey('nabavnaCijena') ? data['nabavnaCijena'] : ''} KM',
                                                style: GoogleFonts.archivo(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )
                                            : activeCollection == 'izlaz'
                                                ? Text(
                                                    'Prodajna cijena: ${data.containsKey('cijena') ? data['cijena'] : ''} KM',
                                                    style: GoogleFonts.archivo(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  )
                                                : Container(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
