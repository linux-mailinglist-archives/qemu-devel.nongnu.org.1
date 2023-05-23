Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C7A70E0EB
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 17:49:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1UGH-0000y5-5G; Tue, 23 May 2023 11:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q1UG8-0000Uq-Tq
 for qemu-devel@nongnu.org; Tue, 23 May 2023 11:49:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q1UG6-0006XK-Mz
 for qemu-devel@nongnu.org; Tue, 23 May 2023 11:49:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684856949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rQ6nlvqTSvY4+s9JAwczIEJjWTozdr3kOea/XsYr2bY=;
 b=GJlRY0SvP2gsaiCUoeKpq6a/E055d0f7MYZfeAOJ7LxdHTEAwLxScGR5lMcaB/hdcC0ja2
 3o8zllLve+HutQnf178XZGTmvGTOembQ+s3HT7cw9UShPKMKfZy5LXfU3sLfsUTtJfaL13
 G/kRkErZXP1kcprvYyqhMd4KaUDIpZc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-22-ydMYk082PL-T9DEkukad9A-1; Tue, 23 May 2023 11:48:48 -0400
X-MC-Unique: ydMYk082PL-T9DEkukad9A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8706629AA3B0;
 Tue, 23 May 2023 15:48:20 +0000 (UTC)
Received: from localhost (unknown [10.39.195.107])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 06F37C5146F;
 Tue, 23 May 2023 15:48:19 +0000 (UTC)
Date: Tue, 23 May 2023 11:48:18 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org,
 Julia Suvorova <jusual@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>, Anthony Perard <anthony.perard@citrix.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 3/6] block/blkio: convert to blk_io_plug_call() API
Message-ID: <20230523154818.GE96478@fedora>
References: <20230517221022.325091-1-stefanha@redhat.com>
 <20230517221022.325091-4-stefanha@redhat.com>
 <wtyut5kd4v5vapon7fzpvi3kghvpplokcas5ovcwnjhiwyuccb@rm6eb6jjhhp5>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="y9sI4btH/QqT9qV/"
Content-Disposition: inline
In-Reply-To: <wtyut5kd4v5vapon7fzpvi3kghvpplokcas5ovcwnjhiwyuccb@rm6eb6jjhhp5>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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


--y9sI4btH/QqT9qV/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 19, 2023 at 10:47:00AM +0200, Stefano Garzarella wrote:
> On Wed, May 17, 2023 at 06:10:19PM -0400, Stefan Hajnoczi wrote:
> > Stop using the .bdrv_co_io_plug() API because it is not multi-queue
> > block layer friendly. Use the new blk_io_plug_call() API to batch I/O
> > submission instead.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> > block/blkio.c | 40 +++++++++++++++++++++-------------------
> > 1 file changed, 21 insertions(+), 19 deletions(-)
>=20
> With this patch, the build fails in several places, maybe it's an old
> version:
>=20
> ../block/blkio.c:347:5: error: implicit declaration of function
> =E2=80=98blk_io_plug_call=E2=80=99 [-Werror=3Dimplicit-function-declarati=
on]
>   347 |     blk_io_plug_call(blkio_unplug_fn, bs);

Will fix, thanks!

Stefan

--y9sI4btH/QqT9qV/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmRs4EIACgkQnKSrs4Gr
c8jxMgf/ZdgG8aDCuwHwEH9aJ8kuEqAjFKKDKa/eAzlnouLXNCYig1RhfL9cDWaZ
4Zd/vBacIMN9YdG/gtrMl8iJlbz8fzNj9XqZnQuEByHQg82r/8+ehKP1tP+lhLWY
92jI+7BiJGCzg7nmFPW9CnADyWDmDvkWgmpXuLOZNGn9O3VTFLlmSjGv0BXi7kUT
pAIPfTrIanIJgLykGqSe606MCIo0aAefJ5zqAUhxT5jAk3R49722wMXYNbG2huFC
gWm3wH6hcTqRYpfbHZNo2hgz0PwEBqETuoH6VpylmcU8PLp54faw7euHo7eEqF1R
rJs7BnbeXR/04nOSnMfHWnLiql1OZw==
=duel
-----END PGP SIGNATURE-----

--y9sI4btH/QqT9qV/--


