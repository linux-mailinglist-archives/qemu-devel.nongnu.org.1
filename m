Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 687307849DF
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 21:04:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYWex-00041J-1W; Tue, 22 Aug 2023 15:03:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYWeu-00040p-Ve
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:03:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYWet-0005Aw-0Y
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692730998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O+M8S9sYZ94SPmDjz7/gc3+Uw0Bq35Y8M46uVfd9APY=;
 b=UemKRBvg4pkQFlk8sBwad5iKgYrZWPKYwQGjPeaJC27Hj9Ft4k4AqTMKqoHWySQupDJvl2
 zZzdkLMsPOIvwf+X7W/HItKYu21OflhXsnNoc1UT9Rm2EzoY8zptRFUk3fiIguUMKqb5SV
 LBN31rkt0SEtCy01e1VlNB0hmGzAgbY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-441-OmgGxNz7NYGpKDabAuSwWA-1; Tue, 22 Aug 2023 15:03:16 -0400
X-MC-Unique: OmgGxNz7NYGpKDabAuSwWA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CA431101A52E;
 Tue, 22 Aug 2023 19:03:15 +0000 (UTC)
Received: from localhost (unknown [10.39.195.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5F36940C206F;
 Tue, 22 Aug 2023 19:03:15 +0000 (UTC)
Date: Tue, 22 Aug 2023 15:03:14 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, eesposit@redhat.com,
 pbonzini@redhat.com, vsementsov@yandex-team.ru, qemu-devel@nongnu.org
Subject: Re: [PATCH 06/21] block-coroutine-wrapper: Add
 no_co_wrapper_bdrv_wrlock functions
Message-ID: <20230822190314.GI727224@fedora>
References: <20230817125020.208339-1-kwolf@redhat.com>
 <20230817125020.208339-7-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WzjE1lyJO0IMX09+"
Content-Disposition: inline
In-Reply-To: <20230817125020.208339-7-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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


--WzjE1lyJO0IMX09+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2023 at 02:50:05PM +0200, Kevin Wolf wrote:
> Add a new wrapper type for GRAPH_WRLOCK functions that should be called
> from coroutine context.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/block-common.h       |  4 ++++
>  scripts/block-coroutine-wrapper.py | 11 +++++++++++
>  2 files changed, 15 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--WzjE1lyJO0IMX09+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTlBnEACgkQnKSrs4Gr
c8gVAwf+Mp3SqIdT1UKDNIqgZaenhCxxI3uezO9jDWH9tAvDUXOe8pcE/29yrTJO
L8BK9ZkotViYnxi80kb3NKUYePKMyevdWKzttq1FeeNGACIOYhIouBMlYE1P28YS
GWjw6DGCz12IvgXsJX8Zw9Z8drBwTODmrLfdHHmcIOgVsUvpGI/b4F9CZ5eNsqTS
yal1TGJizCqvLVE7m+FK+cFMG2wZIpFKC2IWUojRA483Uxa6SaUQpbtF6fAJUnYq
xSORSxP/vfMJiUdajM6jjy8Dw5hkHFfa7sof7Uv/GsiXvz0NlUqjf9WBKcQsyuNl
B7vjzdW76/kwf61NaLG5zs19XL2r0A==
=9sCX
-----END PGP SIGNATURE-----

--WzjE1lyJO0IMX09+--


