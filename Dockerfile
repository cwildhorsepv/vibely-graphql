FROM node:20

WORKDIR /app

# 🛠 Install required system packages
RUN apt-get update && apt-get install -y \
    ca-certificates \
    curl \
    && rm -rf /var/lib/apt/lists/*

# ✅ PostGraphile CLI install
RUN npm install -g postgraphile

# 🧪 Optional debug script (still helpful)
COPY ./print-env.sh /print-env.sh
RUN chmod +x /print-env.sh

# 📦 Copy project files (optional if needed)
# COPY . .

EXPOSE 5000

# 🧠 Trust default system certs (no extra config needed)
CMD sh -c "/print-env.sh && postgraphile --connection '${DATABASE_URL}' --schema public --port 5000 --host 0.0.0.0 --enhance-graphiql --dynamic-json --retry-on-init-fail"
