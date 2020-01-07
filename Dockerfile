# build folder will be created into the /app Working Directory
# /app/build     <-- all the build files in the builder Phase, the folder with all production assets

# builder Block / Phase  - each Block / Phase has only 1 FROM statement
FROM node:alpine as builder
WORKDIR '/app'
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# nginx Block / Phase  - each Block / Phase has only 1 FROM statement
FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html