import 'package:flutter/material.dart';
import 'package:gestionutilisateur/models/user.dart';
import 'package:gestionutilisateur/services/user_service.dart';
import 'package:gestionutilisateur/views/user_detail_view.dart';

class AllUsersView extends StatelessWidget {
  const AllUsersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des utilisateurs'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<User>>(
          future: UserService.fetchUsers(), 
          builder: (context, snapshot){
            if (snapshot.connectionState == ConnectionState.waiting){
              return const Center(
                child: CircularProgressIndicator()
              );
            }else if(snapshot.hasError){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error, size: 64, color: Colors.red,),
                    const SizedBox(height: 16,),
                    Text('Erreur: ${snapshot.error}'),
                  ],
                ),
              );
            }else if(!snapshot.hasData || snapshot.data!.isEmpty){
              return const Center(
                child: Text(('Aucun utilisateur trouvé'),)
              );
            }

            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index){
                final user = snapshot.data![index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Text(
                        user.name[0].toUpperCase(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(user.name),
                    subtitle: Text(user.email),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UserDetailView(user: user),
                        )
                      );
                    },
                  ),
                );
              },
            );
          }
      ),
    );
  }
}
