import path from 'path';

import bodyParser from 'body-parser';
import configuration from 'feathers-configuration';
import createDebug from 'debug';
import feathers from 'feathers';
import feathersNedb from 'feathers-nedb';
import morgan from 'morgan';
import NeDB from 'nedb';
import socketio from 'feathers-socketio';

const CONFIG_DIRECTORY = (process.env.ST_CONFIG_DIRECTORY
  ? process.env.ST_CONFIG_DIRECTORY
  : path.join(__dirname, '..')
);
const isProductionEnv = (app) => app.get('env') === 'production';

const app = feathers()
  .configure(configuration(CONFIG_DIRECTORY))
  .configure(socketio())
  .use(morgan('combined'))
  .use(bodyParser.json());

if (!isProductionEnv(app)) {
  createDebug.enable('scrumTools:*');
}

const logHttp = createDebug('scrumTools:http');

app.use('/retrospectives', feathersNedb({
  Model: new NeDB({
    filename: app.get('retrospectives_db'),
    autoload: true,
  }),
}));

if (!isProductionEnv(app)) {
  app.use('/', feathers.static(app.get('assets_directory')));
}

const server = app.listen(
  app.get('port'),
  app.get('address'),
  () => {
    const addressInfo = server.address();
    const address = (addressInfo.family === 'IPv6';
      ? `[${addressInfo.address}]`
      : addressInfo.address
    );
    const port = addressInfo.port;

    logHttp(`Server listening on http://${address}:${port}`);
  }
);
