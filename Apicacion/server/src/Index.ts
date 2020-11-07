import express, { Application } from 'express';
import morgan from 'morgan';
import cors from 'cors';
import indexRoutes from './routes/indexRoutes';
import apiRputes from './routes/apiRputes';
import userRoutes from './routes/userRoutes';
import imageRoutes from './routes/imageRoutes';
import productoRoutes from './routes/productoRoutes';
import path from 'path';
class Server {
    
    //-----------------------
     
    //----------------

    public app: Application;

    constructor(){
        this.app = express();
        this.config();
        this.routes();
    }

    config(): void{
        this.app.set('port',3009);
        this.app.use(morgan('dev'));
        this.app.use(cors());
        this.app.use(express.json());
        this.app.use(express.urlencoded({extended:false}));

    }

    routes():void {
        this.app.use('/', indexRoutes);
        this.app.use('/api', apiRputes);
        this.app.use('/user', userRoutes);
        this.app.use('/image', imageRoutes);
        this.app.use('/uploads', express.static(path.resolve('uploads')));
        this.app.use('/producto', productoRoutes);
    }

    start():void{

        this.app.listen(this.app.get('port'),() => {
            console.log('Server on port ',this.app.get('port'));
        });

        
    }
}

export const server = new Server();
server.start();