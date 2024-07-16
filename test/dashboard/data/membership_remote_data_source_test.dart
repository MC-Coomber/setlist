import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:setlist/core/data/datasources/membership_remote_data_source.dart';
import 'package:setlist/core/domain/entities/membership.dart';
import 'package:setlist/core/domain/entities/role.dart';

const musicianId = 'musician123';
const bandId = 'band123';

final membership = Membership(
  musicianId: musicianId,
  bandId: bandId,
  role: Role.founder(),
);

main() {
  late MembershipRemoteDataSourceImpl dataSourceImpl;
  late String membershipId;

  setUp(() async {
    dataSourceImpl = MembershipRemoteDataSourceImpl(firebaseDatabase: FakeFirebaseFirestore());
    membershipId = await dataSourceImpl.createMembership(
      membership: membership,
    );
  });

  test('Should create a new membership and return an id', () async {
    expect(membershipId.isNotEmpty, true);
  });

  test('Should be able to fetch the created membership with the musician id', () async {
    final memberships = await dataSourceImpl.getMembershipsFromMusicianId(userId: musicianId);

    expect(memberships.isNotEmpty, true);
    expect(memberships.first.musicianId, musicianId);
  });

  test('Should be able to fetch the created membership with the band id', () async {
    final memberships = await dataSourceImpl.getMembershipsFromBandId(bandId: bandId);

    expect(memberships.isNotEmpty, true);
    expect(memberships.first.bandId, bandId);
  });

  test('Should be able to create multiple memberships', () async {
    const musicianId = 'musician1234';
    await dataSourceImpl.createMemeberships(memberships: [
      Membership(
        musicianId: musicianId,
        bandId: bandId,
        role: Role.member(),
      ),
    ]);

    final newMembership = await dataSourceImpl.getMembershipsFromMusicianId(userId: musicianId);

    expect(newMembership.first.musicianId, musicianId);
  });
}
