# Use a lightweight Node.js base image
FROM node:20-alpine

# Set working directory
WORKDIR /app

# Install PostGraphile globally
RUN npm install -g postgraphile

# Expose the port PostGraphile will run on
EXPOSE 5000

# Run PostGraphile using the environment-provided DATABASE_URL
CMD sh -c "postgraphile \\
  --connection \"$DATABASE_URL\" \\
  --schema public \\
  --port 5000 \\
  --watch \\
  --enhance-graphiql \\
  --dynamic-json"
