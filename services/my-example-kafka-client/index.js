const express = require('express');
const server = express();

server.get('/', (_request, response) => {
	response.send(`
		<h1>Hello from my kafka-clinet!</h1>
	`);
});
server.listen(process.env.PORT, () => {
	console.log(`Listening on port ${process.env.PORT}`);
});
