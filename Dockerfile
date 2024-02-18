FROM node:16-alpine as builder
RUN mkdir -p /home/node/app
WORKDIR /home/node/app

COPY --chown=node:node package.json ./
RUN npm i

COPY --chown=node:node ./ ./
RUN npm run build

# We are using nginx image to serve static content
# We are copying just build folder from previous stage i.e builder and ignoring everything else
FROM nginx
COPY --from=builder /home/node/app/build /usr/share/nginx/html
