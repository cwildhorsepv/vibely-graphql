FROM node:20-slim

WORKDIR /app

RUN npm install -g postgraphile

COPY ./neon-ca.pem /usr/local/share/ca-certificates/neon-ca.crt
RUN update-ca-certificates

ENV NODE_EXTRA_CA_CERTS=/usr/local/share/ca-certificates/neon-ca.crt

EXPOSE 5000

# 🚨 Accept self-signed certs (development use only!)


CMD sh -c "/print-env.sh && postgraphile \
    --connection '${DATABASE_URL}' \
    --schema public \
    --port 5000 \
    --host 0.0.0.0 \
    --enhance-graphiql \
    --dynamic-json \
    --retry-on-init-fail"
