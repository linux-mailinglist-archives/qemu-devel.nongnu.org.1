Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 774CD726866
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 20:21:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6xlX-0005kR-KF; Wed, 07 Jun 2023 14:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q6xlT-0005i3-OM
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 14:20:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q6xlG-0003jm-94
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 14:20:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686161997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gd7EvDhILv2McBuFzWvrD2Crcmn7PENcyGC++OJufVg=;
 b=U5d0evo9qjVlpoIbXq6DpeUoGH3hlWx6keZxsh8MCRCf2GToSTmGvDoBmbhwfMJpqBGWtQ
 i5gd19wBRBhLDMZDzRe4hRv/Nww7EyjLtlz7gMXQ1e/Ob/vpjcIHslTIblOdLGirSsiRNJ
 udscM77T2pxSIF7DU8UzXS9t0ZZGQKY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-86-zpIc-jXWOR6mSjkC-ZVMjw-1; Wed, 07 Jun 2023 14:19:53 -0400
X-MC-Unique: zpIc-jXWOR6mSjkC-ZVMjw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 76C9A3806704;
 Wed,  7 Jun 2023 18:19:53 +0000 (UTC)
Received: from localhost (unknown [10.39.192.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EC9219E8D;
 Wed,  7 Jun 2023 18:19:52 +0000 (UTC)
Date: Wed, 7 Jun 2023 12:04:12 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org, dlemoal@kernel.org, dmitry.fomichev@wdc.com,
 hare@suse.de, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 1/2] block/file-posix: fix g_file_get_contents return path
Message-ID: <20230607160412.GD2138915@fedora>
References: <20230604061658.49004-1-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ervGsn7Itrktaoyu"
Content-Disposition: inline
In-Reply-To: <20230604061658.49004-1-faithilikerun@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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


--ervGsn7Itrktaoyu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 04, 2023 at 02:16:57PM +0800, Sam Li wrote:
> The g_file_get_contents() function returns a g_boolean. If it fails, the
> returned value will be 0 instead of -1. Solve the issue by skipping
> assigning ret value.
>=20
> This issue was found by Matthew Rosato using virtio-blk-{pci,ccw} backed
> by an NVMe partition e.g. /dev/nvme0n1p1 on s390x.
>=20
> Signed-off-by: Sam Li <faithilikerun@gmail.com>
> ---
>  block/file-posix.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

The number of bytes returned was never used, so changing the return
value to 0 or -errno is fine:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--ervGsn7Itrktaoyu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmSAqnwACgkQnKSrs4Gr
c8j8owf/V2mRvGurqnFMBH2t3TYerSQf+CzcmZJHN/mMm4mdmC6I8VoR0XxiKk9W
99xP6e9pN4OYmZBZOLypszOtm4m/xQChM6wVGQkgvTgPQOdLuCW9ypO9NbSJzJa2
0YnXx3xRZFSz0TmImXFX5op36v0tRkZQii3pVpEk1R8hoBZIcLZ0c/E91Qh31azf
Umagt6BlVcTspzjtANOfqYgaiWucKsVTTuyQ65iMNNyYAQ/OgJdYgSeonoVTQZCy
KEcQTpPaxc5d8PcNQckVEGnW6B8Ie1r/hAXeShTcpV/8w9MY1A4QAxNf5sVT4xRc
yT6FQchA3ICj0EgQAIzwZlSMzz1Lpg==
=2cnM
-----END PGP SIGNATURE-----

--ervGsn7Itrktaoyu--


