FROM golang:1.22.5 AS builder

WORKDIR /app

# Copy go mod and sum files

COPY go.mod .

RUN go mod download

COPY . .

RUN go build -o main .

#final stage -Distroless image

FROM gcr.io/distroless/base

COPY --from=builder /app/main .
COPY --from=builder /app/static ./static

EXPOSE 8080

CMD ["./main"]