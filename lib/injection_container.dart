import 'package:get_it/get_it.dart';
import 'package:setlist/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:setlist/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:setlist/features/auth/domain/repositories/auth_repository.dart';
import 'package:setlist/features/auth/domain/usecases/current_user_usecase.dart';
import 'package:setlist/features/auth/domain/usecases/login_usecase.dart';
import 'package:setlist/features/auth/domain/usecases/logout_usecase.dart';
import 'package:setlist/features/auth/domain/usecases/signup_usecase.dart';
import 'package:setlist/features/auth/presentation/cubit/auth/auth_cubit.dart';
import 'package:setlist/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:setlist/features/auth/presentation/cubit/sign_up/sign_up_cubit.dart';
import 'package:setlist/core/data/datasources/band_remote_data_source.dart';
import 'package:setlist/core/data/datasources/membership_remote_data_source.dart';
import 'package:setlist/core/data/datasources/musician_remote_data_source.dart';
import 'package:setlist/core/data/repositories/band_repository_impl.dart';
import 'package:setlist/core/data/repositories/membership_respository_impl.dart';
import 'package:setlist/core/data/repositories/musician_repository_impl.dart';
import 'package:setlist/core/domain/repositories/band_repository.dart';
import 'package:setlist/core/domain/repositories/membership_repository.dart';
import 'package:setlist/core/domain/repositories/musician_repository.dart';
import 'package:setlist/features/band_details/data/datasources/permissions_remote_datasource.dart';
import 'package:setlist/features/band_details/data/repositories/permissions_repository_impl.dart';
import 'package:setlist/features/band_details/domain/repositories/permissions_repository.dart';
import 'package:setlist/features/band_details/domain/usecases/add_song_usecase.dart';
import 'package:setlist/features/band_details/domain/usecases/delete_setlist_usecase.dart';
import 'package:setlist/features/band_details/domain/usecases/get_band_usecase.dart';
import 'package:setlist/features/band_details/domain/usecases/get_membership_usecase.dart';
import 'package:setlist/features/band_details/domain/usecases/get_setlist_usecase.dart';
import 'package:setlist/features/band_details/domain/usecases/leave_band_usecase.dart';
import 'package:setlist/features/band_details/presentation/cubit/add_members/add_members_cubit.dart';
import 'package:setlist/features/band_details/presentation/cubit/add_song/add_song_cubit.dart';
import 'package:setlist/features/band_details/presentation/cubit/band_details/band_details_cubit.dart';
import 'package:setlist/features/band_details/domain/usecases/add_members_usecase.dart';
import 'package:setlist/features/band_details/domain/usecases/delete_band_usecase.dart';
import 'package:setlist/features/band_details/domain/usecases/delete_membership_usecase.dart';
import 'package:setlist/features/band_details/domain/usecases/get_permissions_usecase.dart';
import 'package:setlist/features/band_details/domain/usecases/search_musicians_usecase.dart';
import 'package:setlist/features/band_details/presentation/cubit/setlist_view/setlist_view_cubit.dart';
import 'package:setlist/features/create_band/usecases/create_band_usecase.dart';
import 'package:setlist/features/dashboard/usecases/create_musician_usecase.dart';
import 'package:setlist/features/band_details/domain/usecases/get_band_members_usecase.dart';
import 'package:setlist/features/dashboard/usecases/get_bands_usecase.dart';
import 'package:setlist/features/dashboard/usecases/get_musician_usecase.dart';
import 'package:setlist/features/create_band/presentation/cubit/create_band_cubit.dart';
import 'package:setlist/features/dashboard/presentation/cubit/create_musician/create_musician_cubit.dart';
import 'package:setlist/features/dashboard/presentation/cubit/dashboard/dashboard_cubit.dart';
import 'package:setlist/features/band_details/data/datasources/song_remote_datasource.dart';
import 'package:setlist/features/band_details/data/repositories/song_repository_impl.dart';
import 'package:setlist/features/band_details/domain/repositories/song_repository.dart';
import 'package:setlist/features/band_details/domain/usecases/get_songs_usecase.dart';
import 'package:setlist/features/setlist_editor/data/datasources/setlist_remote_datasource.dart';
import 'package:setlist/features/setlist_editor/data/repositories/setlist_repository_impl.dart';
import 'package:setlist/features/setlist_editor/domain/repositoires/setlist_repository.dart';
import 'package:setlist/features/setlist_editor/domain/usecases/save_setlist_usecase.dart';
import 'package:setlist/features/setlist_editor/domain/usecases/get_setlists_usecase.dart';
import 'package:setlist/features/setlist_editor/presentation/cubit/setlist_editor_cubit.dart';

import 'core/domain/entities/band.dart';
import 'features/setlist_editor/domain/entities/setlist.dart';

final serviceLocator = GetIt.instance;

void init() {
  // Cubits
  serviceLocator.registerFactory(
    () => AuthCubit(
      currentUserUsecase: serviceLocator(),
      logoutUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => SignUpCubit(
      usecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => LoginCubit(
      usecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => DashboardCubit(
      getMusicianUsecase: serviceLocator(),
      getBandsUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => CreateMusicianCubit(
      createMusicianUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => CreateBandCubit(
      createBandUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactoryParam(
    (List<String> currentMemberMusicianIds, _) => AddMembersCubit(
      currentMemberMusicianIds: currentMemberMusicianIds,
      searchMusiciansUsecase: serviceLocator(),
      addMembersUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactoryParam(
    (String bandId, _) => BandDetailsCubit(
      bandId: bandId,
      getBandUsecase: serviceLocator(),
      getBandMembersUsecase: serviceLocator(),
      deleteBandUsecase: serviceLocator(),
      deleteMembershipUsecase: serviceLocator(),
      getPermissionsUsease: serviceLocator(),
      getMembershipUsecase: serviceLocator(),
      getSongsUsecase: serviceLocator(),
      getSetlistsUsecase: serviceLocator(),
      leaveBandUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactoryParam(
    (Band band, _) => AddSongCubit(
      band: band,
      addSongUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactoryParam(
    (Band band, Setlist? setlist) => SetlistEditorCubit(
      band: band,
      setlist: setlist,
      getSongsUsecase: serviceLocator(),
      saveSetlistUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactoryParam(
    (Setlist setlist, String bandId) => SetlistViewCubit(
      setlist: setlist,
      bandId: bandId,
      deleteSetlistUsecase: serviceLocator(),
    ),
  );

  // Usecases
  serviceLocator.registerLazySingleton(
    () => LoginUsecase(
      authRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => LogoutUsecase(
      authRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => SignupUsecase(
      authRepository: serviceLocator(),
      musicianRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => CurrentUserUsecase(
      authRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => GetMusicianUsecase(
      musicianRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => CreateMusicianUsecase(
      musicianRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => CreateBandUsecase(
      bandRepository: serviceLocator(),
      membershipRepository: serviceLocator(),
      musicianRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => GetBandsUsecase(
      membershipRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => GetBandMembersUsecase(
      musicianRepository: serviceLocator(),
      membershipRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => DeleteBandUsecase(
      bandRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => SearchMusiciansUsecase(
      musicianRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => AddMembersUsecase(
      membershipRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => DeleteMembershipUsecase(
      membershipRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => GetMembershipUsecase(
      membershipRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => GetPermissionsUsecase(
      permissionsRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => GetSongsUsecase(
      songRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => AddSongUsecase(
      songRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => SaveSetlistUsecase(
      setlistRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => GetSetlistsUsecase(
      setlistRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => GetSetlistUsecase(
      setlistRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => DeleteSetlistUsecase(
      setlistRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => LeaveBandUsecase(
      membershipRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => GetBandUsecase(
      bandRepository: serviceLocator(),
    ),
  );

  // Repositories
  serviceLocator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authRemoteDataSource: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<MusicianRepository>(
    () => MusicianRepositoryImpl(
      remoteDataSource: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<MembershipRepository>(
    () => MembershipRespositoryImpl(
      membershipRemoteDataSource: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<BandRepository>(
    () => BandRepositoryImpl(remoteDataSource: serviceLocator()),
  );
  serviceLocator.registerLazySingleton<PermissionsRepository>(
    () => PermissionsRepositoryImpl(remoteDataSource: serviceLocator()),
  );
  serviceLocator.registerLazySingleton<SongRepository>(
    () => SongRepositoryImpl(remoteDataSource: serviceLocator()),
  );
  serviceLocator.registerLazySingleton<SetlistRepository>(
    () => SetlistRepositoryImpl(remoteDataSource: serviceLocator()),
  );

  // Data sources
  serviceLocator.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );
  serviceLocator.registerLazySingleton<MusicianRemoteDataSource>(
    () => MusicianRemoteDataSourceImpl(),
  );
  serviceLocator.registerLazySingleton<BandRemoteDataSource>(
    () => BandRemoteDataSourceImpl(),
  );
  serviceLocator.registerLazySingleton<MembershipRemoteDataSource>(
    () => MembershipRemoteDataSourceImpl(),
  );
  serviceLocator.registerLazySingleton<PermissionsRemoteDatasource>(
    () => PermissionsRemoteDatasourceImpl(),
  );
  serviceLocator.registerLazySingleton<SongRemoteDataSource>(
    () => SongRemoteDataSourceImpl(),
  );
  serviceLocator.registerLazySingleton<SetlistRemoteDatasource>(
    () => SetlistRemoteDatasourceImpl(),
  );
}
