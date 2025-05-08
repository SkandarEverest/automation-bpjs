const { encrypt } = require('./aesGcmUtil');

// CLI execution support
if (require.main === module) {
    const args = process.argv.slice(2); // skip node and script name
    const inputText = args.join(' '); // allow for quoted input with spaces
    
    if (!inputText) {
      console.error('Usage: node encrypt.js "Text to encrypt"');
      process.exit(1);
    }

    try {
        let output = encrypt(inputText);
        console.log(output);
    } catch (err) {
        console.error('Error:', err.message);
        process.exit(1);
    }
}
