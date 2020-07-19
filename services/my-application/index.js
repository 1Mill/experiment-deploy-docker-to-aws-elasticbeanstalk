const express = require('express');
const server = express();

server.get('/', (_request, response) => {
	response.send(`
		<h1>Hello world from a PR request!</h1>
		CI/CDelivery is a real thing!
		<p>${process.env.MY_EXAMPLE_INJECTED_SECRET_KEY}</p>
		This is a new message that should be in production!
	`);
});
server.listen(process.env.PORT, () => {
	console.log(`Listening on port ${process.env.PORT}`);
});
