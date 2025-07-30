FROM node:20-slim

WORKDIR /app

# 🛠 Install required system packages
RUN apt-get update && apt-get install -y \
    ca-certificates \
    curl \
    && rm -rf /var/lib/apt/lists/*

# 🧠 Install PostGraphile globally
RUN npm install -g postgraphile

# 🧪 Optional: print env vars for debugging
COPY ./print-env.sh /print-env.sh
RUN chmod +x /print-env.sh

EXPOSE 5000

CMD sh -c "/print-env.sh && postgraphile --connection '${DATABASE_URL}' --schema public --port 5000 --host 0.0.0.0 --enhance-graphiql --dynamic-json --retry-on-init-fail"
