Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEE7711618
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 20:57:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2G8v-00031B-Si; Thu, 25 May 2023 14:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q2G8i-000312-M0
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:56:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q2G8h-0007xm-A4
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:56:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685041002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5FnNvHR+hQ1BMhU1vcyn6DPWmKAw9Mq85tVyQQ0m3GQ=;
 b=F4Dis2M8RIR9NsQIQOt9JZmP5ZOlbFVNVNjm6iYlkNmYjLZyrpsmpNdF3LVV85Bvp57GBR
 74EDyYqtJ//TzYkndDaK4kGd/hWv3pBE4HdSwaweqAs50S9vhKSLMCQV5zMRJm//l6l91g
 HM6L5kE+Io49Yg5Lw8GfxIdaODVkwWE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-326-OH9wuyVJP56IUvfqEjChVg-1; Thu, 25 May 2023 14:56:40 -0400
X-MC-Unique: OH9wuyVJP56IUvfqEjChVg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 58F611C04B45;
 Thu, 25 May 2023 18:56:40 +0000 (UTC)
Received: from localhost (unknown [10.39.192.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DCFDF400E13A;
 Thu, 25 May 2023 18:56:39 +0000 (UTC)
Date: Thu, 25 May 2023 14:56:38 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 09/12] block: Take AioContext lock in bdrv_open_driver()
Message-ID: <20230525185638.GK132697@fedora>
References: <20230525124713.401149-1-kwolf@redhat.com>
 <20230525124713.401149-10-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="IS3EsAOgKcRVnvhV"
Content-Disposition: inline
In-Reply-To: <20230525124713.401149-10-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--IS3EsAOgKcRVnvhV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 25, 2023 at 02:47:10PM +0200, Kevin Wolf wrote:
> bdrv_refresh_total_sectors() and bdrv_refresh_limits() expect to be
> called under the AioContext lock of the node. Take the lock.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--IS3EsAOgKcRVnvhV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmRvr2YACgkQnKSrs4Gr
c8gv8AgAxca1TBW0oM0fKJ/sQ/s1GqGoE6XPtGU7Cc+0HmUwcBYpICxABnoXJOpQ
x0Vf5Y0roAkjw4j4y+k+VvnFsoRUfvkDwUNkQfxbkrMttnpkcdm7NDLQvcJc09v6
CbxVkUw0brc02h5/2eKi19LER8mRJj5WgUYIufUPmmn2MCpOaUzQ9IUhBjOJ+YS9
VM9B5h+9QfhWrAJs5HUDzaxrigzzmbXH9g4voz5RFxlFIv5OVK7rnpSP4C6Wx7OA
45wHzIB8y8nsD7c2wKeXVQbINmp/XcJAJggFtvv6mczjZs/jVVw7DGfbbhATkS9J
tI7GuALZyYQNEiBbkpqgcxsTGQo4BA==
=CtH1
-----END PGP SIGNATURE-----

--IS3EsAOgKcRVnvhV--


