Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 530DCA59207
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Mar 2025 11:56:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trane-0000U1-G5; Mon, 10 Mar 2025 06:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tranc-0000Td-T6
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 06:55:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tranb-0005zv-B3
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 06:55:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741604154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=otnCTJvwM/oZxaxCGGiHqyfzZUUoURQ5Etc1ZfTzmaI=;
 b=Y/22zSMbq+yLVXV4a1UB3xR8W75ctnBFCfWDTCUZdq4zsfhy22+qI+B6dhLhUwJHFdyfRC
 pe+0daLZCK16fEdtlBtl7LK95OFGtVKZ1gtlx/jSOk+lxEjd79Fh28rl4NmIpp/fJi0kAJ
 3cWSAsvWFmLPePblrGpEmbV3bKiqN9s=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-219-skQAGwrpPqK7RqvqAYpPCg-1; Mon,
 10 Mar 2025 06:55:53 -0400
X-MC-Unique: skQAGwrpPqK7RqvqAYpPCg-1
X-Mimecast-MFC-AGG-ID: skQAGwrpPqK7RqvqAYpPCg_1741604152
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1DC92195609E; Mon, 10 Mar 2025 10:55:52 +0000 (UTC)
Received: from localhost (unknown [10.2.16.19])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 42E043000197; Mon, 10 Mar 2025 10:55:50 +0000 (UTC)
Date: Mon, 10 Mar 2025 18:55:48 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, afaria@redhat.com,
 hreitz@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH 0/5] block: Improve writethrough performance
Message-ID: <20250310105548.GF359802@fedora>
References: <20250307221634.71951-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ypp4Iwa9KBVaB3C8"
Content-Disposition: inline
In-Reply-To: <20250307221634.71951-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--ypp4Iwa9KBVaB3C8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 07, 2025 at 11:16:29PM +0100, Kevin Wolf wrote:
> Write requests in writethrough mode mean that QEMU sends a separate
> flush request (i.e. fdatasync) after each completed write request.
> This is unnecessary overhead when we can just pass a flag for the write
> request that gives us the desired FUA semantics.
>=20
> Unfortunately, this made a problem in the adaptive polling algorithm
> apparent that would result in a performance regression in some cases
> with FUA support in file-posix. Therefore, adaptive polling is changed
> in this series, too, to avoid the regression.

Looks good!

Stefan

>=20
> Kevin Wolf (5):
>   file-posix: Support FUA writes
>   block/io: Ignore FUA with cache.no-flush=3Don
>   aio: Create AioPolledEvent
>   aio-posix: Factor out adjust_polling_time()
>   aio-posix: Separate AioPolledEvent per AioHandler
>=20
>  include/block/aio.h     |  5 ++-
>  include/block/raw-aio.h |  8 +++-
>  util/aio-posix.h        |  1 +
>  block/file-posix.c      | 26 ++++++++----
>  block/io.c              |  4 ++
>  block/io_uring.c        | 13 +++---
>  block/linux-aio.c       | 24 +++++++++--
>  util/aio-posix.c        | 94 ++++++++++++++++++++++++++---------------
>  util/async.c            |  1 -
>  meson.build             |  4 ++
>  10 files changed, 125 insertions(+), 55 deletions(-)
>=20
> --=20
> 2.48.1
>=20

--ypp4Iwa9KBVaB3C8
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfOxTQACgkQnKSrs4Gr
c8hD8AgArcDGM7jSULDV26rmMUbPt1M/IBXynkIW7fWfJ3BEzEcVhN01/+xG2KbN
9Y+GANldK91Qso9Jbqmab6diZHHBIDCh4II/fmDW9mMvoQmn8I/D0qGw+xOv9PYR
UrWz656a0f/PPS3c/mTedXkpuLjaGyoo0Kln/WlE9l+PEH3hGag9yBjQdQicwKnZ
pvoLm6HKDEbtIZQ4wmwyk/zRtP8dVPoQGKnnj5Qblh1q0G42ZXUBXJDvLn8poxj5
9iEouSMK4SiLBESSHeopeUZ/OfO8uAgSrc7oIZPEAYQR1aMIfkwYgivrW+zIND2H
OJg7s5v04ujB9BowWS6nYN+vewoNlQ==
=ME7N
-----END PGP SIGNATURE-----

--ypp4Iwa9KBVaB3C8--


