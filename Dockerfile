FROM amazon/aws-lambda-nodejs AS prod-dependencies

RUN npm install -g yarn

COPY package.json yarn.lock ./
RUN yarn install --production

FROM prod-dependencies AS build
RUN yarn install

COPY . .
RUN yarn compile

FROM amazon/aws-lambda-nodejs AS final
LABEL org.opencontainers.image.source=https://github.com/rmsy/apollo-server-lambda-example
COPY --from=build ${LAMBDA_TASK_ROOT}/dist/src/index.js* ./
COPY --from=prod-dependencies ${LAMBDA_TASK_ROOT}/node_modules ./node_modules/

CMD ["index.graphqlHandler"]
