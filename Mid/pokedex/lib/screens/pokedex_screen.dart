import 'package:flutter/material.dart';
import '../models/pokemon.dart';
import '../services/pokemon_service.dart';
import '../widgets/pokemon_card.dart';
import '../widgets/search_bar.dart'; // This import stays the same

class PokedexScreen extends StatefulWidget {
  const PokedexScreen({super.key});

  @override
  State<PokedexScreen> createState() => _PokedexScreenState();
}

class _PokedexScreenState extends State<PokedexScreen> {
  List<Pokemon> _pokemons = [];
  List<Pokemon> _filteredPokemons = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadPokemons();
  }

  void _loadPokemons() {
    setState(() {
      _pokemons = PokemonService.getPokemons();
      _filteredPokemons = _pokemons;
    });
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
      _filteredPokemons = PokemonService.searchPokemons(query);
    });
  }

  void _showPokemonDetails(Pokemon pokemon) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(pokemon.name),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(pokemon.imageUrl, height: 120),
              const SizedBox(height: 16),
              Text(pokemon.description),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                children: pokemon.types.map((type) {
                  return Chip(
                    label: Text(type),
                    backgroundColor: Colors.red[100],
                  );
                }).toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokedex'),
        centerTitle: true,
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          PokeSearchBar(onSearchChanged: _onSearchChanged), // Changed here
          Expanded(
            child: _filteredPokemons.isEmpty
                ? const Center(
                    child: Text(
                      'No Pokémon found',
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(8),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: _filteredPokemons.length,
                    itemBuilder: (context, index) {
                      final pokemon = _filteredPokemons[index];
                      return PokemonCard(
                        pokemon: pokemon,
                        onTap: () => _showPokemonDetails(pokemon),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}