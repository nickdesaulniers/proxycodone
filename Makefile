default:
	coffee -o . -c src/app.coffee

run: default
	node app.js

