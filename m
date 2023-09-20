Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA897A8D7B
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 22:08:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj3Um-00059O-MV; Wed, 20 Sep 2023 16:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qj3Uk-000595-B8
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 16:08:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qj3Uh-0003ku-J5
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 16:08:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695240498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dBghQBwEQEa2Z9aQGGkQNLj/iLZNcAHbZdrD5Uu0IKs=;
 b=T75Ep+EGhvJxttFBOSu8qHAsbWfNgd2yZVeGEGSNgXhwHHGuuxHHznSPHG08qoBVcLqukO
 nZTdaMA/57lrbbnJatFkewzdKfSCZJq7l4gGnHeaLENxoQoLmVuUvFFvBAZtE03fe90kBH
 D7K7PDZtgZHYJmFcqrEQO+n/OCkbP6g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-83-crkVFnnZOjWkO7D5hkDayw-1; Wed, 20 Sep 2023 16:08:17 -0400
X-MC-Unique: crkVFnnZOjWkO7D5hkDayw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 898AD801779;
 Wed, 20 Sep 2023 20:08:16 +0000 (UTC)
Received: from localhost (unknown [10.39.193.174])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E18CF492C37;
 Wed, 20 Sep 2023 20:08:15 +0000 (UTC)
Date: Wed, 20 Sep 2023 16:08:14 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Mads Ynddal <mads@ynddal.dk>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Mads Ynddal <m.ynddal@samsung.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v4 07/14] simpletrace: define exception and add handling
Message-ID: <20230920200814.GF1094271@fedora>
References: <20230823085429.20519-1-mads@ynddal.dk>
 <20230823085429.20519-8-mads@ynddal.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="u4xKZEOTxB942ZuA"
Content-Disposition: inline
In-Reply-To: <20230823085429.20519-8-mads@ynddal.dk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--u4xKZEOTxB942ZuA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 10:54:22AM +0200, Mads Ynddal wrote:
> From: Mads Ynddal <m.ynddal@samsung.com>
>=20
> Define `SimpleException` to differentiate our exceptions from generic
> exceptions (IOError, etc.). Adapted simpletrace to support this and
> output to stderr.
>=20
> Signed-off-by: Mads Ynddal <m.ynddal@samsung.com>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>
> ---
>  scripts/simpletrace.py | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--u4xKZEOTxB942ZuA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmULUS0ACgkQnKSrs4Gr
c8hxewgAq4+CRYf+R5TVLK/U8cE8gtLtoky3fMgDxpbanqkIiK+ZMv/rrFa0eDVY
zyXttRq/Z45VtYUJGRiyUInX3jD7A9uVTPkyPUhfKp7llCAlYab71BcqtlxyK2BR
4y1f8ikIXfaF+F7tGqIOFqEau6nJxgfROQp6XlKiS1OklEDmbb4NiF44hlgDQRAi
lUY9EZi65Tjdn38QT8PGSNE5iWfaoM7hDCI9nfq9RwlIh0OQHu9F8XILY+lDBMFg
idBhz9iqUEMNMP5CVeI1A+QCS/YMHMvMh0T0IAaYrSA81xkXWKDyZ6g3+oo2x9y4
l1tYQQMF2BiSOuJatYlL9uZpPPkVaA==
=uxUD
-----END PGP SIGNATURE-----

--u4xKZEOTxB942ZuA--


