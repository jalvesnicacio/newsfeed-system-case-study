FROM node:boron

# Create an app directory
RUN mkdir -p /usr/src/simpleapi
WORKDIR /usr/src/simpleapi

# Install app dependencies
COPY package.json /usr/src/simpleapi
RUN npm install

# Bundle app source
COPY . /usr/src/simpleapi

# Expose the app port
EXPOSE 8080

CMD [ "npm", "start"]
