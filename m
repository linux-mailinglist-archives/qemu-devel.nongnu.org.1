Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 646807B3271
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 14:25:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmCX6-0002YJ-E5; Fri, 29 Sep 2023 08:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qmCX0-0002XJ-91
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 08:23:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qmCWo-0002N6-0I
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 08:23:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695990206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9zPjaxFCqOoeAUY03LTYieD5Jr7UZk+YI8Vvkkzyam4=;
 b=X8vLnv206fRYzUI/RpWisLOwjyTU2gNnSIyjwKC5eJm+UfwdxpIo2ij76RDDzB/P0vIFab
 YXEHOfb7d3FJyZciVVKYVrKjUUDx/q7gCF6zkhMh+wfoR5BJc9tGozGNuy5Ns1rCysYCsZ
 DOAKDdikNg2xaJ4S66ZnogtyQJtGpz8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-359-srxi6RPbPDOcFaNheUG8cQ-1; Fri, 29 Sep 2023 08:23:24 -0400
X-MC-Unique: srxi6RPbPDOcFaNheUG8cQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4AFC73800C5A
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 12:23:24 +0000 (UTC)
Received: from localhost (unknown [10.45.225.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D5C352026D4B;
 Fri, 29 Sep 2023 12:23:23 +0000 (UTC)
Date: Fri, 29 Sep 2023 14:23:22 +0200
From: Victor Toso <victortoso@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v1 2/9] qapi: golang: Generate qapi's alternate types in Go
Message-ID: <b6kkamv3owggxi4vthdrqxrlcplbykp5cnnb7lihll7buv5kda@py5hclv6oqjc>
References: <20230927112544.85011-1-victortoso@redhat.com>
 <20230927112544.85011-3-victortoso@redhat.com>
 <ZRWTBpWn4m3rrGMZ@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ohhzu7xyvoab26kl"
Content-Disposition: inline
In-Reply-To: <ZRWTBpWn4m3rrGMZ@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org


--ohhzu7xyvoab26kl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 28, 2023 at 03:51:50PM +0100, Daniel P. Berrang=E9 wrote:
> On Wed, Sep 27, 2023 at 01:25:37PM +0200, Victor Toso wrote:
> > This patch handles QAPI alternate types and generates data structures
> > in Go that handles it.
>=20
> This file (and most others) needs some imports added.
> I found the following to be required in order to
> actually compile this:

This was by design, I mean, my preference. I decided that the
generator should output correct but not necessarly
formatted/buildable Go code. The consumer should still use
gofmt/goimports.

Do you think we should do this in QEMU? What about extra
dependencies in QEMU with go binaries?

This is how it is done in victortoso/qapi-go module:

# to generate
    toso@tapioca ~> QEMU_REPO=3D/home/toso/src/qemu go generate ./...

# the generation
    toso@tapioca ~> cat src/qapi-go/pkg/qapi/doc.go
    //go:generate ../../scripts/generate.sh
    //go:generate gofmt -w .
    //go:generate goimports -w .
    package qapi

# script
    URL=3D"https://gitlab.com/victortoso/qemu.git"
    BRANCH=3D"qapi-golang"

    if [[ -z "${QEMU_REPO}" ]]; then
        git clone --depth 1 --branch $BRANCH $URL
        QEMU_REPO=3D"$PWD/qemu"
    fi

    python3 $QEMU_REPO/scripts/qapi-gen.py -o tmp $QEMU_REPO/qapi/qapi-sche=
ma.json
    mv tmp/go/* .
    rm -rf tmp qemu

Cheers,
Victor

> alternates.go:import (
> alternates.go-	"encoding/json"
> alternates.go-	"errors"
> alternates.go-	"fmt"
> alternates.go-)
>=20
>=20
> commands.go:import (
> commands.go-	"encoding/json"
> commands.go-	"errors"
> commands.go-	"fmt"
> commands.go-)
>=20
>=20
> events.go:import (
> events.go-	"encoding/json"
> events.go-	"errors"
> events.go-	"fmt"
> events.go-)
>=20
>=20
> helpers.go:import (
> helpers.go-	"encoding/json"
> helpers.go-	"fmt"
> helpers.go-	"strings"
> helpers.go-)
>=20
>=20
> structs.go:import (
> structs.go-	"encoding/json"
> structs.go-)
>=20
>=20
> unions.go:import (
> unions.go-	"encoding/json"
> unions.go-	"errors"
> unions.go-	"fmt"
> unions.go-)
>=20
>=20
>=20
>=20
> With regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>=20

--ohhzu7xyvoab26kl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEIG07NS9WbzsOZXLpl9kSPeN6SE8FAmUWwboACgkQl9kSPeN6
SE/jvBAAsI6EQa+kT2fen6Om+ZOC5RMmDNSo4NTxMx110WCWgWuVSq/6E3A0K2FU
qSPXD1W7KT3HvggahoVTLt6RIJZfn7+aLCezYHRcc1wS3uvmau9pdFDEPILRLvlP
s/DxAW91XYwNmLDXKg2bOHdjfe0ofUFiuVPvSjZSwGtBOR2a4U+PuO5Z/PEoY4kx
5RwFt+M+MOu3FDAx5NeS70Q1MSEBfApLWE8JBro4iyzYQqNDUUiQ+G0kY2HbCsSg
UK8oxV93l4YnEUiU5O7xPq1Ih/rB0MyyvAtyWQ2mRVuKcabMfgjBv5UTGzsg8bhj
kqop4tes6vbdloXomKNnjzFK8nMLGrmlGts2/p0o1QeRzqqfJmh74Z31BoHS7T7S
JHpq4X/tuzYWOO8Ctpkm873WST5GGTwCqQqpKmf5PeI/dsRZHO/+I2ZroDUMbbZL
n7r2Vgj0zTALw9Y/Z8pS0AGYp/qEYeP5B9uCBRiXfPdLqhkqgIaWdrGN+whkGxYV
wqX/+Pgs+BvsBtTotB4C/QrIxcjeJLQz8wmNoQNUxeIGSRSG+2s0eXbyCjxq9zlo
1xEvzVsieYqaAyCLobLW6TYNJylqRGfFe+GaoHxA3Yko2bA45nfvlIoiRSLNwHM1
q5LppWnUhbK4UbOFvsUcD/UX3EfiJcmjpHWJ/2g9DjpUCjOZ0To=
=Ndgl
-----END PGP SIGNATURE-----

--ohhzu7xyvoab26kl--


