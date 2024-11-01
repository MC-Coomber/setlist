import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:setlist/core/data/db_consts.dart';
import 'package:setlist/core/data/firebase_utils.dart';
import 'package:setlist/core/data/models/membership_model.dart';
import 'package:setlist/core/domain/entities/membership.dart';
import 'package:setlist/core/errors.dart';

abstract class MembershipRemoteDataSource {
  Future<String> createMembership({required Membership membership});

  Future<void> createMemeberships({required List<Membership> memberships});

  Future<List<Membership>> getMembershipsFromMusicianId({required String musicianId});

  Future<List<Membership>> getMembershipsFromBandId({required String bandId});

  Stream<List<Membership>> membershipUpdateNotifier({required String userId});

  Future<Membership> getMembership({required String musicianId, required String bandId});

  Future<void> deleteMembership({required String musicianId, required String bandId});

  Future<void> updateRole({
    required String userId,
    required String bandId,
    required String newRoleId,
  });
}

class MembershipRemoteDataSourceImpl extends MembershipRemoteDataSource {
  MembershipRemoteDataSourceImpl({
    FirebaseFirestore? firebaseDatabase,
  }) : _db = firebaseDatabase ?? FirebaseFirestore.instance;

  final FirebaseFirestore _db;

  @override
  Future<String> createMembership({required Membership membership}) {
    final collectionRef = _db.collection(kMembershipPath);

    final newMembership = MembershipModel.fromEntity(membership);

    return firebaseAdd(collectionRef: collectionRef, data: newMembership.toJson());
  }

  @override
  Future<void> createMemeberships({required List<Membership> memberships}) {
    final batch = _db.batch();

    for (final membership in memberships) {
      final docRef = _db.collection(kMembershipPath).doc();
      final data = MembershipModel.fromEntity(membership).toJson();
      batch.set(docRef, data);
    }

    return firebaseCommitBatch(batch: batch);
  }

  @override
  Future<List<Membership>> getMembershipsFromMusicianId({required String musicianId}) async {
    final query = _db.collection(kMembershipPath).where(
          'musicianId',
          isEqualTo: musicianId,
        );

    return firebaseQuery(
      query: query,
      converter: MembershipModel.fromJson,
    );
  }

  @override
  Future<List<Membership>> getMembershipsFromBandId({required String bandId}) async {
    final query = _db.collection(kMembershipPath).where(
          'bandId',
          isEqualTo: bandId,
        );

    return firebaseQuery(
      query: query,
      converter: MembershipModel.fromJson,
    );
  }

  @override
  Stream<List<Membership>> membershipUpdateNotifier({required String userId}) {
    final collectionRef = _db.collection(kMembershipPath).where(
          'musicianId',
          isEqualTo: userId,
        );

    return collectionRef.snapshots().map(
          (snapshot) => parseDocs(
            docs: snapshot.docs,
            converter: MembershipModel.fromJson,
          ),
        );
  }

  @override
  Future<void> deleteMembership({required String musicianId, required String bandId}) async {
    final collectionRef = _db
        .collection(kMembershipPath)
        .where(
          'musicianId',
          isEqualTo: musicianId,
        )
        .where('bandId', isEqualTo: bandId);

    final docs = (await collectionRef.get()).docs;

    final List<Future> futures = [];
    for (final doc in docs) {
      futures.add(firebaseDelete(docRef: doc.reference));
    }

    await Future.wait(futures);
  }

  @override
  Future<Membership> getMembership({required String musicianId, required String bandId}) async {
    final collectionRef = _db
        .collection(kMembershipPath)
        .where(
          'musicianId',
          isEqualTo: musicianId,
        )
        .where('bandId', isEqualTo: bandId);

    final queryResults = await firebaseQuery(
      query: collectionRef,
      converter: MembershipModel.fromJson,
    );
    if (queryResults.isEmpty) {
      throw DataNotFoundError();
    }
    return queryResults.first;
  }

  @override
  Future<void> updateRole({
    required String userId,
    required String bandId,
    required String newRoleId,
  }) async {
    final collectionRef = _db
        .collection(kMembershipPath)
        .where(
          'musicianId',
          isEqualTo: userId,
        )
        .where('bandId', isEqualTo: bandId);

    final membershipRef = (await collectionRef.get().onError((e, _) {
      throw ServerError(e.toString());
    }))
        .docs
        .first
        .reference;

    return firebaseUpdate(docRef: membershipRef, data: {'roleId': newRoleId});
  }
}
