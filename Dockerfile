FROM node:20-slim

WORKDIR /app

# 🛠 Install required system packages and CA tools
RUN apt-get update && apt-get install -y \
    ca-certificates \
    curl \
    && rm -rf /var/lib/apt/lists/*

# 🔒 Add the trusted Neon RDS cert bundle
COPY ./global-bundle.pem /usr/local/share/ca-certificates/neon-ca.crt
RUN update-ca-certificates

# ✅ Let Node trust the CA
ENV NODE_EXTRA_CA_CERTS=/usr/local/share/ca-certificates/neon-ca.crt

# 🧠 Install PostGraphile globally
RUN npm install -g postgraphile

# 🧪 Optional debug script
COPY ./print-env.sh /print-env.sh
RUN chmod +x /print-env.sh

EXPOSE 5000

CMD sh -c "/print-env.sh && postgraphile --connection '${DATABASE_URL}' --schema public --port 5000 --host 0.0.0.0 --enhance-graphiql --dynamic-json --retry-on-init-fail"
