import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:setlist/core/db_consts.dart';
import 'package:setlist/core/firebase_utils.dart';
import 'package:setlist/features/dashboard/data/models/band_model.dart';
import 'package:setlist/features/dashboard/domain/entities/band.dart';

abstract class BandRemoteDataSource {
  Future<Band> getBand({required String bandId});

  Future<List<Band>> getBands({required List<String> bandIds});

  Future<String> createBand({required String bandName});
}

class BandRemoteDataSourceImpl extends BandRemoteDataSource {
  BandRemoteDataSourceImpl({
    FirebaseFirestore? firebaseDatabase,
  }) : _db = firebaseDatabase ?? FirebaseFirestore.instance;

  final FirebaseFirestore _db;

  @override
  Future<String> createBand({required String bandName}) {
    final collectionRef = _db.collection(kBandPath);

    final newBand = BandModel(memberships: [], name: bandName);

    return firebaseAdd(collectionRef, newBand.toJson());
  }

  @override
  Future<List<Band>> getBands({required List<String> bandIds}) async {
    final collectionRef = _db.collection(kBandPath).where(
          FieldPath.documentId,
          whereIn: bandIds,
        );

    return (await collectionRef.get())
        .docs
        .map(
          (doc) => BandModel.fromJson(doc.data()),
        )
        .toList();
  }

  @override
  Future<Band> getBand({required String bandId}) async {
    final docRef = _db.collection(kBandPath).doc(bandId);

    return BandModel.fromJson(await firebaseGet(docRef));
  }
}
