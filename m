Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DF178495D
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 20:24:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYW2N-0005aI-MX; Tue, 22 Aug 2023 14:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYW2L-0005Zv-MN
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 14:23:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYW2J-0003NH-NI
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 14:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692728606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Hx/MmDi3fR6mh+/AvW5VBhEEWLLUglRqMhZpP0h1DWA=;
 b=Ac6oGlbZnXdpPvluVAZ77rbC3Ohlp8R9WX6u69AqzeTBtFBLjddxh3LXy6cn8DhupJYWzT
 AUfOGU4WzKFWpc4ywq8LonwNZCKB8p5mDNUPtZgNSMQCQ64tL3OwhgFbAtglG3k6ZsWlsk
 CqHFXt7qBjgtKK6aXbHdFpDeeMDNm5c=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-661-M1TT2nOCNMKJnPAWHRcEdA-1; Tue, 22 Aug 2023 14:23:22 -0400
X-MC-Unique: M1TT2nOCNMKJnPAWHRcEdA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DBE641C0724E;
 Tue, 22 Aug 2023 18:23:09 +0000 (UTC)
Received: from localhost (unknown [10.39.195.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6A1FF2166B28;
 Tue, 22 Aug 2023 18:23:09 +0000 (UTC)
Date: Tue, 22 Aug 2023 14:23:08 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, eesposit@redhat.com,
 pbonzini@redhat.com, vsementsov@yandex-team.ru, qemu-devel@nongnu.org
Subject: Re: [PATCH 01/21] block: Remove unused
 BlockReopenQueueEntry.perms_checked
Message-ID: <20230822182308.GD727224@fedora>
References: <20230817125020.208339-1-kwolf@redhat.com>
 <20230817125020.208339-2-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="4CyNY+5fwNGsW1bQ"
Content-Disposition: inline
In-Reply-To: <20230817125020.208339-2-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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


--4CyNY+5fwNGsW1bQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2023 at 02:50:00PM +0200, Kevin Wolf wrote:
> This field has been unused since commit 72373e40fbc ('block:
> bdrv_reopen_multiple: refresh permissions on updated graph').
> Remove it.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--4CyNY+5fwNGsW1bQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTk/QsACgkQnKSrs4Gr
c8jSqAf+Mt8wcd8KRNyuBViYvW7afOupjTg6GawsZ9M1KMqlnPb7HGrQAcx0MpwI
7yc3mxOnGaHGoaHauc1nC/x848y+jFWWK7gCKK0UtPQbmCQVwYwm5Cp2gUi+vF6g
XyMjpgMRtX3it/0RVXSAqdVPFhDnJNMIM280pMerXLVa7r9trV1nfjHVJCvj049c
UiBBYrQiRnhMi75fLBKYAHuLn1pmSa5moxT6BEDkoYHm66VVAH6nLwTjsVpjsYg9
9vKfrJS9GJhklFDXc3qqFELgIi91jZZFcpD5LD5fEwU0/SgKB3iXjMPYJbfLPetc
05VEZIfOxmFRVVMXjECMdA7bCn/Ddw==
=1ZfM
-----END PGP SIGNATURE-----

--4CyNY+5fwNGsW1bQ--


