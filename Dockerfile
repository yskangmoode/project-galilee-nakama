FROM heroiclabs/nakama:3.40.0

COPY modules /nakama/data/modules

ENTRYPOINT ["sh", "-ec"]
CMD ["/nakama/nakama migrate up --database.address \"$DATABASE_ADDRESS\" && exec /nakama/nakama --database.address \"$DATABASE_ADDRESS\" --socket.port \"${PORT:-7350}\""]
