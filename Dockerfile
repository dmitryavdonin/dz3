FROM golang:1.18-alpine AS builder
WORKDIR /app 
COPY go.mod ./
COPY go.sum ./
RUN go mod download
COPY *.go ./
COPY controllers ./controllers/
COPY initializers ./initializers/
COPY models ./models/
COPY routes ./routes/
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o user_service .


COPY migrate ./migrate/
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o migrate ./migrate/migrate.go

FROM scratch
COPY --from=builder /app/user_service /usr/bin/
COPY --from=builder /app/migrate /usr/bin/
EXPOSE 8000
CMD ["/usr/bin/user_service"]
