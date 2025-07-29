FROM node:20

WORKDIR /app
RUN npm install -g postgraphile

CMD ["postgraphile", "-c", "$DATABASE_URL", "--schema", "public", "--watch", "--enhance-graphiql"]
