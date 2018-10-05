const {
  events
} = require("brigadier");

events.on('exec', () => {
  console.log('hello world!');
});
