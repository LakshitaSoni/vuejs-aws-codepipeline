#Build Vue application
FROM node:20-alpine AS build

#sets the working directory.
WORKDIR /app

#The dependency files are copied
COPY package*.json ./

#Dependencies are installed
RUN npm ci

#Vue source code is copied
COPY . .

#the production build is created
RUN npm run build
#This generates: /app/dist

#The second stage uses Nginx
FROM nginx:alpine

#Vue production(dist) files are copied
COPY --from=build /app/dist /usr/share/nginx/html

#Nginx then serves the Vue application on port 80
EXPOSE 80

#This starts Nginx.
CMD ["nginx", "-g", "daemon off;"]