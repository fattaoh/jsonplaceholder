import 'package:flutter/material.dart';
import 'package:jsonplaceholder/model/photos.dart';

class PhotoWidget extends StatelessWidget {
  final Photos photos;

  const PhotoWidget({
    super.key,
    required this.photos,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(photos.title),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            photos.thumbnailUrl,
            fit: BoxFit.cover,
            width: 64,
            height: 64,
          ),
        ),
        subtitle: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(9)
              ),
              child: Padding(padding: const EdgeInsets.all(4.0),
                  child: Text('ID #${photos.id}', style: const TextStyle(fontWeight: FontWeight.bold),),
              ),
            ),
              const SizedBox(width: 10,),
            Text('Album ID#${photos.albumId}'),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios_outlined),
        onTap: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(photos.title),
                content: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    photos.url,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => SizedBox(
                      width: 100,
                      height: 100,
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        size: 100,
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Close'),
                  ),
                ],
              ),
          );
        },
      ),
    );
  }
}
