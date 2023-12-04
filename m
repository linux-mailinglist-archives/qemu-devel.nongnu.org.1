Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E678038F8
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 16:38:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAB0p-0004Xf-J6; Mon, 04 Dec 2023 10:37:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rAB0l-0004XG-Dl
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 10:37:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rAB0k-0001sf-1d
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 10:37:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701704249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Fc24NWMQLYLdB1JxNKAGXDm/FWd2EgI9NmNM72eUnlM=;
 b=hlUxo0v+Qe6ebNatPu5kBEmKK97HG60RD0yYsAI99/AilORi5YGvIMyiPGrnp7zxYOGStd
 KQzy5TXtQ9hMSg+pJxsaGhDg+O85b2QcLOMFdb93+0vutyJ8XadMD/p+wqiA3ohyNutkgv
 YS4GdAoKWlBsIRYRkSKn0/yrQYmdHJU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-VtBvAg9SPTefofWbUPH1rA-1; Mon,
 04 Dec 2023 10:37:22 -0500
X-MC-Unique: VtBvAg9SPTefofWbUPH1rA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 436B038116E3;
 Mon,  4 Dec 2023 15:37:22 +0000 (UTC)
Received: from localhost (unknown [10.39.192.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9DD3B492BFC;
 Mon,  4 Dec 2023 15:37:21 +0000 (UTC)
Date: Mon, 4 Dec 2023 10:37:20 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH 2/4] virtio-scsi: don't lock AioContext around
 virtio_queue_aio_attach_host_notifier()
Message-ID: <20231204153720.GH1492005@fedora>
References: <20231123194931.171598-1-stefanha@redhat.com>
 <20231123194931.171598-3-stefanha@redhat.com>
 <cb5372l2vuovribjhxqwf4n7m5iads2rhfgcelpklkn44ckhru@hr62o7cncv4h>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2DxQU/HZ7VPrFXs4"
Content-Disposition: inline
In-Reply-To: <cb5372l2vuovribjhxqwf4n7m5iads2rhfgcelpklkn44ckhru@hr62o7cncv4h>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


--2DxQU/HZ7VPrFXs4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 09:21:08AM -0600, Eric Blake wrote:
> On Thu, Nov 23, 2023 at 02:49:29PM -0500, Stefan Hajnoczi wrote:
> > virtio_queue_aio_attach_host_notifier() does not require the AioContext
> > lock. Stop taking the lock and remember add an explicit smp_wmb()
>=20
> s/remember// ?

Will fix, thanks!

Stefan

--2DxQU/HZ7VPrFXs4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVt8jAACgkQnKSrs4Gr
c8gOtwf/RLH9hbp4kF4oDct8PQ0w6jp/MWd6Lx60sYzvlSfLb6KYt18+wUz1Z5Eq
IC6T3RaxlQu0mCnl6eKoj5ZwWKKHM0Ip63FGQrqg9svn+/qEHmkX+gIJ8cXNcREK
WtwhDwsLmnmZ8wAPGtJzKZIx7DSp+nxTgZIO8Vo5cJT06gsOeww6G6hON4SgmWl0
HhICF2WzpFwMwYijstntIIUVrBrkEYMZVCttTXgSlnO7J7+aik+kXZqt3LuKqfAW
Rk2/6kwWWJ0JhmU6C7IdnfiiWt+K0IQVPRzs9YyVp4w7bDXN7nekR2Fd/IRfkmdS
Ptakrea2O6VpxEZyl9pTQdlWbAAGpg==
=UmxJ
-----END PGP SIGNATURE-----

--2DxQU/HZ7VPrFXs4--


