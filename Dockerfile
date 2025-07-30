FROM node:20-slim

WORKDIR /app

RUN npm install -g postgraphile

COPY ./neon-ca.pem /neon-ca.pem
COPY ./print-env.sh /print-env.sh
RUN chmod +x /print-env.sh



COPY ./print-env.sh /print-env.sh
RUN chmod +x /print-env.sh

EXPOSE 5000

# 🚨 Accept self-signed certs (development use only!)


CMD sh -c "/print-env.sh && postgraphile --connection '${DATABASE_URL}&sslrootcert=/neon-ca.pem' --schema public --port 5000 --host 0.0.0.0 --enhance-graphiql --dynamic-json --retry-on-init-fail"
