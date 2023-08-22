Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72678784979
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 20:43:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYWKD-0004Af-G1; Tue, 22 Aug 2023 14:41:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYWK0-00044w-2W
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 14:41:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYWJy-00085z-0a
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 14:41:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692729701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/3PZRAQFytwLbvAuiDekJz9xgmkxXQESXZOOnb1A+hY=;
 b=Ma/cooP8e6d5IwhSBv9E+/0iHevi8Sq/SsYLTWk0NTGQi/98lo9T1mr/rde0W6q1qJlk+Z
 dsAzpppf4Uaf0NVaxAiQouNm8eiy1QX1h1wZyJUJyBSbhCwND9DCVdXYKxomTe5fPX10Pa
 DPlT8TpsbTkW/WcyMBcHwupeA5y86FQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-ahjMq9H9M6Sz2fbKrVKGlw-1; Tue, 22 Aug 2023 14:41:36 -0400
X-MC-Unique: ahjMq9H9M6Sz2fbKrVKGlw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 84723101A59D;
 Tue, 22 Aug 2023 18:41:36 +0000 (UTC)
Received: from localhost (unknown [10.39.195.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E1EDF64661;
 Tue, 22 Aug 2023 18:41:35 +0000 (UTC)
Date: Tue, 22 Aug 2023 14:41:34 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, eesposit@redhat.com,
 pbonzini@redhat.com, vsementsov@yandex-team.ru, qemu-devel@nongnu.org
Subject: Re: [PATCH 03/21] preallocate: Don't poll during permission updates
Message-ID: <20230822184134.GF727224@fedora>
References: <20230817125020.208339-1-kwolf@redhat.com>
 <20230817125020.208339-4-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="zbWJqbEty2mkFLlU"
Content-Disposition: inline
In-Reply-To: <20230817125020.208339-4-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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


--zbWJqbEty2mkFLlU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2023 at 02:50:02PM +0200, Kevin Wolf wrote:
> When the permission related BlockDriver callbacks are called, we are in
> the middle of an operation traversing the block graph. Polling in such a
> place is a very bad idea because the graph could change in unexpected
> ways. In the future, callers will also hold the graph lock, which is
> likely to turn polling into a deadlock.
>=20
> So we need to get rid of calls to functions like bdrv_getlength() or
> bdrv_truncate() there as these functions poll internally. They are
> currently used so that when no parent has write/resize permissions on
> the image any more, the preallocate filter drops the extra preallocated
> area in the image file and gives up write/resize permissions itself.
>=20
> In order to achieve this without polling in .bdrv_check_perm, don't
> immediately truncate the image, but only schedule a BH to do so. The
> filter keeps the write/resize permissions a bit longer now until the BH
> has executed.
>=20
> There is one case in which delaying doesn't work: Reopening the image
> read-only. In this case, bs->file will likely be reopened read-only,
> too, so keeping write permissions a bit longer on it doesn't work. But
> we can already cover this case in preallocate_reopen_prepare() and not
> rely on the permission updates for it.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/preallocate.c | 89 +++++++++++++++++++++++++++++++++++----------
>  1 file changed, 69 insertions(+), 20 deletions(-)

I don't know the permissions code well enough, but the patch matches the
commit description:

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>

--zbWJqbEty2mkFLlU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTlAV4ACgkQnKSrs4Gr
c8iPcQgAkf200RL8oZXFI+m+JLoOeKlrvhlOgMOgHu8aUyYArqboPFziEPDBPeE/
kkyKvhCcQGnEjKSk2nOfYeWYGyo0AFscMturvr9kcnlU1ftwPT8xl/ruaXAYTCUU
fqXbANPA8TvnAZ5BKMKJh4VGmKK49WsaL2xUF9ncslEQMkjCLzNcccOFcb8XwZg1
Ki3Pomp5plHb04MwyQZu/gyekWo2Ob8AQCaFf1S7M6jUHL3BFeThP0Ij0CMUv2KY
aDxrlH6Ma/UJaSLJcZwhJiCk48+LA0fHZIKnVqz9BJKFVRCuYg4mi/7ZIYQrnFrT
vfvlJSeXwMRbnAsJyfDJ1iqru6QP0w==
=deuM
-----END PGP SIGNATURE-----

--zbWJqbEty2mkFLlU--


