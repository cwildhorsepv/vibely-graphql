#!/bin/sh
echo "🔍 Runtime environment variables:"
echo "--------------------------------"
echo "DATABASE URL:"
echo "$DATABASE_URL"
echo "🔍 Confirming presence of trusted cert:"
ls -l /usr/local/share/ca-certificates/neon-ca.crt || echo "❌ Cert file missing!"

echo "🔍 Cert contents:"
head /usr/local/share/ca-certificates/neon-ca.crt || echo "❌ Cannot read cert file!"

echo "--------------------------------"
