****INFO

readinessProbe:
  httpGet: # make an HTTP request
    port: 8080 # port to use
    path: /readiness # endpoint to hit
    scheme: HTTP # or HTTPS
  initialDelaySeconds: 3 # how long to wait before checking
  periodSeconds: 3 # how long to wait between checks
  successThreshold: 1 # how many successes to hit before accepting
  failureThreshold: 1 # how many failures to accept before failing
  timeoutSeconds: 1
