Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85904A92C72
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Apr 2025 22:59:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5WK5-0007Vc-3x; Thu, 17 Apr 2025 16:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u5WK2-0007Uh-28
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 16:58:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u5WK0-0000VC-FL
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 16:58:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744923535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dp2+SIL5GvHq6EAV5cIQAO7NVY5MDS0p2D7XuWBXsMs=;
 b=OknrVW0S2VVlZzdwuhYXacsqIYlRR4oxTxr0SY1etZCQT03kS67MF2Qx+SvbN/RDSo9tEV
 +url7yUKBJj64xBKeR8FXykqKRetxZv7NtFGEXsUQ/QSCy5qkfCG5opsmEoDpe35nzFki+
 kiD/RIJzbClOxkg2XT2c8yl4rAOEJ7o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-283-BTSStWhcNU-lSPNcWA-qvw-1; Thu,
 17 Apr 2025 16:58:53 -0400
X-MC-Unique: BTSStWhcNU-lSPNcWA-qvw-1
X-Mimecast-MFC-AGG-ID: BTSStWhcNU-lSPNcWA-qvw_1744923532
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9C27719560B7; Thu, 17 Apr 2025 20:58:51 +0000 (UTC)
Received: from localhost (unknown [10.2.16.64])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EAF97180047F; Thu, 17 Apr 2025 20:58:50 +0000 (UTC)
Date: Thu, 17 Apr 2025 16:58:49 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, vsementsov@yandex-team.ru,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2 02/11] file-posix: Handle zero block status hint better
Message-ID: <20250417205849.GK85491@fedora>
References: <20250417184133.105746-13-eblake@redhat.com>
 <20250417184133.105746-15-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="whmmV8aJP/44PCMw"
Content-Disposition: inline
In-Reply-To: <20250417184133.105746-15-eblake@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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


--whmmV8aJP/44PCMw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 01:39:07PM -0500, Eric Blake wrote:
> Although the previous patch to change 'bool want_zero' into an enum
> made no semantic change, it is now time to differentiate.  When the
> caller specifically wants to know what parts of the file read as zero,
> we need to use lseek and actually reporting holes, rather than
> short-circuiting and advertising full allocation.
>=20
> This change will be utilized in later patches to let mirroring
> optimize for the case when the destination already reads as zeroes.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  block/file-posix.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--whmmV8aJP/44PCMw
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgBa4kACgkQnKSrs4Gr
c8iVuAf/f2nuVAuoHF/t6K4aATRdiSkKNE1BVxjUT8A9SbblcaWD2s7l6zjvksre
PN26wswYdN3OA55aAh1IYwAoI0wfMgmZ2B/NZ+azjOUPz8y0pQ1688IQ8hy0ctxz
I6s8DL4vGjI030FRqsZGuwhdjoBApY9/YwYARQ4UhibxygX/xnsIsk2YXRbwXqct
6j1B+x+ytiEIm8JFGgVgQgxuX66nvxmKQG8LVA4Qmf5V/Yb4ICxTV3Szmg8XIe5s
c3XjStp3euUIQUHyPhmv8khYeSaMjM6ziI5yp9MJv3MRL8s9O3iVus8RjJCirtkN
EdUM4261auqDRl1zJxNPrQLC1+xDeQ==
=EB9u
-----END PGP SIGNATURE-----

--whmmV8aJP/44PCMw--


