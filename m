Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5D97AF0CB
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 18:33:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlAz3-0004CA-MF; Tue, 26 Sep 2023 12:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qlAys-00042Y-7f
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:32:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qlAyq-00083Y-G7
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:32:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695745931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qd0P4BZygGhOfESDFjgn23Agx48dcZ0j/PN5ITnMN6o=;
 b=LkCfZ5Mkj2nwC8qQQEHMqeNrMk8zMTSm9oieGOgjpxt6/ibR8WIYdFS2w1OjrNabd1Jkg4
 scGV8lhzdjvifgQ53AZjSwhO5eJURr9McMBhefx3optrD7KX15QlvF+9NkXWqsC2vyHLw9
 H0TOkaLb6zFpkCIaDFdXhRCczzNWIco=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-533-a2tT2OrcMNGZvofjs1A3Xg-1; Tue, 26 Sep 2023 12:32:08 -0400
X-MC-Unique: a2tT2OrcMNGZvofjs1A3Xg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 958A52823811;
 Tue, 26 Sep 2023 16:32:07 +0000 (UTC)
Received: from localhost (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 081F440C6EA8;
 Tue, 26 Sep 2023 16:32:06 +0000 (UTC)
Date: Tue, 26 Sep 2023 12:32:04 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Mads Ynddal <mads@ynddal.dk>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Mads Ynddal <m.ynddal@samsung.com>
Subject: Re: [PATCH v5 00/14] simpletrace: refactor and general improvements
Message-ID: <20230926163204.GB323273@fedora>
References: <20230926103436.25700-1-mads@ynddal.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="FnCSNLbpAWEqXnt6"
Content-Disposition: inline
In-Reply-To: <20230926103436.25700-1-mads@ynddal.dk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--FnCSNLbpAWEqXnt6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 26, 2023 at 12:34:22PM +0200, Mads Ynddal wrote:
> From: Mads Ynddal <m.ynddal@samsung.com>
>=20
> I wanted to use simpletrace.py for an internal project, so I tried to upd=
ate
> and polish the code. Some of the commits resolve specific issues, while s=
ome
> are more subjective.
>=20
> I've tried to divide it into commits so we can discuss the
> individual changes, and I'm ready to pull things out, if it isn't needed.
>=20
> v5:
>  * Picked Formatter2 over Formatter, as to not use the deprecated class
>  * simpletrace-benchmark.zip deleted
>  * Rebased with master
> v4:
>  * Added missing Analyzer2 to __all__
>  * Rebased with master
> v3:
>  * Added __all__ with public interface
>  * Added comment about magic numbers and structs from Stefan Hajnoczi
>  * Reintroduced old interface for process, run and Analyzer
>  * Added comment about Python 3.6 in ref. to getfullargspec
>  * process now accepts events as file-like objects
>  * Updated context-manager code for Analyzer
>  * Moved logic of event processing to Analyzer class
>  * Moved logic of process into _process function
>  * Added new Analyzer2 class with kwarg event-processing
>  * Reverted changes to process-call in scripts/analyse-locks-simpletrace.=
py
> v2:
>  * Added myself as maintainer of simpletrace.py
>  * Improve docstring on `process`
>  * Changed call to `process` in scripts/analyse-locks-simpletrace.py to r=
eflect new argument types
>  * Replaced `iteritems()` with `items()` in scripts/analyse-locks-simplet=
race.py to support Python 3
>=20
> Mads Ynddal (14):
>   simpletrace: add __all__ to define public interface
>   simpletrace: annotate magic constants from QEMU code
>   simpletrace: improve parsing of sys.argv; fix files never closed.
>   simpletrace: changed naming of edict and idtoname to improve
>     readability
>   simpletrace: update code for Python 3.11
>   simpletrace: improved error handling on struct unpack
>   simpletrace: define exception and add handling
>   simpletrace: made Analyzer into context-manager
>   simpletrace: refactor to separate responsibilities
>   simpletrace: move logic of process into internal function
>   simpletrace: move event processing to Analyzer class
>   simpletrace: added simplified Analyzer2 class
>   MAINTAINERS: add maintainer of simpletrace.py
>   scripts/analyse-locks-simpletrace.py: changed iteritems() to items()
>=20
>  MAINTAINERS                          |   6 +
>  scripts/analyse-locks-simpletrace.py |   2 +-
>  scripts/simpletrace.py               | 382 +++++++++++++++++----------
>  3 files changed, 246 insertions(+), 144 deletions(-)
>=20
> --=20
> 2.38.1
>=20

Thanks, applied to my tracing tree:
https://gitlab.com/stefanha/qemu/commits/tracing

Stefan

--FnCSNLbpAWEqXnt6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUTB4QACgkQnKSrs4Gr
c8i5aQgAkGbYvajPLf50IUEud6RstMRe0gMryEW8iiDWeLS0e0SIh6oN4dx0G4FH
twa595+xSiPzbbES5CikjLD/1BGIB1WsjeXR3LruP6xyCVgZyHUyOP1CR4gO7lL7
cWFNAe6hMs0zMfyVWNOyv3bP2E9iCuKKM0dAMtE8RHiRt8bm47SSb6PafmfIS+8U
U8yAGqjhCv6fQrFOdbERTBsFtIrhfX7pqAjQGKgJ9QoVAH0tSzFZhzWHwmpaH6/E
uqL+j71kHfzP88zhJQFD/dQ2nrV06++tm8rnuaFI19EUIucv5EIsa9eDcCAg6Jb+
cmo5chz2/p0IrKBRx3MBuCGK+q7lgg==
=7m7O
-----END PGP SIGNATURE-----

--FnCSNLbpAWEqXnt6--


