Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 487917830E9
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 21:22:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYARu-0005JX-KC; Mon, 21 Aug 2023 15:20:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYARL-0005Ib-M6
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 15:19:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYARJ-0001pK-Kz
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 15:19:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692645589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R2+oblAeb9LWKlwrOaEhB2YBYPLABepbBzohYmzi6rU=;
 b=aw3vxU9oueg1oLG9dyQ0eMEoDNrjIDbhxaAMks7HCMC3CFIKlycfXDWgi5nEHIILGOE3Aw
 FYT00NDSK/3XPddqWFd9Y53UblUtqYxFwSXX4OVbSsALEzmkENowsfGtDmzcD6LrH1z0zl
 XvOEq1EzzJN7Dm7i67SpsDZ/SD/Wm80=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-170-F2nWquVEMtqcD_P72pQbOw-1; Mon, 21 Aug 2023 15:19:47 -0400
X-MC-Unique: F2nWquVEMtqcD_P72pQbOw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D6DC68D40A0;
 Mon, 21 Aug 2023 19:19:46 +0000 (UTC)
Received: from localhost (unknown [10.39.192.103])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6E3391121314;
 Mon, 21 Aug 2023 19:19:46 +0000 (UTC)
Date: Mon, 21 Aug 2023 11:17:20 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH 0/2] block-backend: process I/O in the current AioContext
Message-ID: <20230821151720.GA51352@fedora>
References: <20230815160521.3357063-1-stefanha@redhat.com>
 <ZN+NJvs0G4zvbOJB@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="BN4fNXU9f9sogSU9"
Content-Disposition: inline
In-Reply-To: <ZN+NJvs0G4zvbOJB@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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


--BN4fNXU9f9sogSU9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 18, 2023 at 05:24:22PM +0200, Kevin Wolf wrote:
> Am 15.08.2023 um 18:05 hat Stefan Hajnoczi geschrieben:
> > Switch blk_aio_*() APIs over to multi-queue by using
> > qemu_get_current_aio_context() instead of blk_get_aio_context(). This c=
hange
> > will allow devices to process I/O in multiple IOThreads in the future.
>=20
> Both code paths still use blk_aio_em_aiocb_info, which is:
>=20
>     static AioContext *blk_aio_em_aiocb_get_aio_context(BlockAIOCB *acb_)
>     {
>         BlkAioEmAIOCB *acb =3D container_of(acb_, BlkAioEmAIOCB, common);
>=20
>         return blk_get_aio_context(acb->rwco.blk);
>     }
>=20
>     static const AIOCBInfo blk_aio_em_aiocb_info =3D {
>         .aiocb_size         =3D sizeof(BlkAioEmAIOCB),
>         .get_aio_context    =3D blk_aio_em_aiocb_get_aio_context,
>     };
>=20
> .get_aio_context() is called by bdrv_aio_cancel(), which already looks
> wrong before this patch because in theory it can end up polling the
> AioContext of a different thread. After this patch, .get_aio_context()
> doesn't even necessarily return the AioContext that runs the request any
> more.
>=20
> The only thing that might save us is that I can't find any device that
> both supports iothreads and calls bdrv_aio_cancel(). But we shouldn't
> rely on that.
>=20
> Maybe the solution is to just remove .get_aio_context altogether and use
> AIO_WAIT_WHILE(NULL, ...) in bdrv_aio_cancel().

I will remove AIOCBInfo.get_aio_context in v2.

Stefan

--BN4fNXU9f9sogSU9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTjgAAACgkQnKSrs4Gr
c8jOVQf/V1fZZipr7UrvYByyIQ6IKXrpbrS7A0NTIzxhtZ8EQ8KQP+RWqJKvMigJ
Wo3Vy1QAK2EvnY45nLIfOJyj3PxSoOUW25iJTWZsfPXZOEeTwNQ4ownw3nnL1L7T
xtihh5AVmI69eZIqVlmUQuMqSBQ0RX2k+J51l/qM39EJg6864A4lKu+GXR0vyNSq
dDCGlbGodZMgu2zGo0jydp3mSDydE/kZICX3eOOHIcvnPO9Af5zWYCNNmUWifqU7
g95LmlpiMyk8qtQEt+3bnD+L/1J750CQOx0hdHuEdjsslT9rNdk9eUxqMS/1B64+
Iv0tonEegz8sLdcPY47HLYQ1W1pMSQ==
=lfyt
-----END PGP SIGNATURE-----

--BN4fNXU9f9sogSU9--


