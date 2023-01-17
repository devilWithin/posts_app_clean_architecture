import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/core/app_theme.dart';
import 'package:posts_app/features/posts/presentation/screens/posts_screen.dart';
import 'features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'features/posts/presentation/bloc/get_all_posts/posts_bloc.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => di.sl<PostsBloc>()..add(GetAllPostsEvent())),
        BlocProvider(create: (context) => di.sl<AddDeleteUpdatePostBloc>()),
      ],
      child: MaterialApp(
          title: 'Posts App',
          debugShowCheckedModeBanner: false,
          theme: appTheme,
          home: const PostsScreen()),
    );
  }
}
