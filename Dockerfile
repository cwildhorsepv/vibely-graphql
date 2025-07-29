# Use a lightweight Node.js image
FROM node:20-alpine

# Set working directory
WORKDIR /app

# Install PostGraphile globally
RUN npm install -g postgraphile

# Expose default PostGraphile port
EXPOSE 5000

COPY ./print-env.sh /print-env.sh
RUN chmod +x /print-env.sh

ENTRYPOINT ["/print-env.sh", "&&"]

# Default command
CMD sh -c "postgraphile --connection '$${DATABASE_URL}?sslmode=require' --schema public --port 5000 --enhance-graphiql --dynamic-json"

