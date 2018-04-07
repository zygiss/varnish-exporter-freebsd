# Created by: Žygis Škulteckis <ports@zx23.net>
# $FreeBSD$

PORTNAME=		varnish_exporter
PORTVERSION=		1.4
CATEGORIES=		www

MAINTAINER=		ports@zx23.net
COMMENT=		Prometheus metrics exporter for the Varnish WWW cache

LICENSE=		APACHE20

USES=			go
USE_GITHUB=		yes

GH_ACCOUNT=		jonnenauha
GH_PROJECT=		prometheus_varnish_exporter
GH_TUPLE=		prometheus:client_golang:v0.8.0:client_golang \
			beorn7:perks:3a771d99:perks \
			golang:protobuf:bbd03ef6:protobuf \
			matttproud:golang_protobuf_extensions:c12348ce:golang_protobuf_extensions \
			prometheus:client_model:99fa1f4b:client_model \
			prometheus:common:e4aa40a9:common \
			prometheus:procfs:780932d4:procfs

GO_PKGNAME=		github.com/${GH_ACCOUNT}/${GH_PROJECT}

USE_RC_SUBR=		${PORTNAME}

USERS=			varnish
GROUPS=			varnish

PLIST_FILES=		bin/${PORTNAME}

pre-build:
	${MKDIR} ${GO_WRKDIR_SRC}/github.com/beorn7
	${MKDIR} ${GO_WRKDIR_SRC}/github.com/golang
	${MKDIR} ${GO_WRKDIR_SRC}/github.com/matttproud
	${MKDIR} ${GO_WRKDIR_SRC}/github.com/prometheus
	${MV} ${WRKSRC_client_golang} ${GO_WRKDIR_SRC}/github.com/prometheus/client_golang
	${MV} ${WRKSRC_client_model} ${GO_WRKDIR_SRC}/github.com/prometheus/client_model
	${MV} ${WRKSRC_common} ${GO_WRKDIR_SRC}/github.com/prometheus/common
	${MV} ${WRKSRC_perks} ${GO_WRKDIR_SRC}/github.com/beorn7/perks
	${MV} ${WRKSRC_procfs} ${GO_WRKDIR_SRC}/github.com/prometheus/procfs
	${MV} ${WRKSRC_protobuf} ${GO_WRKDIR_SRC}/github.com/golang/protobuf
	${MV} ${WRKSRC_golang_protobuf_extensions} ${GO_WRKDIR_SRC}/github.com/matttproud/golang_protobuf_extensions

do-install:
	${INSTALL_PROGRAM} ${GO_WRKDIR_BIN}/prometheus_varnish_exporter ${STAGEDIR}${PREFIX}/bin/varnish_exporter

.include <bsd.port.mk>
