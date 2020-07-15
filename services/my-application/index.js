const express = require('express');
const server = express();

server.get('/', (_request, response) => {
	response.send('CI/CDelivery is a real thing!');
});
server.listen(process.env.PORT, () => {
	console.log(`Listening on port ${process.env.PORT}`);
});
