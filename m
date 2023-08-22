Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E13784A0B
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 21:17:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYWsC-0003Zt-HZ; Tue, 22 Aug 2023 15:17:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYWru-0003U0-HM
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:16:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYWrs-0008TK-E3
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692731803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fMshRVGb68twmz8K5z509ulsc/O+ily7naj9HutWcgA=;
 b=hcn5eWC3yRxES/jWy8HvtM6zfMkBEbdnknnHUtPBjRSoZgNEC4JvrVZn+5SXIf0YcHX8AD
 pjTSzB2i4eh6+uA7mJ6ZIYo2HKlVOiVDgo4i13aUn4da/yByTsMVpoX5sB05p7iPK2j6dr
 xv/vXXG5lwDDVJ3VEsLo+xew1URGn68=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-426-rzsUIpt4OB6T7NyAAouWxg-1; Tue, 22 Aug 2023 15:16:38 -0400
X-MC-Unique: rzsUIpt4OB6T7NyAAouWxg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 21F763C0D845;
 Tue, 22 Aug 2023 19:16:38 +0000 (UTC)
Received: from localhost (unknown [10.39.195.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A9C10492C13;
 Tue, 22 Aug 2023 19:16:37 +0000 (UTC)
Date: Tue, 22 Aug 2023 15:16:36 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, eesposit@redhat.com,
 pbonzini@redhat.com, vsementsov@yandex-team.ru, qemu-devel@nongnu.org
Subject: Re: [PATCH 10/21] block: Mark bdrv_attach_child_common() GRAPH_WRLOCK
Message-ID: <20230822191636.GM727224@fedora>
References: <20230817125020.208339-1-kwolf@redhat.com>
 <20230817125020.208339-11-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="iI2gbR7lX4NCGNKG"
Content-Disposition: inline
In-Reply-To: <20230817125020.208339-11-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--iI2gbR7lX4NCGNKG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2023 at 02:50:09PM +0200, Kevin Wolf wrote:
> Instead of taking the writer lock internally, require callers to already
> hold it when calling bdrv_attach_child_common(). These callers will
> typically already hold the graph lock once the locking work is
> completed, which means that they can't call functions that take it
> internally.
>=20
> Note that the transaction callbacks still take the lock internally, so
> tran_finalize() must be called without the lock held. This is because
> bdrv_append() also calls bdrv_replace_node_noperm(), which currently
> requires the transaction callbacks to be called unlocked. In the next
> step, both of them can be switched to locked tran_finalize() calls
> together.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c        | 133 +++++++++++++++++++++++++++++++------------------
>  block/stream.c |  20 ++++++--
>  2 files changed, 100 insertions(+), 53 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--iI2gbR7lX4NCGNKG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTlCZQACgkQnKSrs4Gr
c8iXHwf/daJpZRefD5T1UcFO3x3rnUrsML/RWJPqFtrJ9M+nbD9aO26Z0nzXpuEs
4fQerad2QQl4jD5PZO7TBKnfoL2TxxuXCiGePf800EduZbRwgkCqy8QIouqDFmbQ
Fg4YMzYROuLhTYZZg4zJCj1MjbIBUnWTXCMxprEAmo0e71ho78ml7gIrk7TKrSZm
32gIr8IIfDsfJDS/Rpds61a3SJ/8ho2xvUJDG6SWh55kHIYV7ofzWskrwRjaKdRp
tHANxWlQuc0KFF0Qjr4ylbu+GCoHh2GUu5DmYXcYRTRuut/7eK8RqUXN+3jT+rvQ
nvJ/b5qMJ/ewCKBnI2IIoOj6q+b8Ag==
=arJI
-----END PGP SIGNATURE-----

--iI2gbR7lX4NCGNKG--


