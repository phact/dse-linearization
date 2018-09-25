import {combineReducers} from 'redux';
import {handleAction} from 'redux-actions';
import {routerReducer} from 'react-router-redux';
import keplerGlReducer from 'kepler.gl/reducers';
import RequestReducer from './requestReducers.js'


// INITIAL_APP_STATE
const initialAppState = {
  appName: 'Powertrain Viewer',
  loaded: false
};

const reducers = combineReducers({
  // mount keplerGl reducer
  RequestReducer,
  keplerGl: keplerGlReducer,
  app: handleAction(
      'GET_DATA',
      (state, action) => ({
          ...state,
          dsedata : action.data
      }),
      initialAppState
  ),
  interval: handleAction(
      'SET_INTERVAL',
      (state, action) => ({
          ...state,
          value : action.data
      }),null
  ),
  routing: routerReducer
});

export default reducers;
