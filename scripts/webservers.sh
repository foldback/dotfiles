# webservers.sh

# Start a PHP server from a directory, optionally specifying the port
# (Requires PHP 5.4.0+.)
phpserver() {
  local port="${1:-4000}"
  local ip=$(ipconfig getifaddr en0)
  sleep 1 && open "http://${ip}:${port}/" &
  php -S "${ip}:${port}"
}

# Start an HTTP server from a directory, optionally specifying the port
httpserver() {
  local port="${1:-8000}"
  sleep 1 && open "http://localhost:${port}/" &
  # Set the default Content-Type to `text/plain` instead
  # of `application/octet-stream`, and serve everything as UTF-8
  # While technically incorrect, it doesn’t break anything for binary files
  python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\n\map[""] = "text/plain";\nfor key, value in map.items():\n\t\map[key] = value + ";charset=UTF-8";\n\SimpleHTTPServer.test();' "$port";
}
