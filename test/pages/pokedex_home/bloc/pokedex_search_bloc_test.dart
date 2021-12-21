import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minha_pokedex/src/application/pages/pokedex_home/bloc/pokedex_search_bloc.dart';
import 'package:minha_pokedex/src/domain/entities/pokemon.dart';
import 'package:minha_pokedex/src/domain/use_cases/poke_api/get_pokemons_use_case.dart';
import 'package:minha_pokedex/src/domain/use_cases/poke_api/search_pokemons_use_case.dart';
import 'package:minha_pokedex/src/infra/models/pokemon_model.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';

void main() {
  group('PokedexSearchBlocTest: ', () {
    late GetPokemonsUseCase getPokemons;
    late SearchPokemonsUseCase searchPokemons;
    late PokedexSearchBloc pokedexBloc;

    const pokemonsMock = [
      PokemonModel(
        name: 'pokemon',
        imageUrl: 'nada',
        pokedexNumber: 000,
        types: ['grass', 'dark'],
      ),
      PokemonModel(
        name: 'pokemon2',
        imageUrl: 'nada',
        pokedexNumber: 001,
        types: ['grass', 'fire'],
      ),
    ];

    const pokemonSearchMock = [
      PokemonModel(
        name: 'bulbassaur',
        imageUrl: 'nada',
        pokedexNumber: 000,
        types: ['grass'],
      ),
      PokemonModel(
        name: 'butterfree',
        imageUrl: 'nada',
        pokedexNumber: 001,
        types: ['bug', 'flying'],
      ),
    ];

    const pokemonSearchMoreMock = [
      PokemonModel(
        name: 'bulbassaur',
        imageUrl: 'nada',
        pokedexNumber: 000,
        types: ['grass'],
      ),
      PokemonModel(
        name: 'butterfree',
        imageUrl: 'nada',
        pokedexNumber: 001,
        types: ['bug', 'flying'],
      ),
      PokemonModel(
        name: 'butterfree',
        imageUrl: 'nada',
        pokedexNumber: 001,
        types: ['bug', 'flying'],
      ),
      PokemonModel(
        name: 'bulbassaur',
        imageUrl: 'nada',
        pokedexNumber: 000,
        types: ['grass'],
      ),
    ];

    setUp(() {
      getPokemons = GetPokemonsUseCaseMock();
      searchPokemons = SearchPokemonsUseCaseMock();

      pokedexBloc = PokedexSearchBloc(
        getPokemons: getPokemons,
        searchPokemons: searchPokemons,
      );
    });
    blocTest<PokedexSearchBloc, PokedexSearchState>(
      'emits [currentState] when none event is added',
      build: () => pokedexBloc,
      expect: () => const <PokedexSearchState>[],
    );

    blocTest<PokedexSearchBloc, PokedexSearchState>(
      'emits failure state when there is an error on PokedexSearchPageOpened bloc logic',
      build: () => pokedexBloc,
      act: (bloc) => bloc.add(PokedexSearchPageOpened()),
      expect: () => const <PokedexSearchState>[
        PokedexSearchState(status: SearchStatus.firstPageLoading),
        PokedexSearchState(status: SearchStatus.failure),
      ],
    );

    blocTest<PokedexSearchBloc, PokedexSearchState>(
      'emits firsPageLoading when getPokemons is loading, and emit success status and pokemonsMock when PokedexSearchPageOpened is added',
      setUp: () {
        when(
          () => getPokemons(
            pageOffset: any(
              named: 'pageOffset',
            ),
          ),
        ).thenAnswer((_) async {
          return pokemonsMock;
        });
      },
      build: () => pokedexBloc,
      act: (bloc) => bloc.add(PokedexSearchPageOpened()),
      expect: () => const <PokedexSearchState>[
        PokedexSearchState(status: SearchStatus.firstPageLoading),
        PokedexSearchState(
          status: SearchStatus.success,
          pokemons: pokemonsMock,
          currentPageOffset: 0,
        )
      ],
    );

    blocTest<PokedexSearchBloc, PokedexSearchState>(
      'emits filterLoading when searchPokemon is loading, and emit success with searchPokemons: [] when PokedexSearchPokemonFetched is added and searchTerm is empty',
      setUp: () {},
      build: () => pokedexBloc,
      act: (bloc) => bloc.add(
        PokedexSearchPokemonFetched(
          searchTerm: '',
        ),
      ),
      expect: () => const <PokedexSearchState>[
        PokedexSearchState(status: SearchStatus.filterLoading),
        PokedexSearchState(
          status: SearchStatus.success,
          searchPokemons: const <Pokemon>[],
          searchedPokemon: '',
        )
      ],
    );

    blocTest<PokedexSearchBloc, PokedexSearchState>(
      'emits filterLoading when searchPokemon is loading, and emit success with searchPokemonsMock when PokedexSearchPokemonFetched is added and searchTerm is bu',
      setUp: () {
        when(
          () => searchPokemons(
            pokemons: any(
              named: 'pokemons',
            ),
            searchTerm: any(
              named: 'searchTerm',
            ),
          ),
        ).thenAnswer((_) async {
          return pokemonSearchMock;
        });
      },
      build: () => pokedexBloc,
      act: (bloc) => bloc.add(
        PokedexSearchPokemonFetched(
          searchTerm: 'bu',
        ),
      ),
      expect: () => const <PokedexSearchState>[
        PokedexSearchState(status: SearchStatus.filterLoading),
        PokedexSearchState(
          status: SearchStatus.filterSuccess,
          searchPokemons: pokemonSearchMock,
          searchedPokemon: 'bu',
        )
      ],
    );

    blocTest<PokedexSearchBloc, PokedexSearchState>(
      'emits filterLoading when searchPokemon is loading, and emit success with pokemonSearchMoreMock when PokedexSearchPokemonFetched is added and searchTerm is bu',
      setUp: () {
        when(
          () => getPokemons(
            pageOffset: any(
              named: 'pageOffset',
            ),
          ),
        ).thenAnswer((_) async {
          return pokemonSearchMoreMock;
        });

        when(
          () => searchPokemons(
            pokemons: any(
              named: 'pokemons',
            ),
            searchTerm: any(
              named: 'searchTerm',
            ),
          ),
        ).thenAnswer((_) async {
          return pokemonSearchMoreMock;
        });
      },
      build: () => pokedexBloc,
      seed: () => PokedexSearchState(searchedPokemon: 'bu'),
      act: (bloc) => bloc.add(PokedexSearchMorePokemonsFetched()),
      expect: () => const <PokedexSearchState>[
        PokedexSearchState(
          status: SearchStatus.nextPageLoading,
          searchedPokemon: 'bu',
        ),
        PokedexSearchState(
          status: SearchStatus.filterSuccess,
          pokemons: pokemonSearchMoreMock,
          searchPokemons: pokemonSearchMoreMock,
          searchedPokemon: 'bu',
          currentPageOffset: 30,
        )
      ],
    );
  });
}
