# Running the example

I've already pushed an image that you can run just by using the below:
```bash
docker run -p 9000:8080 ghcr.io/rmsy/apollo-server-lambda-example
```

You can then make a call to the lambda container with the following:
```bash
curl -X POST -H 'Content-Type: application/json' -d '{"query":"query Query {\n  hello\n}\n"}' "http://localhost:9000/2015-03-31/functions/function/invocations"
```

That should reproduce the error referenced in my GitHub issue.