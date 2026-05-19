import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/destinasi_provider.dart';
import '../providers/auth_provider.dart';
import '../models/destinasi.dart';

class KelolaDestinasiAdmin extends StatefulWidget {
  @override
  State<KelolaDestinasiAdmin> createState() =>
      _KelolaDestinasiAdminState();
}

class _KelolaDestinasiAdminState
    extends State<KelolaDestinasiAdmin> {

  void _tambah() {
    final adminId =
        Provider.of<AuthProvider>(
          context,
          listen: false,
        ).pengguna?.id ??
        'admin_system';

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          'Tambah Destinasi Baru',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: SingleChildScrollView(
          child: _FormDestinasiAdmin(
            adminId: adminId,
            onSave: () => setState(() {}),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final destProvider =
        Provider.of<DestinasiProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),

      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        titleSpacing: 16,

        title: const Text(
          'Kelola Destinasi',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),

        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,

        iconTheme: const IconThemeData(
          color: Colors.black,
        ),

        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFFE5E7EB),
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _tambah,
        backgroundColor: const Color(0xFF4A709C),
        elevation: 2,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),

      body: destProvider.semuaDestinasi.isEmpty
          ? const Center(
              child: Text(
                'Belum ada data destinasi.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount:
                  destProvider.semuaDestinasi.length,
              itemBuilder: (ctx, i) {
                final d =
                    destProvider.semuaDestinasi[i];

                return Container(
                  margin:
                      const EdgeInsets.only(bottom: 14),
                  padding: const EdgeInsets.all(14),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.grey.shade200,
                    ),
                  ),

                  child: Row(
                    children: [

                      Container(
                        width: 55,
                        height: 55,

                        decoration: BoxDecoration(
                          color:
                              const Color(0xFFF1F5F9),
                          borderRadius:
                              BorderRadius.circular(12),
                        ),

                        child: const Icon(
                          Icons.landscape_rounded,
                          color: Color(0xFF4A709C),
                          size: 30,
                        ),
                      ),

                      const SizedBox(width: 14),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [

                            Text(
                              d.nama,
                              maxLines: 1,
                              overflow:
                                  TextOverflow.ellipsis,

                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight:
                                    FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),

                            const SizedBox(height: 5),

                            Text(
                              'ID Pemilik: ${d.pemilikId}',

                              style: TextStyle(
                                fontSize: 12,
                                color:
                                    Colors.grey.shade600,
                              ),
                            ),

                            const SizedBox(height: 5),

                            Text(
                              'Rp ${d.harga}',

                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight:
                                    FontWeight.w600,
                                color:
                                    Color(0xFF4A709C),
                              ),
                            ),
                          ],
                        ),
                      ),

                      IconButton(
                        onPressed: () {
                          destProvider
                              .hapusDestinasi(d.id);
                        },

                        icon: const Icon(
                          Icons.delete_outline_rounded,
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

class _FormDestinasiAdmin extends StatefulWidget {
  final String adminId;
  final VoidCallback onSave;

  const _FormDestinasiAdmin({
    required this.adminId,
    required this.onSave,
  });

  @override
  State<_FormDestinasiAdmin> createState() =>
      __FormDestinasiAdminState();
}

class __FormDestinasiAdminState
    extends State<_FormDestinasiAdmin> {

  final _nama = TextEditingController();
  final _desk = TextEditingController();
  final _harga = TextEditingController();
  final _fasilitas = TextEditingController();

  @override
  void dispose() {
    _nama.dispose();
    _desk.dispose();
    _harga.dispose();
    _fasilitas.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,

      children: [

        TextField(
          controller: _nama,

          decoration: const InputDecoration(
            labelText: 'Nama Destinasi',
          ),
        ),

        const SizedBox(height: 10),

        TextField(
          controller: _desk,

          decoration: const InputDecoration(
            labelText: 'Deskripsi',
          ),
        ),

        const SizedBox(height: 10),

        TextField(
          controller: _harga,
          keyboardType: TextInputType.number,

          decoration: const InputDecoration(
            labelText: 'Harga',
          ),
        ),

        const SizedBox(height: 10),

        TextField(
          controller: _fasilitas,

          decoration: const InputDecoration(
            labelText: 'Fasilitas (pisah koma)',
          ),
        ),

        const SizedBox(height: 24),

        SizedBox(
          width: double.infinity,
          height: 48,

          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  const Color(0xFF4A709C),

              elevation: 0,

              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(10),
              ),
            ),

            onPressed: () {

              if (_nama.text.isEmpty ||
                  _harga.text.isEmpty) {
                return;
              }

              final baru = Destinasi(
                id: DateTime.now()
                    .millisecondsSinceEpoch
                    .toString(),

                nama: _nama.text,
                deskripsi: _desk.text,

                harga: double.parse(
                  _harga.text,
                ),

                gambarUrl:
                    'https://picsum.photos/300/200?random=${DateTime.now().millisecondsSinceEpoch}',

                pemilikId: widget.adminId,

                fasilitas:
                    _fasilitas.text.split(','),
              );

              Provider.of<DestinasiProvider>(
                context,
                listen: false,
              ).tambahDestinasi(baru);

              widget.onSave();

              Navigator.pop(context);
            },

            child: const Text(
              'Simpan Destinasi',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
