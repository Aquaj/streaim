# Streaim

Basic Rails app to stream files from the disk to clients, hidden behind a basic HTTP auth.
Auth is provided through env var STREAM_PASSWORD. Files are to be stored at `app/assets/audiobooks`.

Deployed through Capistrano.
