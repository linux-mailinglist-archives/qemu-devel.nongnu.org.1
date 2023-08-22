Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E03A784A94
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 21:39:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYXDM-0008PO-5d; Tue, 22 Aug 2023 15:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYXDC-0008P2-NJ
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:38:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYXD9-00064p-GE
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:38:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692733122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cXCQ5V1+3h/qRT+oV0wcWRxLjlOKejzqmuFeT/FKtrQ=;
 b=TLzKGvMVzy/fit0XXBexAHu6040+dRHlOeIGQDm1BDqywpdSDdJ3TxktizkVWw3nnDbehJ
 A5eO8TkHkUJhfl57FutPHB0kD0xU/SNmkM6VtBjZBvXCgcmPoFgrVxpoN1BZWgbSCeTtSg
 +5IveCnsgtped1j8tRxa8AU7ilYsJJ0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-633-ecTuhKccOsex8eqRWWPPYg-1; Tue, 22 Aug 2023 15:38:41 -0400
X-MC-Unique: ecTuhKccOsex8eqRWWPPYg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9AE71185A791;
 Tue, 22 Aug 2023 19:38:40 +0000 (UTC)
Received: from localhost (unknown [10.39.195.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 165D92166B26;
 Tue, 22 Aug 2023 19:38:39 +0000 (UTC)
Date: Tue, 22 Aug 2023 15:38:38 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, eesposit@redhat.com,
 pbonzini@redhat.com, vsementsov@yandex-team.ru, qemu-devel@nongnu.org
Subject: Re: [PATCH 19/21] block: Mark bdrv_root_unref_child() GRAPH_WRLOCK
Message-ID: <20230822193838.GV727224@fedora>
References: <20230817125020.208339-1-kwolf@redhat.com>
 <20230817125020.208339-20-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PhsvKbSq8nM1Wmy3"
Content-Disposition: inline
In-Reply-To: <20230817125020.208339-20-kwolf@redhat.com>
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


--PhsvKbSq8nM1Wmy3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2023 at 02:50:18PM +0200, Kevin Wolf wrote:
> Instead of taking the writer lock internally, require callers to already
> hold it when calling bdrv_root_unref_child(). These callers will
> typically already hold the graph lock once the locking work is
> completed, which means that they can't call functions that take it
> internally.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/block_int-global-state.h | 2 +-
>  block.c                                | 6 +++---
>  block/block-backend.c                  | 3 +++
>  blockjob.c                             | 2 ++
>  4 files changed, 9 insertions(+), 4 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--PhsvKbSq8nM1Wmy3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTlDr4ACgkQnKSrs4Gr
c8gc6QgAvC1mDc7QCUbwtQ3Tq7/Ql8Eh9jD5SmElGf+8q3k8XwDqfWHfmw1eNgrr
OTxUu7mMTPx4+z/72/49qkGAndK4p7W06kjceh0JMKAQsKHyxIhXVCZ7Gg7NOjqH
clxoPCgvyzgzFtEdZNJg0Z/xpqkJM1iaePV7WO5NMen49Hd67ivdcJjZx0WHRf4J
G6WhS6rb4DaNaBl9tURhHuLo6Z5MoPVV1T5L8LVCsHuOLp09BSp7wecp3MqPybWj
2rrTmYz166Hhf90Ttl2DhpymS7lWy6IRygy6wsgCs57Lo8P84NE+VysKsrxgLYnP
/k3F7+znKycUIP1QfqkdBPWYJPIpsw==
=UcSZ
-----END PGP SIGNATURE-----

--PhsvKbSq8nM1Wmy3--


