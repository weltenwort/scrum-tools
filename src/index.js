/* @flow */
declare var env: {
  appMountId: string
}

// $FlowIgnore
import './styles/app.css';

const target: HTMLElement = document.getElementById(env.appMountId);
