Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 453637A8DE4
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 22:39:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj3xM-00072i-FL; Wed, 20 Sep 2023 16:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qj3xJ-00070y-Iz
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 16:37:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qj3xG-0002DV-Mf
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 16:37:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695242269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=//Dr34Vm6C1uB6rZbjrxJAdC0uhXUbvm3rH3VOEi77w=;
 b=Fy1yocsdoIeVyyP2nW5H5Oq77gzSIM8Xxc9B3OeFtGE0L19T4xoSYUgjr08dic8vKhEcHT
 181FN9huWqt7HSKWPsXfFf0pAvYPO5PXFL9CFgNlP0UhPgcQk42Me0iRnYL9ykBb7Lw35D
 IFn42HsB96JpyiWgGL+ODOCsm14GSuw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-628-Akwi14iSOSelxHPOZ1llpw-1; Wed, 20 Sep 2023 16:37:47 -0400
X-MC-Unique: Akwi14iSOSelxHPOZ1llpw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A1644101A550;
 Wed, 20 Sep 2023 20:37:46 +0000 (UTC)
Received: from localhost (unknown [10.39.193.174])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 030C220268CC;
 Wed, 20 Sep 2023 20:37:45 +0000 (UTC)
Date: Wed, 20 Sep 2023 16:37:44 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Mads Ynddal <mads@ynddal.dk>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Mads Ynddal <m.ynddal@samsung.com>
Subject: Re: [PATCH v4 13/14] MAINTAINERS: add maintainer of simpletrace.py
Message-ID: <20230920203744.GM1094271@fedora>
References: <20230823085429.20519-1-mads@ynddal.dk>
 <20230823085429.20519-14-mads@ynddal.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9D0AB1bDTdkN0kmC"
Content-Disposition: inline
In-Reply-To: <20230823085429.20519-14-mads@ynddal.dk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--9D0AB1bDTdkN0kmC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 10:54:28AM +0200, Mads Ynddal wrote:
> From: Mads Ynddal <m.ynddal@samsung.com>
>=20
> In my work to refactor simpletrace.py, I noticed that there's no
> maintainer of it, and has the status of "odd fixes". I'm using it from
> time to time, so I'd like to maintain the script.
>=20
> I've added myself as reviewer under "Tracing" to be informed of changes
> that might affect simpletrace.py.

I treat simpletrace.py as part of the tracing subsystem but it is
missing from the MAINTAINERS file.

You're welcome to be the maintainer. I haven't touched it in years.

When you have reviewed future simpletrace.py patches you can either post
your Reviewed-by and I'll include them in my tracing pull requests, or
you could send pull requests to the qemu.git maintainer yourself
(requires publishing a GPG key and signing pull request tags).

Please let me know which option you prefer.

> Signed-off-by: Mads Ynddal <m.ynddal@samsung.com>
> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6111b6b4d9..2ffb608dec 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3162,6 +3162,7 @@ F: stubs/
> =20
>  Tracing
>  M: Stefan Hajnoczi <stefanha@redhat.com>
> +R: Mads Ynddal <mads@ynddal.dk>
>  S: Maintained
>  F: trace/
>  F: trace-events
> @@ -3174,6 +3175,11 @@ F: docs/tools/qemu-trace-stap.rst
>  F: docs/devel/tracing.rst
>  T: git https://github.com/stefanha/qemu.git tracing
> =20
> +Simpletrace
> +M: Mads Ynddal <mads@ynddal.dk>
> +S: Maintained
> +F: scripts/simpletrace.py
> +
>  TPM
>  M: Stefan Berger <stefanb@linux.ibm.com>
>  S: Maintained
> --=20
> 2.38.1
>=20

--9D0AB1bDTdkN0kmC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmULWBgACgkQnKSrs4Gr
c8gfWwgAgZQSub4qBLR4SgCrelCsq3wsTTTmjUbLhK9nwQCOmgnT6PjYmuEnFCHY
pIFsO79KcrXVcQjpsxTOttI+56M+TG1TRYTsieqMCrtiMPLBUTVJaUMByqI1+ONm
i9yHzwmqS4wxlDKYNQ+AqhBUAwvptgUG7Spl9Lbujt6SSrbb9BqeREsV7z8wpQC3
vZnFE0UFRRh64j5Phr5DZwZ7phxvVD+NRsqWgqZ5t0H/KJwSKqr7qgR8bqvvR6GQ
m2UNpvcbYc08BI4TKccMAoZRcmMAYn9VYCdFPhFWEYh+CS3gfQsNR1QoYuyPV7Tv
CD1TgaVUEosyaHPY9jCks6nAVzYp4w==
=R7sL
-----END PGP SIGNATURE-----

--9D0AB1bDTdkN0kmC--


