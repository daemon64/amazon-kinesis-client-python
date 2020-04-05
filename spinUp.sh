#!/bin/bash

sed -i '7s@@'"$STREAM_NAME"'@' /code/samples/sample.properties
sed -i '12s@PythonKCLSample@'"$APPLICATION_NAME"'@' /code/samples/sample.properties
sed -i '18s@DefaultAWSCredentialsProviderChain@'"$AWS_CREDENTIALS_PROVIDER"'@' /code/samples/sample.properties
sed -i '26s@TRIM_HORIZON@'"$INITIAL_POSITION_IN_STREAM"'@' /code/samples/sample.properties
sed -i '32s@#@'""'@' /code/samples/sample.properties
sed -i '32s@us-east-1@'"$REGION_NNAME"'@' /code/samples/sample.properties

cat /samples/sample.properties

amazon_kclpy_helper.py --print_command --java $JAVA_PATH --properties /samples/sample.properties