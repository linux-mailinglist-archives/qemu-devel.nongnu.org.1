Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 291EC784A4F
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 21:21:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYWwU-0003cO-4m; Tue, 22 Aug 2023 15:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYWwH-0003Vh-Gl
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:21:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYWwC-0001aL-Qj
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:21:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692732071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jGRmZj0BIO9jIWootBjMqbwacmyTpIYd+l15yyE2eHE=;
 b=LwXIGp6Ks04c6gBmltrSUOvKcDSE2Ax3WSHykXYY/LNwgPcuLbmyUhggKE3imRruQfTnSq
 hCdD8OOevdY29NbkRHpjpFZyM+Yot5OdwNUMiPlAL+wD3Hoa4tQSMbMXyai8yEJnHqDteu
 HuztTzJkDWGqSon7kKLgzNIjGecDDfQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-473-FruqmP0bPEmIQRMFymOatw-1; Tue, 22 Aug 2023 15:21:08 -0400
X-MC-Unique: FruqmP0bPEmIQRMFymOatw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C8E728D40B2;
 Tue, 22 Aug 2023 19:21:07 +0000 (UTC)
Received: from localhost (unknown [10.39.195.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5F73C1121315;
 Tue, 22 Aug 2023 19:21:07 +0000 (UTC)
Date: Tue, 22 Aug 2023 15:21:06 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, eesposit@redhat.com,
 pbonzini@redhat.com, vsementsov@yandex-team.ru, qemu-devel@nongnu.org
Subject: Re: [PATCH 12/21] block: Mark bdrv_attach_child() GRAPH_WRLOCK
Message-ID: <20230822192106.GO727224@fedora>
References: <20230817125020.208339-1-kwolf@redhat.com>
 <20230817125020.208339-13-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="iyv+9wAFIiuJTSg6"
Content-Disposition: inline
In-Reply-To: <20230817125020.208339-13-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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


--iyv+9wAFIiuJTSg6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2023 at 02:50:11PM +0200, Kevin Wolf wrote:
> Instead of taking the writer lock internally, require callers to already
> hold it when calling bdrv_attach_child_common(). These callers will
> typically already hold the graph lock once the locking work is
> completed, which means that they can't call functions that take it
> internally.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/block-global-state.h | 14 ++++++++------
>  block.c                            |  7 +++----
>  block/quorum.c                     |  2 ++
>  block/replication.c                |  6 ++++++
>  tests/unit/test-bdrv-drain.c       | 14 ++++++++++++++
>  tests/unit/test-bdrv-graph-mod.c   | 10 ++++++++++
>  6 files changed, 43 insertions(+), 10 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--iyv+9wAFIiuJTSg6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTlCqIACgkQnKSrs4Gr
c8i1lwf/cI9F3xVVZui6qo3A/4B9Ib43DT9UtEplMXXvRIQU9S86Bodvf8B5ciEQ
Jbui/W7MqVIwaoq6zYIaRwwxJe8rZmmA/q24Mm3nnaxYOIWs7Olt+1HJ0Doz8gqu
L8YiJHYX3XQiBSn7/7qbl14948hP+WILi4WUWfT0whp8YuX5fh6z1JyoW5VwZAJX
Moa7EYP98kXTEmKswPQhzCiufszyk+du2rUMKROQC9rn+Je2+FpoGsFgT7AjJCIs
JF2X3ImR433r5aMx5Y/0aQoqJ+iSFKDZL6odyPdLAT9XlEvCkSN9yfK7n8JCWd4D
nSQfJxXD2eEGBADmbAGk3BrZs5ZT2g==
=Gfjd
-----END PGP SIGNATURE-----

--iyv+9wAFIiuJTSg6--


