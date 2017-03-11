module.exports = {
  /**
   * Application configuration section
   * http://pm2.keymetrics.io/docs/usage/application-declaration/
   */
  apps : [

    // First application
    {
      name      : "lnc-server",
      script    : "index.js",
      watch     : true,
      instances : 0,
      exec_mode : "cluster",
      env_production : {
        NODE_ENV: "production"
      }
    }
  ],

  /**
   * Deployment section
   * http://pm2.keymetrics.io/docs/usage/deployment/
   */
  deploy : {
    production : {
      user : "root",
      host : "localhost",
      ref  : "origin/master",
      repo : "https://github.com/raphapr/lnc-challenge.git",
      path : "/var/www/production",
      "post-deploy" : "cd src && npm install && pm2 startOrRestart ecosystem.config.js --env production"
    }
  }
}
