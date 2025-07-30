FROM node:20-slim

WORKDIR /app

RUN npm install -g postgraphile

COPY ./print-env.sh /print-env.sh
RUN chmod +x /print-env.sh

EXPOSE 5000

CMD sh -c "/print-env.sh && postgraphile --connection '${DATABASE_URL}' --schema public --port 5000 --enhance-graphiql --dynamic-json --retry-on-init-fail"
