const express = require('express');
const app = express();
const session = require('express-session');
const fs = require('fs');

app.use(session({
    secret: '@secret',        
    resave: false,             // request 요청이 왔을때 세션을 다시 저장할건지
    saveUninitialized: false,  // 세션에 저장할 내용이 없더라도 저장 할건지
    cookie: {
        secure: false,
        maxAge: 1000 * 60 * 60 // 쿠키 유효시간(1시간)
    }
}));

app.use(express.json({
    limit: '50mb'
}));

const server = app.listen(3000, () => {
    console.log('Server started. port 3000.');
})

let sql = require('./sql.js');

// sql.js 파일 수정시 서버 재시작 없이 개발하기 위해 사용
fs.watchFile(__dirname + '/sql.js', (curr, prev) => {
    console.log('sql.js modified');
    delete require.cache[require.resolve('./sql.js')];
    sql = require('./sql.js');
});

const db = {
    database: "conpany",
    connectionLimit: 10,
    host: "localhost",
    user: "root",
    password: "mariadb"
}

const dbPool = require('mysql').createPool(db);

app.post('/upload/:bSno/:bFName', async (request, res) => {
    let {
        bSno,
        bFName
    } = request.params;
    const dir = `${__dirname}/upload/${bSno}`;
    const file = `${dir}/${bFName}`;
    if(!request.body.data) {
        return fs.unlink(file, async (err) => res.send({ err }));
    }
    const data = request.body.data.slice(request.body.data.indexOf(';base64,') + 8);
    if(!fs.existsSync(dir)) {
        fs.mkdirSync(dir);
    }
    fs.writeFile(file, data, 'base64', async (error) => {
        await req.db('insertBoardFile', [{
            b_sno: bSno,
            b_f_name: bFName
        }]);

        if (error) {
            res.send({
                error
            });
        } else {
            res.send("file upload");
        }
    });
});

app.post('/profile/:mSno/:mFName', async (request, res) => {
    let {
        mSno,
        mFName
    } = request.params;
    const dir = `${__dirname}/profile/${mSno}`;
    const file = `${dir}/${mFName}`;
    if(!request.body.data) {
        return fs.unlink(file, async (err) => res.send({ err }));
    }
    const data = request.body.data.slice(request.body.data.indexOf(';base64,') + 8);
    if(!fs.existsSync(dir)) {
        fs.mkdirSync(dir);
    }
    fs.writeFile(file, data, 'base64', async (error) => {
        await req.db('insertMemberFile', [{m_sno: mSno, m_f_name: mFName}
                                       , {m_f_name: mFName}]);

        if (error) {
            res.send({
                error
            });
        } else {
            res.send("profile upload");
        }
    });
});

app.post('/folder/:fSno/:fFName', async (request, res) => {
    let {
        fSno,
        fFName
    } = request.params;
    const dir = `${__dirname}/folder/${fSno}`;
    const file = `${dir}/${fFName}`;
    if(!request.body.data) {
        return fs.unlink(file, async (err) => res.send({ err }));
    }
    const data = request.body.data.slice(request.body.data.indexOf(';base64,') + 8);
    if(!fs.existsSync(dir)) {
        fs.mkdirSync(dir);
    }
    fs.writeFile(file, data, 'base64', async (error) => {
        await req.db('insertFolderFile', [{f_sno: fSno, f_f_name: fFName}]);

        if (error) {
            res.send({
                error
            });
        } else {
            res.send("folder file upload");
        }
    });
});

app.get('/download/:path/:sno/:fName', (request, res) => {
    const {
        path,
        sno,
        fName
    } = request.params;
    const filepath = `${__dirname}/${path}/${sno}/${fName}`;
    res.header('Content-Type', `image/${fName.substring(fName.lastIndexOf("."))}`);
    if (!fs.existsSync(filepath)) res.send(404, {
      error: 'Can not found file.'
    });
    else fs.createReadStream(filepath).pipe(res);
});

app.post('/api/:alias', async (request, res) => {
    try {
        res.send(await req.db(request.params.alias, request.body.param, request.body.where));
    } catch(err) {
        res.status(500).send({
            error: err
        });
    }
});

const req = {
    async db(alias, param = [], where = '') {
        return new Promise((resolve, reject) => dbPool.query(sql[alias].query + where, param, (error, rows) => {
            if(error) {
                if(error.code != 'ER_DUP_ENTRY') {
                    console.log(error);
                }
                resolve({
                    error
                });
            } else {
                resolve(rows);
            }
        }));
    }
};