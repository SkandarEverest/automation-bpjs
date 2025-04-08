const { exec } = require('child_process');
const express = require('express');
const cors = require('cors');

const app = express()

app.use(cors())

function runningApp() {
    exec('open-bpjs.au3', (error, stdout, stderr) => {
        console.log(stdout);
        console.log(stderr);
        if (error !== null) {
            console.log(`exec error: ${error}`);
        }
    });
}

function runningFrista(username, password, nik) {
    const scriptPath = "open-frista.au3";
    const command = `AutoIt3.exe ${scriptPath} "${username}" "${password}" "${nik}"`;

    exec(command, (error, stdout, stderr) => {
        console.log(stdout);
        console.log(stderr);
        if (error !== null) {
            console.log(`exec error: ${error}`);
        }
        console.log('finished running frista')
    });
}


function minimizeApp() {
    exec('minimizie-bpjs.au3', (error, stdout, stderr) => {
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

app.get('/open-frista', function (req, res) {
    const { username, password, nik } = req.query;

    // Check if any field is missing
    if (!username || !password || !nik) {
        return res.status(400).send('Missing username, password, or NIK');
    }
    // Call your automation with query values
    runningFrista(username, password, nik);

    res.send('Frista automation started');
});

app.listen(3000)
console.log('listening to port 3000')