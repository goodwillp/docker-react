# builder is a tag assigned with the keyword 'as'. This is for the builder phase
FROM node:alpine as builder
# Creates work directory
WORKDIR '/app'
# copy package.json file to that work directory
COPY package.json .
RUN npm install
# Copy all source code. Unlike .Dev file, we don't have to worry about skipping large volume systems
COPY . .
RUN npm run build

#/app/build <--- all the stuff for the application

#Each block can only have 1 FROM statement...
FROM nginx
#POrt to expose from AWS
EXPOSE 80
# --from copy something from a previous phase
#this default command starts nginx
COPY --from=builder /app/build /usr/share/nginx/html