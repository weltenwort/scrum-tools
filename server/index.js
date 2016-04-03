const bodyParser = require('body-parser');
const configuration = require('feathers-configuration');
const createDebug = require('debug');
const feathers = require('feathers');
const feathersNedb = require('feathers-nedb');
const morgan = require('morgan');
const NeDB = require('nedb');
const socketio = require('feathers-socketio');


const CONFIG_DIRECTORY = (!!process.env.ST_CONFIG_DIRECTORY
    ? process.env.ST_CONFIG_DIRECTORY
    : __dirname + "/.."
);
const isProductionEnv = (app) => app.get('env') !== 'production'

const app = feathers()
    .configure(configuration(CONFIG_DIRECTORY))
    .configure(socketio())
    .use(morgan('combined'))
    .use(bodyParser.json());

if (isProductionEnv) {
    createDebug.enable('scrumTools:*');

    const createDevMiddleware = require('./webpackMiddleware');
    app.use(createDevMiddleware());
}

const logHttp = createDebug('scrumTools:http')

app.use('/retrospectives', feathersNedb({
    Model: new NeDB({
        filename: app.get('retrospectives_db'),
        autoload: true
    })
}));

const server = app.listen(
    app.get('port'),
    app.get('address'),
    () => {
        const addressInfo = server.address();
        const address = (addressInfo.family === 'IPv6'
            ? `[${addressInfo.address}]`
            : addressInfo.address
        );
        const port = addressInfo.port;

        logHttp(`Server listening on http://${address}:${port}`)
    }
);
