FROM node:20-slim

WORKDIR /app

# 🛠 Install system certs (for Heroku SSL trust)
RUN apt-get update && apt-get install -y \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# ✅ Refresh trusted certs
RUN update-ca-certificates

# 🧠 Install PostGraphile globally
RUN npm install -g postgraphile

# 🧪 Optional: Debug environment print script
COPY ./print-env.sh /print-env.sh
RUN chmod +x /print-env.sh

# 📦 Expose GraphQL port
EXPOSE 5000

# 🚀 Start PostGraphile
CMD sh -c "/print-env.sh && postgraphile --connection '${DATABASE_URL}' --schema public --port 5000 --host 0.0.0.0 --enhance-graphiql --dynamic-json --retry-on-init-fail"
