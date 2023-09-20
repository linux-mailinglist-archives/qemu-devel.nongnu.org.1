Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D1B7A8DE5
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 22:39:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj3yB-0007NH-3T; Wed, 20 Sep 2023 16:38:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qj3y7-0007MW-V2
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 16:38:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qj3y6-0002QQ-L5
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 16:38:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695242322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dUidejR+x2XL/+Jcj3CfV9oco/NZNZo+9Znjpa9hyRI=;
 b=GyhoqETvWtFNEeEe4Jvoru6QzQg4WqOApscjmePFAJwt0W7wlmWUdJn3gOADO12/J7gDrf
 KXiqHTvemYAGwzMv3X3E1TUdbwgW197V3+2Ii+GPH5jtD6c914nq7MgZjAbeeKyzmzYE1R
 3vwOieWHG0A24FH+4T3V/ypEmUUCNus=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-192-kIcGN2gPN5u1yHGHC3w8wg-1; Wed, 20 Sep 2023 16:38:37 -0400
X-MC-Unique: kIcGN2gPN5u1yHGHC3w8wg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E7B80101A585;
 Wed, 20 Sep 2023 20:38:36 +0000 (UTC)
Received: from localhost (unknown [10.39.193.174])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5AAE92156702;
 Wed, 20 Sep 2023 20:38:36 +0000 (UTC)
Date: Wed, 20 Sep 2023 16:38:35 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Mads Ynddal <mads@ynddal.dk>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Mads Ynddal <m.ynddal@samsung.com>
Subject: Re: [PATCH v4 14/14] scripts/analyse-locks-simpletrace.py: changed
 iteritems() to items()
Message-ID: <20230920203835.GN1094271@fedora>
References: <20230823085429.20519-1-mads@ynddal.dk>
 <20230823085429.20519-15-mads@ynddal.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="s3/cfrGXb2oPz/42"
Content-Disposition: inline
In-Reply-To: <20230823085429.20519-15-mads@ynddal.dk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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


--s3/cfrGXb2oPz/42
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 10:54:29AM +0200, Mads Ynddal wrote:
> From: Mads Ynddal <m.ynddal@samsung.com>
>=20
> Python 3 removed `dict.iteritems()` in favor of `dict.items()`. This
> means the script curerntly doesn't work on Python 3.
>=20
> Signed-off-by: Mads Ynddal <m.ynddal@samsung.com>
> ---
>  scripts/analyse-locks-simpletrace.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--s3/cfrGXb2oPz/42
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmULWEsACgkQnKSrs4Gr
c8gi/AgAtieBMPilKmT7HS0VosbU4pHWAYyvlvTenl4Z4chqEj0MI/7pQz+F3Uwy
CYVJs+n6znCGGThckQX7hTUsywh8qsjxo0DNXXqK7xa9QuC2x6Uxv74Lhv3nPcDu
34B/YqmdrAlpJYqdO3uuOv4BjlK93AaTj1SDzZDHIL1ya7rrk895LXPofolqFIJ3
WL3Qk7NZH3wqvQpRQcs0rN87pwUGvI/5Vsyh851Ma161MGXa4f/2phfBGyTAhEWZ
95HgPlzXZQvjSY8EfLCpdvzlVhOgA+6In4WhSNrRFyHEzNQ8Up40t07K7dmVx9+g
fcy3ziNjoPca7cafq4RPFfnjLrmNgA==
=giy7
-----END PGP SIGNATURE-----

--s3/cfrGXb2oPz/42--


