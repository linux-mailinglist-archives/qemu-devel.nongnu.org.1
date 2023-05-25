Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADAC9711616
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 20:53:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2G4H-0008Sm-II; Thu, 25 May 2023 14:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q2G4F-0008Ro-9A
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:52:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q2G4D-0006iU-Pi
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:52:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685040724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FPvKe8RVVS5AlAaAy2kcDKKj1lhIhDe/2pSnS/pBjYs=;
 b=cQyTMC0LXV4OBlLxjGrOnxdbtT5JUPH/rrepaT5dUJvjNFWcgy3iK7kPiXOJ3PTsDRzmdQ
 ljr6odJd+MYAMrN9xGXOmoWUqwzvQYO+52wlB5Lkh3Do4rIEr7ZjYTuxzyirJwaKriuHig
 T0n1SW/GFeH4N9qEZMxfkcRmLWTmT2I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-106-Az76419zO3O-uir_HBCPvA-1; Thu, 25 May 2023 14:52:02 -0400
X-MC-Unique: Az76419zO3O-uir_HBCPvA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7D2A4858F0F;
 Thu, 25 May 2023 18:52:02 +0000 (UTC)
Received: from localhost (unknown [10.39.192.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E0E7F1121314;
 Thu, 25 May 2023 18:52:01 +0000 (UTC)
Date: Thu, 25 May 2023 14:52:00 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 07/12] raw-format: Fix open with 'file' in iothread
Message-ID: <20230525185200.GI132697@fedora>
References: <20230525124713.401149-1-kwolf@redhat.com>
 <20230525124713.401149-8-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="k5Hll2F9RGQfijPP"
Content-Disposition: inline
In-Reply-To: <20230525124713.401149-8-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--k5Hll2F9RGQfijPP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 25, 2023 at 02:47:08PM +0200, Kevin Wolf wrote:
> When opening the 'file' child moves bs to an iothread, we need to hold
> the AioContext lock of it before we can call raw_apply_options() (and
> more specifically, bdrv_getlength() inside of it).
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/raw-format.c               | 5 +++++
>  tests/unit/test-block-iothread.c | 3 ---
>  2 files changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--k5Hll2F9RGQfijPP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmRvrlAACgkQnKSrs4Gr
c8iDMwf/XRqOhN7YbOiRiS3eTopkGiJaSUN+ziHok5uEvMWjc1SpmRMWDw3Ilax9
WDpMGY4/dVLmFz123cSZqq+NnPGM6nD9YKG8QUFZPJMme11burXekhC1KdtVdw3F
o/lOcZYgV57klyRzv0o9AIhJKPTHdjVDYlISBNpxNgCV9klJP44myKTndXxLhtgU
u+pDRBVpR1YkyNAiWms9w5FXpTHdB0636aG1Xr5ULR7SyxKTf/95jpJU7a1rIJET
LBy/+Td49SSP13O0fj4X0Bye2nT2laOvOo0Rnluxj7c3cjgHOTV3PJGB8wd2T2Nm
DrfWgY5i09IINEpsSOTaj9h5LCozMw==
=KphQ
-----END PGP SIGNATURE-----

--k5Hll2F9RGQfijPP--


