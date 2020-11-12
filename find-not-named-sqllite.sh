find . -not -name "*.sqlite*" -not -name "*.db" -not -name "*wal*" -exec file {} \; | grep SQLite
