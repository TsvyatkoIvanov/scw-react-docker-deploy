# pull official base image
FROM node:14.15.4

# set working directory
WORKDIR /app

COPY . .

RUN npm ci --silent
RUN npm build

FROM nginx:stable-alpine
COPY --from=build /app/build /usr/share/nginx/html
COPY --from=build /app/nginx/nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]