Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97729784A42
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 21:20:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYWuH-0004Wp-BS; Tue, 22 Aug 2023 15:19:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYWuF-0004WJ-9M
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:19:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYWuD-0000l5-97
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:19:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692731948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oct12eSK467hQwrVAPItsWVsXalcB48InjG9n5SpyI4=;
 b=T+FbjrdhA/3ZqYx53mW5a3Vah4B70KBHXPLMrshM2R+3jxtHfW2ao7+u68oYnDgB6czQuL
 bVcgcpaHHHRm2fCvCsKPBRuZsK915HYelyiAx6FZo1GWqilF51rKId9lV1gLm6T6m9arRe
 1CC/3uLqDhwtH+Z7BUj6r7mfOVEY05c=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-85-CaieUWhDNsW5CsxaYt4iwg-1; Tue, 22 Aug 2023 15:19:05 -0400
X-MC-Unique: CaieUWhDNsW5CsxaYt4iwg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 70F613C0D84F;
 Tue, 22 Aug 2023 19:19:04 +0000 (UTC)
Received: from localhost (unknown [10.39.195.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 07BDFC15BAE;
 Tue, 22 Aug 2023 19:19:03 +0000 (UTC)
Date: Tue, 22 Aug 2023 15:19:02 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, eesposit@redhat.com,
 pbonzini@redhat.com, vsementsov@yandex-team.ru, qemu-devel@nongnu.org
Subject: Re: [PATCH 11/21] block: Call transaction callbacks with lock held
Message-ID: <20230822191902.GN727224@fedora>
References: <20230817125020.208339-1-kwolf@redhat.com>
 <20230817125020.208339-12-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="J8hrLuB1wRbZ44sq"
Content-Disposition: inline
In-Reply-To: <20230817125020.208339-12-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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


--J8hrLuB1wRbZ44sq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2023 at 02:50:10PM +0200, Kevin Wolf wrote:
> In previous patches, we changed some transactionable functions to be
> marked as GRAPH_WRLOCK, but required that tran_finalize() is still
> called without the lock. This was because all callbacks that can be in
> the same transaction need to follow the same convention.
>=20
> Now that we don't have conflicting requirements any more, we can switch
> all of the transaction callbacks to be declared GRAPH_WRLOCK, too, and
> call tran_finalize() with the lock held.
>=20
> Document for each of these transactionable functions that the lock needs
> to be held when completing the transaction, and make sure that all
> callers down to the place where the transaction is finalised actually
> have the writer lock.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 61 +++++++++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 44 insertions(+), 17 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--J8hrLuB1wRbZ44sq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTlCiYACgkQnKSrs4Gr
c8hYLQf/d1c92lzT+T+YxHO1EuVaX94tb/mizZ9Dw+MQg8VMmpvJIfkgd4BEdT3/
CFuW9hdEZ0rsPE+pf5bJpjcC4j+XzOK1lELo9AXzq/6GNvagbXW6ybf9iNVb8ktn
OEtfTXb8ZZfosW8H0Tk+JHNw6To5wp3HY8mSeXqPUJUnCqEaK7HnGgaFhuMuDPUu
wLIDky5un/bp0HBO9HUoF9W7OCJ08+HJWpGqCQYkdvI5v3ysapa9CKcSvl2d4qae
KyQDwoqVtDAU4D3NYT3i/PugvWR4SD2B0l3dur/JJg86r65kZN18P161Lhri8qJm
uASjScNApolFmM4XjOl0DMD+2Yve8w==
=K6SI
-----END PGP SIGNATURE-----

--J8hrLuB1wRbZ44sq--


