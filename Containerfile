FROM --platform=linux/amd64 golang:1.26.4-trixie AS build
# Specify working directory to override base image's default of /go and ensure
# reproducible builds.
WORKDIR /src
COPY go.mod ./
COPY main.go ./
# Build Go binary in a reproducible way:
# CGO_ENABLED=0: produce pure-Go static binary with no dependency on host's
#     C toolchain
# -trimpath: strip absolute filesystem paths out of the binary
# -buildvcs=false: prevent adding VCS data (e.g. git commit hash, dirty flag)
#     to the binary
# -ldflags="-buildid=": bland build ID
RUN CGO_ENABLED=0 \
    go build -trimpath -buildvcs=false -ldflags="-buildid=" -o /rofl-go-starter .

FROM scratch
COPY --from=build /rofl-go-starter /rofl-go-starter
ENTRYPOINT ["/rofl-go-starter"]
