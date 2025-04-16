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

function runningFrista(username, password, bpjsNo) {
    const scriptPath = "open-frista.exe";
    const command = `${scriptPath} "${username}" "${password}" "${bpjsNo}"`;
    // for development
    // const scriptPath = "open-frista.au3";
    // const command = `AutoIt3.exe ${scriptPath} "${username}" "${password}" "${bpjsNo}"`;

    exec(command, (error, stdout, stderr) => {
        console.log(stdout);
        console.log(stderr);
        if (error !== null) {
            console.log(`exec error: ${error}`);
        }
        console.log('finished running frista')
    });
}

function closeFrista() {
    const scriptPath = "close-frista.exe";
    const command = `${scriptPath}"`;
    // for development
    // const scriptPath = "close-frista.au3";
    // const command = `AutoIt3.exe ${scriptPath}`;

    exec(command, (error, stdout, stderr) => {
        console.log(stdout);
        console.log(stderr);
        if (error !== null) {
            console.log(`exec error: ${error}`);
        }
        console.log('finished closing frista')
    });
}

function runningFinger(username, password, bpjsNo) {
    const scriptPath = "open-fingerprint.exe";
    const command = `${scriptPath} "${username}" "${password}" "${bpjsNo}"`;
    // for development
    // const scriptPath = "open-fingerprint.au3";
    // const command = `AutoIt3.exe ${scriptPath} "${username}" "${password}" "${bpjsNo}"`;

    exec(command, (error, stdout, stderr) => {
        console.log(stdout);
        console.log(stderr);
        if (error !== null) {
            console.log(`exec error: ${error}`);
        }
        console.log('finished running fingerprint')
    });
}

function closeFinger() {
    const scriptPath = "close-fingerprint.exe";
    const command = `${scriptPath}"`;
    // for development
    // const scriptPath = "close-fingerprint.au3";
    // const command = `AutoIt3.exe ${scriptPath}`;

    exec(command, (error, stdout, stderr) => {
        console.log(stdout);
        console.log(stderr);
        if (error !== null) {
            console.log(`exec error: ${error}`);
        }
        console.log('finished closing fingerprint')
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
    const { username, password, bpjsNo } = req.query;

    // Check if any field is missing
    if (!username || !password || !bpjsNo) {
        return res.status(400).send('Missing username, password, or Bpjs Number');
    }
    // Call your automation with query values
    runningFrista(username, password, bpjsNo);

    res.send('Frista automation started');
});

app.get('/close-frista', function (req, res) {
    closeFrista();

    res.send('Frista automation started');
});

app.get('/open-finger', function (req, res) {
    const { username, password, bpjsNo } = req.query;

    // Check if any field is missing
    if (!username || !password || !bpjsNo) {
        return res.status(400).send('Missing username, password, or Bpjs Number');
    }
    // Call your automation with query values
    runningFinger(username, password, bpjsNo);

    res.send('Fingerprint automation started');
});

app.get('/close-finger', function (req, res) {
    closeFinger();

    res.send('Fingerprint automation started');
});

app.listen(3000)
console.log('listening to port 3000')