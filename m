Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A423798621
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 12:47:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeZ0p-0001be-PL; Fri, 08 Sep 2023 06:46:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qeZ0n-0001Zy-NZ
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 06:46:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qeZ0j-0004Gu-Rr
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 06:46:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694170009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L1dEiYGQNUPLah1wWC+g3+r2sO+0y5tQIgDzYj49wIE=;
 b=bHKJhR/etCNpAQHCIGnBXmBSVRVvrrfpe3nOmzTnf1MonoyHt7uh6NrHJhN2vfEgcs1xQw
 094545hRjht0vfGEWHN5G5R/JccCQYGPN9MQAThefER4Lng90eY4L5tfK0z935JL5jIKHH
 xNNowYEn23kQxOLPBAnILl1A6AMwI4g=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-60-HOgCQafgNzWykZa70o7LVg-1; Fri, 08 Sep 2023 06:46:45 -0400
X-MC-Unique: HOgCQafgNzWykZa70o7LVg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F7F738210A1;
 Fri,  8 Sep 2023 10:46:45 +0000 (UTC)
Received: from localhost (unknown [10.39.193.245])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 77FDCC03295;
 Fri,  8 Sep 2023 10:46:44 +0000 (UTC)
Date: Fri, 8 Sep 2023 06:46:43 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, quintela@redhat.com,
 peterx@redhat.com, leobras@redhat.com, pbonzini@redhat.com,
 qemu-block@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH 0/2] virtio: Drop out of coroutine context in virtio_load()
Message-ID: <20230908104643.GC3552950@fedora>
References: <20230905145002.46391-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Ymhx9zfBuHiVkPSB"
Content-Disposition: inline
In-Reply-To: <20230905145002.46391-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--Ymhx9zfBuHiVkPSB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 05, 2023 at 04:50:00PM +0200, Kevin Wolf wrote:
> This fixes a recently introduced assertion failure that was reported to
> happen when migrating virtio-net with a failover. The latent bug that
> we're executing code in coroutine context that was never supposed to run
> there has existed for a long time. However, the new assertion that
> callers of bdrv_graph_rdlock_main_loop() don't run in coroutine context
> makes it very visible because it's now always a crash.
>=20
> Kevin Wolf (2):
>   vmstate: Mark VMStateInfo.get/put() coroutine_mixed_fn
>   virtio: Drop out of coroutine context in virtio_load()
>=20
>  include/migration/vmstate.h |  8 ++++---
>  hw/virtio/virtio.c          | 45 ++++++++++++++++++++++++++++++++-----
>  2 files changed, 45 insertions(+), 8 deletions(-)
>=20
> --=20
> 2.41.0
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Ymhx9zfBuHiVkPSB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmT6+5IACgkQnKSrs4Gr
c8hj6AgArr3lVjb9hyr5gzOPvdDHOY+Ov3fkZxcfStxEMBORs41vTC5FS858bd+R
dqWM9A320GUcuEl7qb7wNzeJXzX4RynLqLpykAGIV8rn2lrMaRIOK4VCCK53OUSq
p7cSp1noXsO8OuKiwe5krQ2wz366Uh+nGM8lFiZkfJGnovxy0+SiEDhsn3pnPQcl
NFlJzKb9FFo7xBwnhn3xn3LGBt5Te0FTd1rrq1s9TzcqBLcgIq61Nbf3aQH9tKZI
CPq131isC+krqrsSNjE/rFU+Na7ZHdJHqdIMSqSg43doiIpmCHcQYNHueuJ+MOhJ
bWr4iIFspXxe4AmGc0Gzj1w1o1Syeg==
=lmd5
-----END PGP SIGNATURE-----

--Ymhx9zfBuHiVkPSB--


