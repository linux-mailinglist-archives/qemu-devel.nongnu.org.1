Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2A9711372
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 20:16:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2FVD-0007mK-RL; Thu, 25 May 2023 14:15:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q2FVB-0007ju-EZ
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:15:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q2FVA-0007Q2-2j
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:15:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685038550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s6Fmoy2BVoRvJSbd13h45v4mlwROYO/aQn+Jrd8vgZU=;
 b=eaYvPPlrEUDDsq5aPpZMHn+HqGqLcBwzjBsokcE+MFGaBrVKFBroGFwzOv1YG1hHds66kp
 fkgqk8AbrGKV6NL1TriSDT7NN1mrxEI6wTHiYe0YEmXTcxE0NPsEa5xkJd4Do266/ursLx
 vzhG6Ys4+ZT0jjAFm8Zw4nRPlhn3nao=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-219-zr3tV7sRN5CHp7ObQ4S8nQ-1; Thu, 25 May 2023 14:15:46 -0400
X-MC-Unique: zr3tV7sRN5CHp7ObQ4S8nQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6E2401C07553;
 Thu, 25 May 2023 18:15:46 +0000 (UTC)
Received: from localhost (unknown [10.39.192.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C5C5F492B0B;
 Thu, 25 May 2023 18:15:45 +0000 (UTC)
Date: Thu, 25 May 2023 14:15:44 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 01/12] block-coroutine-wrapper: Take AioContext lock in
 no_co_wrappers
Message-ID: <20230525181544.GC132697@fedora>
References: <20230525124713.401149-1-kwolf@redhat.com>
 <20230525124713.401149-2-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bHgTIdofVBbnfOr3"
Content-Disposition: inline
In-Reply-To: <20230525124713.401149-2-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


--bHgTIdofVBbnfOr3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 25, 2023 at 02:47:02PM +0200, Kevin Wolf wrote:
> All of the functions that currently take a BlockDriverState, BdrvChild
> or BlockBackend as their first parameter expect the associated
> AioContext to be locked when they are called. In the case of
> no_co_wrappers, they are called from bottom halves directly in the main
> loop, so no other caller can be expected to take the lock for them. This
> can result in assertion failures because a lock that isn't taken is
> released in nested event loops.
>=20
> Looking at the first parameter is already done by co_wrappers to decide
> where the coroutine should run, so doing the same in no_co_wrappers is
> only consistent. Take the lock in the generated bottom halves to fix the
> problem.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/block-common.h       |  3 +++
>  block/block-backend.c              |  7 ++++++-
>  scripts/block-coroutine-wrapper.py | 25 +++++++++++++++----------
>  3 files changed, 24 insertions(+), 11 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--bHgTIdofVBbnfOr3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmRvpc8ACgkQnKSrs4Gr
c8jkAgf/a2Y8YtdhOfp8GPygpB1ahi1PL2rEtevyItiSTcQgaT57IGXfi3oTwEHl
qFlPGSTgQ7WE9rFFeiCWf8Bu3JFdnFV+q9jR9NRZaSMd5t++vvUVgusv0OmHwpZR
lbUktutv9hPzngkiviD3TKhVqW1X/2QnPNEFgwJcGbkQpx7sU8tlRBFFQA+vno5E
MZ+CN9DML/B3pLfoZMXFwMNrD1jV8dqoKrTKbqhf1WBrgf4D5vFQqJUV1ikmmzB9
695SlpQbP+9bFTGfSegqLpYk0H+eATumgHc8K9wpMFjPEVzaluOeW47RVckpfxcw
huFa8m29nRiLREJ6FPB1gjjkmebRNQ==
=Na3z
-----END PGP SIGNATURE-----

--bHgTIdofVBbnfOr3--


