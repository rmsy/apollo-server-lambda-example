FROM amazon/aws-lambda-nodejs AS build

RUN npm install -g yarn

COPY package.json yarn.lock ./
RUN yarn install

COPY . .
RUN yarn webpack

FROM amazon/aws-lambda-nodejs AS final
LABEL org.opencontainers.image.source=https://github.com/rmsy/apollo-server-lambda-example
COPY --from=build ${LAMBDA_TASK_ROOT}/dist/bundle.js* .
COPY --from=build ${LAMBDA_TASK_ROOT}/dist/*.map .

CMD ["bundle.graphqlHandler"]
