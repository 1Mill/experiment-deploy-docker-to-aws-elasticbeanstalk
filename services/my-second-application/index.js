const express = require('express');
const server = express();

server.get('/', (_request, response) => {
	response.send(`
		<h1>Hello world from my-second-application!!</h1>
		klsdjflksdf
	`);
});
server.listen(process.env.PORT, () => {
	console.log(`Listening on port ${process.env.PORT}`);
});
