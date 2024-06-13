FROM node
COPY cars.json .
RUN npm install -g json-server
EXPOSE 3000
CMD ["json-server", "--watch", "cars.json", "--host", "0.0.0.0"]
