# FROM node:12

# WORKDIR /app

# COPY . .

# RUN yarn install

# EXPOSE 3000

# CMD ["yarn", "start"]


# STAGE 1

FROM node:12-alpine AS build

WORKDIR /app

COPY . .

RUN yarn install

CMD ["yarn", "build:prod"]


# STAGE 2

FROM node:12-alpine

WORKDIR /app

COPY --from=build /app/package.json .
COPY --from=build /app/dist ./dist

EXPOSE 3000

CMD ["yarn", "start:prod"]