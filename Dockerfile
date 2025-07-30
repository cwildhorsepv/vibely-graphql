FROM node:20-slim

WORKDIR /app

# 🛠 Install CA management tools
RUN apt-get update && apt-get install -y ca-certificates

# 🔒 Copy the Neon root certificate and update trust
COPY ./neon-ca.pem /usr/local/share/ca-certificates/neon-ca.crt
RUN update-ca-certificates

# 🧠 Let Node use the trusted cert
ENV NODE_EXTRA_CA_CERTS=/usr/local/share/ca-certificates/neon-ca.crt

COPY ./print-env.sh /print-env.sh
RUN chmod +x /print-env.sh

EXPOSE 5000

CMD sh -c "/print-env.sh && postgraphile --connection '${DATABASE_URL}' --schema public --port 5000 --host 0.0.0.0 --enhance-graphiql --dynamic-json --retry-on-init-fail"
