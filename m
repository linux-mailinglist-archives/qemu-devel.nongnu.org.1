Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE2BA262E9
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Feb 2025 19:48:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf1Ty-0007IF-EP; Mon, 03 Feb 2025 13:47:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tf1Tt-0007Hy-IU
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 13:47:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tf1Tr-00052Z-9b
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 13:47:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738608454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wf1sf2snJLmqSGQtCbX2nCDgLC70bPqRKKJhNAedkK8=;
 b=ZVssKqS8Z9I/YqmNH9jztfT6iEkEzkJExMNoQ8eerEzlcioT8VaYq+kMJ9Yi1ZQ+nQ8yri
 EbcHf5CLKLs3nQNW0HWw7bahO3DsRZusNvQ3rLBXSLIpi1MNxo/Mk0gTgPQ7pOgAXqbywe
 C4cCjKy8vCAuykJlUfuWb1rm5/ZptXU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-KdJaTR4fPUCrTkxlDQkJfg-1; Mon,
 03 Feb 2025 13:47:32 -0500
X-MC-Unique: KdJaTR4fPUCrTkxlDQkJfg-1
X-Mimecast-MFC-AGG-ID: KdJaTR4fPUCrTkxlDQkJfg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A7CE6180885C; Mon,  3 Feb 2025 18:47:31 +0000 (UTC)
Received: from localhost (unknown [10.2.16.131])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B4BC2195608E; Mon,  3 Feb 2025 18:47:30 +0000 (UTC)
Date: Mon, 3 Feb 2025 13:47:29 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, pkrempa@redhat.com,
 peterx@redhat.com, farosas@suse.de, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 01/15] block: Add 'active' field to BlockDeviceInfo
Message-ID: <20250203184729.GC268514@fedora>
References: <20250130171240.286878-1-kwolf@redhat.com>
 <20250130171240.286878-2-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7rFmV0gNpgnOgLUg"
Content-Disposition: inline
In-Reply-To: <20250130171240.286878-2-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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


--7rFmV0gNpgnOgLUg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2025 at 06:12:32PM +0100, Kevin Wolf wrote:
> This allows querying from QMP (and also HMP) whether an image is
> currently active or inactive (in the sense of BDRV_O_INACTIVE).
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json           |  6 +++++-
>  block/monitor/block-hmp-cmds.c |  5 +++--
>  block/qapi.c                   |  1 +
>  tests/qemu-iotests/184.out     |  2 ++
>  tests/qemu-iotests/191.out     | 16 ++++++++++++++++
>  tests/qemu-iotests/273.out     |  5 +++++
>  6 files changed, 32 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--7rFmV0gNpgnOgLUg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmehD0EACgkQnKSrs4Gr
c8h6BAf/e6/RafL5fGKKochZCZCFow2suJBVrEeKJKjeKTmcM4Mpr4EG7VaoLpHy
Z/961PwMQIRKiOC+OG826uIH0hGl2FPSNrV6QL+g+yV6n4Qvemh5Wj6L5DspzFMl
HHLwls57JdKZmhUYgj594zhsip0e+YurmnW5CF85QWJc7YpEw/kmoltiS78ksneZ
/jn6ATCIl+8ROpGIOSJXBXaPTosX6/gw0szTjOfOWihA3JVsPHd3lB6XaGTnf9Iz
Cm7n1mpVofPKsXvG1hgSU3kCmBr6DT6yscxKzspuWzrVqsZ9+2fWhaSqCVTBvkJD
Tf8uB+CtAw2JWtd0EsgnSkNSGBTkaA==
=yEnh
-----END PGP SIGNATURE-----

--7rFmV0gNpgnOgLUg--


