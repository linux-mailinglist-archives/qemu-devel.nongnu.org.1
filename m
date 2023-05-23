Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D0A70E0EC
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 17:49:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1UGF-0000ms-6i; Tue, 23 May 2023 11:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q1UG2-0000Iy-8Q
 for qemu-devel@nongnu.org; Tue, 23 May 2023 11:49:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q1UFy-0006Ta-FP
 for qemu-devel@nongnu.org; Tue, 23 May 2023 11:49:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684856941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5vpY+wU+9PQ6HvioSmxsXPA1be3D4AKhGSK68roqb6M=;
 b=LCiAueVULDxs51sa+vAHgaz3iRFxkcBEektGLLzx8SqnUVZhF0iV2JOVbIO8vifWEVnhWS
 v1mQ82EXUmq6wpvIFXEz9iZ8EOe7+GeR/smCgzR0YM7hKLyfPvTB9wr8jwbFfANtyVRH1h
 XstfYfwy9DoyXUgVmqR2oCG3/yMgrd4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-392-49NU2e_DPTe9RRCFQW3Mrw-1; Tue, 23 May 2023 11:48:57 -0400
X-MC-Unique: 49NU2e_DPTe9RRCFQW3Mrw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 34381296A610;
 Tue, 23 May 2023 15:48:57 +0000 (UTC)
Received: from localhost (unknown [10.39.195.107])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8D68920296C6;
 Tue, 23 May 2023 15:48:56 +0000 (UTC)
Date: Tue, 23 May 2023 11:48:54 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org,
 Julia Suvorova <jusual@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>, Anthony Perard <anthony.perard@citrix.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 4/6] block/io_uring: convert to blk_io_plug_call() API
Message-ID: <20230523154854.GF96478@fedora>
References: <20230517221022.325091-1-stefanha@redhat.com>
 <20230517221022.325091-5-stefanha@redhat.com>
 <7xerljqzrhzvl73beu7dboq3d6jbxbkrxbhs25xzcw5ozopgbn@3olwj3w5fil5>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3aPiKHngEQMNjJoi"
Content-Disposition: inline
In-Reply-To: <7xerljqzrhzvl73beu7dboq3d6jbxbkrxbhs25xzcw5ozopgbn@3olwj3w5fil5>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--3aPiKHngEQMNjJoi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 18, 2023 at 07:18:42PM -0500, Eric Blake wrote:
> On Wed, May 17, 2023 at 06:10:20PM -0400, Stefan Hajnoczi wrote:
> > Stop using the .bdrv_co_io_plug() API because it is not multi-queue
> > block layer friendly. Use the new blk_io_plug_call() API to batch I/O
> > submission instead.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  include/block/raw-aio.h |  7 -------
> >  block/file-posix.c      | 10 ---------
> >  block/io_uring.c        | 45 ++++++++++++++++-------------------------
> >  block/trace-events      |  5 ++---
> >  4 files changed, 19 insertions(+), 48 deletions(-)
> >=20
>=20
> > @@ -337,7 +325,6 @@ void luring_io_unplug(void)
> >   * @type: type of request
> >   *
> >   * Fetches sqes from ring, adds to pending queue and preps them
> > - *
> >   */
> >  static int luring_do_submit(int fd, LuringAIOCB *luringcb, LuringState=
 *s,
> >                              uint64_t offset, int type)
> > @@ -370,14 +357,16 @@ static int luring_do_submit(int fd, LuringAIOCB *=
luringcb, LuringState *s,
>=20
> Looks a bit like a stray hunk, but you are touching the function, so
> it's okay.

I'm respinning, so I'll drop this.

Stefan

--3aPiKHngEQMNjJoi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmRs4GYACgkQnKSrs4Gr
c8ijKAf+IFPE85RQqY0hwYwn31qfIo8D9vIz8fpX/MAUGgNXWAh0uABXAhGO+6ug
JRVPu18OjoECTr9rVOFaoTkEiXqs26G+ArMJt6QdX9r5Z+4X09ub4z3cLnpRul9z
e5IUmsZaz2k0qrALqzJf3gUT1xqaVB4heIt5y8WUufxR5V/Cb/bkeMo86hZLiWv6
WT5C0iZy7GZbucPA3JEMiR20zoocHUbFZsqXa9SLdeNwKATYn6uEoXOwa2ZZVgUo
o1cdwDtSBMqQIpZXl4ZP0U5pePUNSZ6zlzkPCiq0eyBm2+C4HfAmvJqdlGHn6YsD
R6F3Gg2PCGTdSBtQtijctZkigpdZVg==
=Ofen
-----END PGP SIGNATURE-----

--3aPiKHngEQMNjJoi--


