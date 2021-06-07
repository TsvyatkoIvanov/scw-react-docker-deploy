# pull official base image
FROM node:14.15.0-alpine as gg

# set working directory
WORKDIR /app

COPY . .

RUN npm ci --silent
RUN npm build

FROM nginx:stable-alpine
COPY --from=gg /app/build /usr/share/nginx/html
COPY --from=gg /app/nginx/nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]