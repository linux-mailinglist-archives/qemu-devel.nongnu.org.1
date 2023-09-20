Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE2C7A8DB7
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 22:19:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj3f8-0001Y4-Vh; Wed, 20 Sep 2023 16:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qj3ez-0001Xl-Pz
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 16:18:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qj3ey-0006OL-09
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 16:18:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695241134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YVA0Gq+ZNYwpyPCl6WFxE14wp93+y4Oyc61/Kc6blsk=;
 b=U8XwFxGkXxAK6sqZKbJBSIZCzawscBy3xITJiF8HvjEMbwD4t2pwaSRJjmcBVwcESxy6cx
 rTnfhK/U5F6G8LotB+Ek2wXVnWIam3TyaozJ+zKclVxz85VVG3t+iFEYEESDBn/sR+VyDY
 n4StkE6hh6/EI/JNIdNNu4GrbfHPux8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-226-AOj1GyOGOnmbjQMh-ig1ig-1; Wed, 20 Sep 2023 16:18:51 -0400
X-MC-Unique: AOj1GyOGOnmbjQMh-ig1ig-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AAD061C04320;
 Wed, 20 Sep 2023 20:18:50 +0000 (UTC)
Received: from localhost (unknown [10.39.193.174])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 410F52156701;
 Wed, 20 Sep 2023 20:18:50 +0000 (UTC)
Date: Wed, 20 Sep 2023 16:18:48 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Mads Ynddal <mads@ynddal.dk>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Mads Ynddal <m.ynddal@samsung.com>
Subject: Re: [PATCH v4 11/14] simpletrace: move event processing to Analyzer
 class
Message-ID: <20230920201848.GJ1094271@fedora>
References: <20230823085429.20519-1-mads@ynddal.dk>
 <20230823085429.20519-12-mads@ynddal.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lTz+4EdxudB0mDSE"
Content-Disposition: inline
In-Reply-To: <20230823085429.20519-12-mads@ynddal.dk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--lTz+4EdxudB0mDSE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 10:54:26AM +0200, Mads Ynddal wrote:
> From: Mads Ynddal <m.ynddal@samsung.com>
>=20
> Moved event processing to the Analyzer class to separate specific analyzer
> logic (like caching and function signatures) from the _process function.
> This allows for new types of Analyzer-based subclasses without changing
> the core code.
>=20
> Note, that the fn_cache is important for performance in cases where the
> analyzer is branching away from the catch-all a lot. The cache has no
> measurable performance penalty.
>=20
> Signed-off-by: Mads Ynddal <m.ynddal@samsung.com>
> ---
>  scripts/simpletrace.py | 60 +++++++++++++++++++++++++-----------------
>  1 file changed, 36 insertions(+), 24 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--lTz+4EdxudB0mDSE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmULU6gACgkQnKSrs4Gr
c8hbfggAhi4hkgAKdgomHYq0FrlpQklaM2ECzBm7sIwOINrPjy7fx2yxTn89V/rE
WzLOsofCyMEKMwEGB5TM34UwUzw4Za1MGv09ZcumInycKdzi5m3XUqeZUx4n399w
DT8dbRxGdqp6TxHlkzx/qSqcwCcBTBLK7PW10/9bgaqIO27Uu06d7B0Cx5xsTU7L
oskKHzUrTOgXs9kgBCfsJe6HtfYTTpCXFyiSI3SV1SIh8zuYCgkptBdpJJnV12m3
Dsi5Esej1fKy/dZtIcyUXBjG7sTHRXXLXMjPJYgbH3tV5ybqFtQ9lEufeM9qSYU6
lOqguItA8CS+dZXcItgEWKIHO23JtQ==
=jmA2
-----END PGP SIGNATURE-----

--lTz+4EdxudB0mDSE--


