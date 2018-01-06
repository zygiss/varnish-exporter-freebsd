PORTNAME=	prometheus_varnish_exporter
PORTVERSION=	1.3.4
CATEGORIES=	www
PKGNAME=	varnish_exporter

MAINTAINER=	ports@zx23.net
COMMENT=	Varnish exporter for Prometheus

LICENSE=	APACHE20

USES=		go

USE_GITHUB=	yes

GH_ACCOUNT=     jonnenauha
GH_TUPLE=	prometheus:client_golang:v0.8.0:client_golang/src/github.com/prometheus/client_golang
GH_SUBDIR=	src/github.com/${GH_ACCOUNT_DEFAULT}/${PORTNAME}
#DIST_SUBDIR=    ${PKGNAMEPREFIX}${PORTNAME}

#CONFIGURE_ARGS=	--with-contrib=${WRKSRC_contrib}

#GH_ACCOUNT=	prometheus:client_golang
#GH_PROJECT=	prometheus_varnish_exporter:varnish_exporter

#GO_PKGNAME=	github.com/${GH_ACCOUNT}/prometheus_${PORTNAME}
#GO_TARGET=	github.com/${GH_ACCOUNT}/prometheus_${PORTNAME}

#USE_RC_SUBR=	varnish_exporter

STRIP=		# stripping can break go binaries

do-build:
	@cd ${WRKSRC}/src/github.com/${GH_ACCOUNT_DEFAULT}/${PORTNAME} && \
	    ${SETENV} ${MAKE_ENV} ${GOENV} ${GO_CMD} build -o bin/${PORTNAME}


do-install:
	${INSTALL_PROGRAM} ${WRKDIR}/bin/varnish_exporter ${STAGEDIR}/${PREFIX}/bin

.include <bsd.port.mk>
