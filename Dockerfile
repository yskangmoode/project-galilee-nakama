FROM heroiclabs/nakama:3.40.0
COPY modules /nakama/data/modules
ENTRYPOINT ["sh", "-ec"]
CMD ["nakama migrate up --database.address \"$DATABASE_ADDRESS\" && exec nakama --database.address \"$DATABASE_ADDRESS\""]
