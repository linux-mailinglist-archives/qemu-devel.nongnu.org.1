Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 440C8BC2904
	for <lists+qemu-devel@lfdr.de>; Tue, 07 Oct 2025 21:56:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6DnL-0001Us-4P; Tue, 07 Oct 2025 15:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v6DnJ-0001Tp-Ea
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 15:56:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v6DnF-0004Gp-8a
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 15:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759866975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5sVUd7rhdCuBayrWGnRSpHw0ie/+uBiOsiJRgMKAyKs=;
 b=JfHDupKGCmD9s+j5Df9yRDGXDADvZVVBZWfMiWDISHyLwKsvk1OvOHvECZruPgW79x25rV
 j4pK3CMA6FxSXIFhqdk5sBSW/t/HANSNawD1cSAS1ISHu30eezDMCXzdJHEq8T7AIhwb+Q
 tORTKG6DhmHmJCvRGF9SEv6dQah4cMo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-Pa1hVu56N120VPMEPDv4RA-1; Tue,
 07 Oct 2025 15:56:11 -0400
X-MC-Unique: Pa1hVu56N120VPMEPDv4RA-1
X-Mimecast-MFC-AGG-ID: Pa1hVu56N120VPMEPDv4RA_1759866970
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7280419560A7; Tue,  7 Oct 2025 19:56:10 +0000 (UTC)
Received: from localhost (unknown [10.2.16.87])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9B15419560B8; Tue,  7 Oct 2025 19:56:09 +0000 (UTC)
Date: Tue, 7 Oct 2025 15:56:08 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, qemu-devel@nongnu.org,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH v4] block: replace TABs with space
Message-ID: <20251007195608.GB127783@fedora>
References: <20251007163511.334178-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RlrbBd5vsFp5bR+O"
Content-Disposition: inline
In-Reply-To: <20251007163511.334178-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--RlrbBd5vsFp5bR+O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 07, 2025 at 06:35:11PM +0200, Thomas Huth wrote:
> From: Yeqi Fu <fufuyqqqqqq@gmail.com>
>=20
> Bring the block files in line with the QEMU coding style, with spaces
> for indentation. This patch partially resolves the issue 371.
>=20
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/371
> Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
> Message-ID: <20230325085224.23842-1-fufuyqqqqqq@gmail.com>
> [thuth: Rebased the patch to the current master branch]
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  I came accross this old patch today - it fell through the cracks
>  in 2023, but I think it's still worth to get the coding style
>  finally fixed in these files.
>=20
>  include/block/nbd.h |  2 +-
>  block/bochs.c       | 14 +++++++-------
>  block/file-posix.c  |  6 +++---
>  block/file-win32.c  | 18 +++++++++---------
>  block/qcow.c        | 10 +++++-----
>  5 files changed, 25 insertions(+), 25 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--RlrbBd5vsFp5bR+O
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjlcFgACgkQnKSrs4Gr
c8jYsQgAyVK/OZqG31TWoTFZ+LXnWQg5+/RNcBe2Ck+MPqoiFjjOWA+1QkvlW/MM
RbndfrWaPmkPRCKqYzBlXObryu4glHzCxn+mgfv61+KYxZIDGXhmtfDqBJ1Wkw4l
0A2WuDgnxN0jy5x3LfHJUVLQC1R9D4kdaAUooEGRewHBPnp/ARV+NfA+JHUul744
IygfuiIZlFrJGR4nRVYXJaWaBZaPcWBm09c9nORr+IHto2HqSwSmbtDVAqZVhdJ7
ia0Gfwezi1ilvSUYx8xNuRytIhhX5U/UlwiObRv8e9/EDI46V++Gu+mnLDPuiwl6
QY1IUX9KN1GkWLFqiQ1CKmtMAmyiJA==
=yLx0
-----END PGP SIGNATURE-----

--RlrbBd5vsFp5bR+O--


