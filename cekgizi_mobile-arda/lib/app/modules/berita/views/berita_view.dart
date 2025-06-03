import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cekgizi_mobile/tema.dart'; // Pastikan path ini sesuai
import '../controllers/berita_controller.dart';
import 'package:cekgizi_mobile/tema.dart'; // Pastikan path sudah benar

class BeritaView extends GetView<BeritaController> {
  const BeritaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warnaPutih,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          backgroundColor: warnaPutih,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: warnaBiru,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: warnaPutih),
                onPressed: () => Get.back(),
              ),
            ),
          ),
          centerTitle: true,
          title: Column(
            children: [
              Text(
                'Berita',
                style: hitamStyle.copyWith(
                  fontWeight: bold,
                  fontSize: 20,
                ),
              ),
              Divider(
                color: warnaHitam,
                height: 10,
                thickness: 1,
              ),
            ],
          ),
          automaticallyImplyLeading: false,
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator(color: warnaBiru));
        }
        if (controller.beritaList.isEmpty) {
          return Center(child: Text('Tidak ada berita.', style: hitamStyle));
        }
        return ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          itemCount: controller.beritaList.length,
          itemBuilder: (context, index) {
            final news = controller.beritaList[index];
            return Container(
              margin: EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: warnaAbu2),
                color: warnaPutih,
                boxShadow: [
                  BoxShadow(
                    color: warnaAbu2,
                    blurRadius: 4,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(12),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: news.imageUrl.isNotEmpty
                      ? Image.network(news.imageUrl, width: 48, height: 48, fit: BoxFit.cover)
                      : Container(
                          width: 48,
                          height: 48,
                          color: warnaAbu2,
                        ),
                ),
                title: Text(
                  news.title,
                  style: hitamStyle.copyWith(
                    fontWeight: bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  news.description,
                  style: hitamStyle.copyWith(
                    fontWeight: regular,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () {
                  // TODO: bisa diarahkan ke detail/news url
                  Get.snackbar('Berita', 'Klik ke detail atau buka link.');
                },
              ),
            );
          },
        );
      }),
    );
  }
}
