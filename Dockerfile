FROM amazon/aws-lambda-nodejs AS build

RUN npm install -g yarn

COPY package.json yarn.lock ./
RUN yarn install

COPY . .
RUN yarn webpack

FROM build AS final
COPY --from=build ${LAMBDA_TASK_ROOT}/dist/bundle.js* .
COPY --from=build ${LAMBDA_TASK_ROOT}/*.map .

CMD ["bundle.graphqlHandler"]
