FROM node:22

WORKDIR /app

COPY . .

RUN apt-get update && apt-get install -y jq

RUN curl -L https://foundry.paradigm.xyz | bash && \
    . ~/.bashrc && \
    foundryup && \
    forge install

RUN find /app/script -type f -name "*.sh" -exec chmod +x {} \;

ENV PATH="/root/.foundry/bin:$PATH"

CMD ["sh", "-c", "echo Please verify the environment variables and command."]