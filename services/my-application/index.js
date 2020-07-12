const express = require('express');
const server = express();

server.get('/', (_request, response) => {
	response.send('Hello world!');
});
server.listen(process.env.PORT, () => {
	console.log(`Listening on port ${process.env.PORT}`);
});
