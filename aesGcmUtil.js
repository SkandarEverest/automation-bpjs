const crypto = require('crypto');
require('dotenv').config();

const ALGORITHM = 'aes-256-gcm';
const KEY = Buffer.from(process.env.AES_KEY, 'hex'); // 32 bytes

// Encrypts a plaintext string, returns IV + ciphertext + authTag as hex
function encrypt(text) {
  const iv = crypto.randomBytes(12); // 12 bytes for GCM
  const cipher = crypto.createCipheriv(ALGORITHM, KEY, iv);

  let encrypted = cipher.update(text, 'utf8', 'hex');
  encrypted += cipher.final('hex');

  const tag = cipher.getAuthTag(); // 16 bytes

  // Concatenate IV + ciphertext + tag, all in hex
  return iv.toString('hex') + encrypted + tag.toString('hex');
}

// Decrypts combined IV + ciphertext + tag hex string
function decrypt(payloadHex) {
  const payload = Buffer.from(payloadHex, 'hex');

  const iv = payload.slice(0, 12); // First 12 bytes
  const tag = payload.slice(-16); // Last 16 bytes
  const ciphertext = payload.slice(12, -16); // Middle

  const decipher = crypto.createDecipheriv(ALGORITHM, KEY, iv);
  decipher.setAuthTag(tag);

  let decrypted = decipher.update(ciphertext, undefined, 'utf8');
  decrypted += decipher.final('utf8');

  return decrypted;
}

module.exports = {
  encrypt,
  decrypt,
};
