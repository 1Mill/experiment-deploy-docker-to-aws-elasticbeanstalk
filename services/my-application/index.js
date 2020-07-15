const express = require('express');
const server = express();

server.get('/', (_request, response) => {
	response.send('Release to production!');
});
server.listen(process.env.PORT, () => {
	console.log(`Listening on port ${process.env.PORT}`);
});
