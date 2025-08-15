import 'package:meal_app/core/error/exceptions.dart';
import 'package:meal_app/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Session? get currentUserSession;
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
    required String phone
  });
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  });
  Future<UserModel?> getCurrentUserData();

  Future<UserModel> updateUserProfile(
    {
     required String name,
     required String email,
     required String password, 
     required String phone, 
     required String imageURL
    }
  );


}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;
  AuthRemoteDataSourceImpl(this.supabaseClient);

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );
      if (response.user == null) {
        throw const ServerException('User is null!');
      }
      
      print(response.user!.toJson());
      return UserModel.fromJson(response.user!.toJson());
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {
          'name': name,
          "phone" : phone,
          "imageURL" : "",
          "password" : password
        },
      );
      if (response.user == null) {
        throw const ServerException('User is null!');
      }
      return UserModel.fromJson(response.user!.toJson());
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    final user = supabaseClient.auth.currentUser;

    if(user != null){
      return UserModel.fromJson(user.toJson());
    }

    return null;
    
    // try {
    //   if (currentUserSession != null) {
    //     final userData = await supabaseClient.from('profiles').select().eq(
    //       'id',
    //       currentUserSession!.user.id,
    //     );
    //     return UserModel.fromJson(userData.first).copyWith(
    //       email: currentUserSession!.user.email,
    //     );
    //   }

    //   return null;
    // } catch (e) {
    //   throw ServerException(e.toString());
    // }
  }
  
  @override
Future<UserModel> updateUserProfile({
  required String name,
  required String email,
  required String password,
  required String phone,
  required String imageURL,
}) async {
  final currentUser = await getCurrentUserData();

  if (currentUser == null) {
    throw ServerException('No current user found');
  }

  try {
    // Build only changed metadata fields
    final Map<String, dynamic> updatedMetadata = {};

    if (name != currentUser.name) {
      updatedMetadata["name"] = name;
    }
    if (phone != currentUser.phone) {
      updatedMetadata["phone"] = phone;
    }
    if (imageURL != currentUser.imageURL) {
      updatedMetadata["imageURL"] = imageURL;
    }

    // (Optional) Storing password in metadata is not secure or recommended.
    if (password != currentUser.pass) {
      updatedMetadata["password"] = password;
    }

    // Prepare UserAttributes only with changed data
    final userAttributes = UserAttributes(
      email: email != currentUser.email ? email : null,
      password: password != currentUser.pass ? password : null,
      data: updatedMetadata.isNotEmpty ? updatedMetadata : null,
    );

    final response = await supabaseClient.auth.updateUser(userAttributes);

    return UserModel.fromJson(response.user!.toJson());
  } catch (e) {
    throw ServerException(e.toString());
  }
}

}
