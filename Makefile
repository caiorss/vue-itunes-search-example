# Install all NPM modules 
install:
	npm install 

# Create a production build 
build:
	yarn build 

run:
	yarn run

clean:
	rm -rf -v dist node_modules 