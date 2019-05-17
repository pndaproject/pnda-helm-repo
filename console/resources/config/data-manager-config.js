module.exports = {
    whitelist: ['http://data-service:7000', 'http://deployment-manager:5000'],
  deployment_manager: {
    host: "http://deployment-manager:5000",
    API: {
      endpoints: "/environment/endpoints",
      packages_available: "/repository/packages?recency=999",
      packages: "/packages",
      applications: "/applications"
    }
  },
  dataset_manager: {
      host: "http://data-service:7000",
    API: {
     datasets: "/api/v1/datasets"
    }
  },
  session: {
    secret: "data-manager-secret",
    max_age: 86400000,
    session_expiry_warning_duration: 30000
  }
};
