local ddb = import 'ddb.docker.libjsonnet';

local domain = std.join('.', [std.extVar("core.domain.sub"), std.extVar("core.domain.ext")]);

ddb.Compose() {
    "services": {
        "nginx": ddb.Image("nginx")
            + ddb.VirtualHost("80", domain, "app", certresolver="letsencrypt", redirect_to_https=true)
            + {
                volumes: [
                    "./public:/var/www/html",
		    "./nginx.conf:/etc/nginx/conf.d/default.conf:rw",
                ],
                restart: "unless-stopped",
	    },
    }
}
