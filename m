Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C395F7A8DE7
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 22:40:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj3zi-0000qW-NA; Wed, 20 Sep 2023 16:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qj3zZ-0000op-1n
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 16:40:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qj3zN-0002Zc-Oa
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 16:40:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695242400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ie849IlGeOJzceZgBOcN3c272S9Qsw//UA5G6N1qey0=;
 b=EBhW4SeUM+TC8O6lWg/x/25emHASzbLqOarvuSLx4qPPb7uN2365UIv6II/AzijO1LUB9+
 +iHyzN9zzD4VaIyr210sdcVTvBcRnfIsUT2xzigVsBICT0LbjUbBYc5WAtR6/mThp1bjps
 OYlZCxH1lCu7xhyC5fFnQUK430Exkh4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-413-Z7893-C0P_mlskDtgYT6Uw-1; Wed, 20 Sep 2023 16:39:57 -0400
X-MC-Unique: Z7893-C0P_mlskDtgYT6Uw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AEB463800BB7;
 Wed, 20 Sep 2023 20:39:56 +0000 (UTC)
Received: from localhost (unknown [10.39.193.174])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4394C40C6EBF;
 Wed, 20 Sep 2023 20:39:56 +0000 (UTC)
Date: Wed, 20 Sep 2023 16:39:54 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Mads Ynddal <mads@ynddal.dk>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Mads Ynddal <m.ynddal@samsung.com>
Subject: Re: [PATCH v4 00/14] simpletrace: refactor and general improvements
Message-ID: <20230920203954.GO1094271@fedora>
References: <20230823085429.20519-1-mads@ynddal.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="y6LLDfal3qIIuqxA"
Content-Disposition: inline
In-Reply-To: <20230823085429.20519-1-mads@ynddal.dk>
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


--y6LLDfal3qIIuqxA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 10:54:15AM +0200, Mads Ynddal wrote:
> From: Mads Ynddal <m.ynddal@samsung.com>
>=20
> I wanted to use simpletrace.py for an internal project, so I tried to upd=
ate
> and polish the code. Some of the commits resolve specific issues, while s=
ome
> are more subjective.

Hi Mads,
Apologies for the very late review. I'm happy with this series except
for the zip file and unused Formatter2 class. Please drop them and
resend.

Thanks,
Stefan

>=20
> I've tried to divide it into commits so we can discuss the
> individual changes, and I'm ready to pull things out, if it isn't needed.
>=20
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
>  scripts/simpletrace-benchmark.zip    | Bin 0 -> 4809 bytes
>  scripts/simpletrace.py               | 362 ++++++++++++++++++---------
>  4 files changed, 247 insertions(+), 123 deletions(-)
>  create mode 100644 scripts/simpletrace-benchmark.zip
>=20
> --=20
> 2.38.1
>=20

--y6LLDfal3qIIuqxA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmULWJoACgkQnKSrs4Gr
c8gwIQf+Nc1EubSWNe+p5urgXGLZRCRuciYhnniu03M9ExIAZ4/Z4TaHCkvrsfTg
hUTLqoMJhAwnEhGuCcNZpivJvgJjY0i86+oaGfTXCMMCEttMmmsqD+F7keUkHU0U
Nnui8DN9zluyXXZBUFrFB/hTv+D9rRY2fQc8j4B0V6ZS6yX8UAqdv6mSebAlR2I4
m3G4h/eO0msi4fg9vXt9gSiZ5EpxOG8o0AQZWV3ZEBaonEfQmJzPBj/61JKgoBrV
RxvXDn2bPbybib4ssjRReTpCJ8HwVIsKfZxP99VG1HCwqXpHBZi5CcU2HLLH8BUB
leF3ELH8GPfux4nzvqlf9MqJRo+h6w==
=rcoI
-----END PGP SIGNATURE-----

--y6LLDfal3qIIuqxA--


