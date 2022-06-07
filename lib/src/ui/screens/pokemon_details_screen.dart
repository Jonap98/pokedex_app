import 'package:flutter/material.dart';
import 'package:pokedex_app/src/bloc/pokemon_bloc.dart';
import 'package:pokedex_app/src/helpers/color_types.dart';
import 'package:pokedex_app/src/models/pokemon_model.dart';
import 'package:pokedex_app/src/ui/widgets/type_tag.dart';

class PokemonDetailsScreen extends StatelessWidget {
  final pokemonsBloc = PokemonsBloc();

  PokemonDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          StreamBuilder(
              stream: pokemonsBloc.getPoke,
              builder: (context, AsyncSnapshot<Result> snapshot) {
                final pokemons = snapshot.data ??
                    Result(
                      name: '',
                      url: '',
                      image: '',
                      fullImage: '',
                      type: [],
                    );

                return Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: ColorTypes.setColor(pokemons.type!.first.type!.name!)
                      .withOpacity(0.7),
                  child: Stack(
                    children: [
                      Positioned(
                        right: 0,
                        top: size.height * 0.3,
                        child: Image(
                          width: size.width * 0.5,
                          color: Colors.blue.withOpacity(0.3),
                          colorBlendMode: BlendMode.modulate,
                          image: const AssetImage('assets/pokeball_icon.png'),
                        ),
                      ),
                      Positioned(
                        top: 20,
                        child: Container(
                          width: size.width,
                          padding: const EdgeInsets.only(top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.favorite_border,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  pokemons.name,
                                  // snapshot.data!.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: TypeTag(
                                  index: 0,
                                  text: pokemons.type!.first.type!.name!,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0.0,
                        right: 0.0,
                        left: 0.0,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: size.width * 0.2,
                            horizontal: 20,
                          ),
                          height: size.height * 0.5,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: const [
                                  Text('About'),
                                  Text('Base States'),
                                  Text('Evolutions'),
                                  Text('Moves'),
                                ],
                              ),
                              Divider(),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: size.height * 0.3,
                        child: Image(
                          width: size.width * 0.2,
                          color: Colors.blue.withOpacity(0.3),
                          colorBlendMode: BlendMode.modulate,
                          image: const AssetImage('assets/pokeball_icon.png'),
                        ),
                      ),
                      Positioned(
                        top: size.height * 0.15,
                        child: Container(
                          alignment: Alignment.center,
                          height: size.width * 0.8,
                          width: size.width,
                          // color: Colors.redAccent,
                          padding: EdgeInsets.all(20),
                          // child: CachedNetworkImage(
                          //   imageUrl: pokemons.fullImage!,
                          //   placeholder: (context, url) => Center(
                          //       child: CircularProgressIndicator(
                          //     color: Colors.white,
                          //   )),
                          //   errorWidget: (context, url, error) =>
                          //       Icon(Icons.error),
                          // ),
                          // child: Image.network(pokemons.image!),
                          child: Image(
                            filterQuality: FilterQuality.high,
                            image: NetworkImage(
                              pokemons.image!,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ],
      ),
    );
  }
}
