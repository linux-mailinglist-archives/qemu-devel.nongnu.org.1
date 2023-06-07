Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5421726864
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 20:21:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6xlV-0005ht-Mw; Wed, 07 Jun 2023 14:20:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q6xlQ-0005hZ-Hp
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 14:20:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q6xlH-0003js-ME
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 14:20:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686161998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+z0bNS7zjXVRbTFmbk2AwD6VB/uU2xivRbGDEhZeC9s=;
 b=UlgFCpSCY4q2TgPKT7lvAKg3Y1PpLPS2eB7hYtz04VDYaLuy/nf7nM/HcOspKcLmdovIDN
 /ifkpcxUSDRQ3UQQALLGV4c6Qb3umQ0qQTu7NyLm3eEejrF70OGJ2RLhKrN0ofV1HWrVmd
 88LN8uehaCwk7s7ovCcZXhA85oq67wY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-668-gQwtCI1dMyKC4U0fcf7wIg-1; Wed, 07 Jun 2023 14:19:56 -0400
X-MC-Unique: gQwtCI1dMyKC4U0fcf7wIg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7ACC5380213D;
 Wed,  7 Jun 2023 18:19:55 +0000 (UTC)
Received: from localhost (unknown [10.39.192.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F36B1407DEC0;
 Wed,  7 Jun 2023 18:19:54 +0000 (UTC)
Date: Wed, 7 Jun 2023 12:08:42 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org, dlemoal@kernel.org, dmitry.fomichev@wdc.com,
 hare@suse.de, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 2/2] block/file-posix: fix wps checking in raw_co_prw
Message-ID: <20230607160842.GE2138915@fedora>
References: <20230604061658.49004-1-faithilikerun@gmail.com>
 <20230604061658.49004-2-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="G4CQk9M61XIKDciX"
Content-Disposition: inline
In-Reply-To: <20230604061658.49004-2-faithilikerun@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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


--G4CQk9M61XIKDciX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 04, 2023 at 02:16:58PM +0800, Sam Li wrote:
> If the write operation fails and the wps is NULL, then accessing it will
> lead to data corruption.
>=20
> Solving the issue by adding a nullptr checking in get_zones_wp() where
> the wps is used.
>=20
> This issue is found by Peter Maydell using the Coverity Tool (CID
> 1512459).
>=20
> Signed-off-by: Sam Li <faithilikerun@gmail.com>
> ---
>  block/file-posix.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 0d9d179a35..620942bf40 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -1340,6 +1340,10 @@ static int get_zones_wp(BlockDriverState *bs, int =
fd, int64_t offset,
>      rep_size =3D sizeof(struct blk_zone_report) + nrz * sizeof(struct bl=
k_zone);
>      g_autofree struct blk_zone_report *rep =3D NULL;
> =20
> +    if (!wps) {
> +        return -1;
> +    }

An error will be printed every time this happens on a non-zoned device:

  static void update_zones_wp(BlockDriverState *bs, int fd, int64_t offset,
                              unsigned int nrz)
  {
      if (get_zones_wp(bs, fd, offset, nrz, 0) < 0) {
          error_report("update zone wp failed");

Please change the following code to avoid the call to update_zones_wp():

  #if defined(CONFIG_BLKZONED)
  {
      BlockZoneWps *wps =3D bs->wps;
      if (ret =3D=3D 0) {
          if ((type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND))
              && wps && bs->bl.zone_size) {
              uint64_t *wp =3D &wps->wp[offset / bs->bl.zone_size];
              if (!BDRV_ZT_IS_CONV(*wp)) {
                  if (type & QEMU_AIO_ZONE_APPEND) {
                      *s->offset =3D *wp;
                      trace_zbd_zone_append_complete(bs, *s->offset
                          >> BDRV_SECTOR_BITS);
                  }
                  /* Advance the wp if needed */
                  if (offset + bytes > *wp) {
                      *wp =3D offset + bytes;
                  }
              }
          }
      } else {
-         if (type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) {
+         if (wps && (type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND))) {
              update_zones_wp(bs, s->fd, 0, 1);
          }
      }

Stefan

--G4CQk9M61XIKDciX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmSAq4oACgkQnKSrs4Gr
c8iyWQgAmTWjLPhlVog6SkBPkVZN1SMNmImPPQ+dxvRuGwpPTmIYCZH71SbUPCkP
Ku9Xre0pfhkMS/qhnWefiCqWzYaknI1wfiVoCnk3lJKhQ6OPzEgNqB4pn0XtMsqj
2xRnbpDopsDuSyafjB/qOBMyW+sqlLTcCP2NqkB+OcQMb45x+2YXvn4CFw3iAwkE
DOC9uKB+FwNp7Xy3CibUqrrivcjRIhiP29AJBcY1PDWfsUXWQplAUOw+wPXGku5P
8yB/8ZOl7ShpKruvpPbAmr1NvwpC4vjTZz7vXZqFPtsUIOgfzb70VZIsD9cr7gjX
+y8tElwnf3Ksvh6V2BM9csyoEmhcBQ==
=wHv9
-----END PGP SIGNATURE-----

--G4CQk9M61XIKDciX--


