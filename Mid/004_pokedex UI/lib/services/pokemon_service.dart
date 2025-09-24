import '../models/pokemon.dart';

class PokemonService {
  static final List<Pokemon> pokemons = [
    Pokemon(
      id: 1,
      name: 'Bulbasaur',
      imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png',
      types: ['Grass', 'Poison'],
      description: 'A strange seed was planted on its back at birth. The plant sprouts and grows with this Pokémon.',
    ),
    Pokemon(
      id: 4,
      name: 'Charmander',
      imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png',
      types: ['Fire'],
      description: 'Obviously prefers hot places. When it rains, steam is said to spout from the tip of its tail.',
    ),
    Pokemon(
      id: 7,
      name: 'Squirtle',
      imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/7.png',
      types: ['Water'],
      description: 'After birth, its back swells and hardens into a shell. It sprays a potent foam from its mouth.',
    ),
    Pokemon(
      id: 25,
      name: 'Pikachu',
      imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png',
      types: ['Electric'],
      description: 'When several of these Pokémon gather, their electricity could build and cause lightning storms.',
    ),
    Pokemon(
      id: 133,
      name: 'Eevee',
      imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/133.png',
      types: ['Normal'],
      description: 'Its genetic code is irregular. It may mutate if it is exposed to radiation from element stones.',
    ),
  ];

  static List<Pokemon> getPokemons() {
    return pokemons;
  }

  static List<Pokemon> searchPokemons(String query) {
    if (query.isEmpty) return pokemons;
    return pokemons.where((pokemon) => 
      pokemon.name.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }
}