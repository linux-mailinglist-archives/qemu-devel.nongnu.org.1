Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9894E7A8DAD
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 22:17:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj3dF-0000Az-DG; Wed, 20 Sep 2023 16:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qj3dC-0000Ao-5W
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 16:17:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qj3d8-0005tM-QN
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 16:17:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695241021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YD5PF9IOgmLlm0u++GklLVyNES74ylLnJJoqSMMS26E=;
 b=WanWzRB8X/CcKVzdGFf9zqU3jQ4Hii0AkpNbhjlynBHMu9jzYDDB1ql3qR0qloaB5nHbrr
 +R7Fibyy5owo0qF+9QUXCV9Mb7qMamjVGCdsFHCApevcBiTGf/hpbEAtjDVn8Jne8KSlXo
 Bsblln+QefMZz/itRJPw8Kw4Tza0jPk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-433-Lm9GJ7XCNn2PsD1ejNavsQ-1; Wed, 20 Sep 2023 16:16:59 -0400
X-MC-Unique: Lm9GJ7XCNn2PsD1ejNavsQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A6E363C01DF3;
 Wed, 20 Sep 2023 20:16:58 +0000 (UTC)
Received: from localhost (unknown [10.39.193.174])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3CC32140E953;
 Wed, 20 Sep 2023 20:16:58 +0000 (UTC)
Date: Wed, 20 Sep 2023 16:16:56 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Mads Ynddal <mads@ynddal.dk>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Mads Ynddal <m.ynddal@samsung.com>
Subject: Re: [PATCH v4 10/14] simpletrace: move logic of process into
 internal function
Message-ID: <20230920201656.GI1094271@fedora>
References: <20230823085429.20519-1-mads@ynddal.dk>
 <20230823085429.20519-11-mads@ynddal.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9mFXNz69+hDW+IEx"
Content-Disposition: inline
In-Reply-To: <20230823085429.20519-11-mads@ynddal.dk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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


--9mFXNz69+hDW+IEx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 10:54:25AM +0200, Mads Ynddal wrote:
> From: Mads Ynddal <m.ynddal@samsung.com>
>=20
> To avoid duplicate code depending on input types and to better handle
> open/close of log with a context-manager, we move the logic of process in=
to
> _process.
>=20
> Signed-off-by: Mads Ynddal <m.ynddal@samsung.com>
> ---
>  scripts/simpletrace.py | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--9mFXNz69+hDW+IEx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmULUzgACgkQnKSrs4Gr
c8i/iAgAj2cnw0CZm/JhUL5dU6cchG6voQ7D4MghMZoLjT6Du3/3mt039p/sw0RA
qJGGxC8SlHH3lrg39KwX+lBfKFxUbIQAPyNF3mGJLggPDq0GZmf875dUmwLi4pUm
yfVxa0SsZiPA8rgKzFrKHOUeTC//p8YQDh8L4PiZqAsb5TL2QXqw1UNu2RmARObi
SB+NRSzTnyNzZcRaFWfJOeAoqDf5DnjJcEpELIJ5kgI6ghKAgq0u/luHj0FhgFdT
+W2gznQtZ0L1DzGLTIYWmAWE7Pl/P0Rwxyei2QSLsvgZrLpYguxLjkLnkWofvJrJ
lFw6eP18W6c8WDQFNPdJZFoVpYbYNQ==
=wGAc
-----END PGP SIGNATURE-----

--9mFXNz69+hDW+IEx--


