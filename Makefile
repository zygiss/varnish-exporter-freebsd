PORTNAME=		prometheus_varnish_exporter
PORTVERSION=		1.4
CATEGORIES=		www
PKGNAME=		varnish_exporter

MAINTAINER=		ports@zx23.net
COMMENT=		Prometheus metrics exporter for the Varnish WWW cache

LICENSE=		APACHE20

USES=			go
GH_ACCOUNT=		jonnenauha
USE_GITHUB=		yes
GH_TUPLE=		prometheus:client_golang:v0.8.0:client_golang \
			prometheus:client_model:6f38060:client_model \
			prometheus:common:49fee29:common \
			beorn7:perks:4c0e845:perks \
			golang:protobuf:2bba060:protobuf \
			matttproud:golang_protobuf_extensions:c12348c:golang_protobuf_extensions \
			prometheus:procfs:a1dba9c:procfs

GO_PKGNAME=		github.com/${GH_ACCOUNT}/${PORTNAME}

USE_RC_SUBR=		varnish_exporter

USERS=			varnish
GROUPS=			varnish

PLIST_FILES=		bin/varnish_exporter

pre-build:
	echo ${WRKSRC_client_golang}
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
