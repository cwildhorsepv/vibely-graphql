# ./print-env.sh

#!/bin/bash
echo "🔍 Runtime environment variables:"
echo "--------------------------------"
printenv | sort
echo "--------------------------------"
