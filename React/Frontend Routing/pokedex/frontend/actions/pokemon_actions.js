import * as APIUtil from '../util/api_util';

export const RECEIVE_ALL_POKEMON = 'RECEIVE_ALL_POKEMON';
export const RECEIVE_SINGLE_POKEMON = 'RECEIVE_SINGLE_POKEMON';
export const RECEIVE_POKEMON_ERRORS = 'RECEIVE_POKEMON_ERRORS';

export const receiveAllPokemon = pokemon => ({
  type: RECEIVE_ALL_POKEMON,
  pokemon
});

export const receiveSinglePokemon = pokemonData => ({
  type: RECEIVE_SINGLE_POKEMON,
  pokemonData
});

export const receivePokemonErrors = errors => ({
  type: RECEIVE_POKEMON_ERRORS,
  errors
})

export const requestAllPokemon = () => dispatch => {
  return APIUtil.fetchAllPokemon()
  .then(pokemon => {
    dispatch(receiveAllPokemon(pokemon));
    return pokemon;
  })
  .catch(error => console.log(error));
};

export const requestSinglePokemon = pokemonId => dispatch => {
  return APIUtil.fetchSinglePokemon(pokemonId)
  .then(pokemon => {
    dispatch(receiveSinglePokemon(pokemon));
    return pokemon;
  })
  .catch(error => console.log(error));
};

export const createPokemon = pokemonData => dispatch => {
  return APIUtil.createNewPoke(pokemonData)
    .then(pokemon => {
      dispatch(receiveSinglePokemon(pokemon));
      return pokemon;
    })
    .catch(err => {
      err.json().then(errors => dispatch(receivePokemonErrors(errors)))
    })
};
