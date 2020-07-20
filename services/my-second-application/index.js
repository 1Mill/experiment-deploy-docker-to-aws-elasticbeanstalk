const express = require('express');
const server = express();

server.get('/', (_request, response) => {
	response.send(`
		<h1>Hello world from my-second-application!!</h1>
		This is a new new message that should be in production!
		sdfsdfsfsdfsdsdfdsfsd
	`);
});
server.listen(process.env.PORT, () => {
	console.log(`Listening on port ${process.env.PORT}`);
});
