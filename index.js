const { exec } = require('child_process');
const express = require('express');
const cors = require('cors');

const app = express()

app.use(cors())

function runningApp() {
    exec('open-bpjs.exe', (error, stdout, stderr) => {
        console.log(stdout);
        console.log(stderr);
        if (error !== null) {
            console.log(`exec error: ${error}`);
        }
    });
}


function minimizeApp() {
    exec('minimizie-bpjs.exe', (error, stdout, stderr) => {
        console.log(stdout);
        console.log(stderr);
        if (error !== null) {
            console.log(`exec error: ${error}`);
        }
    });
}

app.get('/open', function (_req, res) {
    runningApp()
    res.send('Ok')
})

app.get('/minimize', function (_req, res) {
    minimizeApp()
    res.send('Ok')
})

app.listen(3000)