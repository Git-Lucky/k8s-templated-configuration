apiVersion: admissionregistration.k8s.io/v1beta1
kind: MutatingWebhookConfiguration
metadata:
  name: k8s-webhook-webhook
  labels:
    app: k8s-webhook-webhook
    kind: mutator
webhooks:
  - name: all-mark-webhook.slok.dev
    clientConfig:
      service:
        name: k8s-webhook
        namespace: k8s-webhook
        path: /wh/mutating/allmark
      caBundle: CA_BUNDLE
    rules:
      - operations: ["CREATE", "UPDATE"]
        apiGroups: ["*"]
        apiVersions: ["*"]
        resources: ["deployments", "daemonsets", "cronjobs", "jobs", "statefulsets", "pods"]

  - name: service-monitor-safer.slok.dev
    clientConfig:
      service:
        name: k8s-webhook
        namespace: k8s-webhook
        path: /wh/mutating/safeservicemonitor
      caBundle: CA_BUNDLE
    rules:
      - operations: ["CREATE", "UPDATE"]
        apiGroups: ["monitoring.coreos.com"]
        apiVersions: ["v1"]
        resources: ["servicemonitors"]

---
apiVersion: admissionregistration.k8s.io/v1beta1
kind: ValidatingWebhookConfiguration
metadata:
  name: k8s-webhook-webhook
  labels:
    app: k8s-webhook-webhook
    kind: validator
webhooks:
  - name: ingress-validation-webhook.slok.dev
    clientConfig:
      service:
        name: k8s-webhook
        namespace: k8s-webhook
        path: /wh/validating/ingress
      caBundle: CA_BUNDLE
    rules:
      - operations: ["CREATE", "UPDATE"]
        apiGroups: ["*"]
        apiVersions: ["*"]
        resources: ["ingresses"]
