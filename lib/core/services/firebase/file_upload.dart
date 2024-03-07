import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mindintrest_user/core/exception/failure.dart';

class FileUploader {
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  /// Uploads files to the FirebaseStorage and returns
  /// the file ids and FirebaseStorage paths
  Future<Either<String, FileUploadFailure>> uploadFile(
    File file,
    String fileName,
  ) async {
    final userRef = FirebaseStorage.instance.ref('users/$userId/$fileName.png');

    try {
      final task = await userRef.putFile(file);

      if (task.state == TaskState.success) {
        return Left(await task.ref.getDownloadURL());
      } else {
        return Right(FileUploadFailure('File upload failed'));
      }
    } on FirebaseException catch (e, _) {
      return Right(FileUploadFailure(e.message!));
    } catch (e) {
      return Right(FileUploadFailure('Reselect picture and try again'));
    }
  }
}
