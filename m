Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 147417CCBB0
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 21:05:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qspMm-0007nT-EU; Tue, 17 Oct 2023 15:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qspMk-0007jc-9x
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 15:04:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qspMi-0000gi-Ka
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 15:04:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697569467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n32cEPGoWrp+fe+wvC9cWcyGrAoKcycmsD67N9WBtFg=;
 b=QgWofaqQmR9M6IU7+fXU8E800T01c4gjUDmMHvBSJzybMJ94AxiFhktehwD5vML/xkJyps
 GZNveIdM1+iR8TH6a5TgIvSffB1Pt9796jjLAGh/IOVH0qnzD1uEQK965vvJwT7K0EyUZw
 RmsPIF9wnmWs4zswLScvSMAUH5asyI0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-642-0t5mFdP6MKKHkxXJqGzXJw-1; Tue, 17 Oct 2023 15:04:25 -0400
X-MC-Unique: 0t5mFdP6MKKHkxXJqGzXJw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 25F4081D9FB;
 Tue, 17 Oct 2023 19:04:24 +0000 (UTC)
Received: from localhost (unknown [10.39.192.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 763AB1C060AE;
 Tue, 17 Oct 2023 19:04:23 +0000 (UTC)
Date: Tue, 17 Oct 2023 15:04:22 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Leonardo Bras <leobras@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PULL 00/38] Migration 20231017 patches
Message-ID: <20231017190422.GA243672@fedora>
References: <20231017083003.15951-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="a5Hbs5LAOYUyUbtQ"
Content-Disposition: inline
In-Reply-To: <20231017083003.15951-1-quintela@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--a5Hbs5LAOYUyUbtQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--a5Hbs5LAOYUyUbtQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUu2rYACgkQnKSrs4Gr
c8gtYwgAvmCtOomyVGwejonu+pGMhwwXGa/yGSKaMdv3h//L2zdhbi7uxQFuGmjq
hCj2SSE4581nuclYZHiom88A7GGlqjxvQGf/8O1DXQ5I5Q7zsIT5xyEUQLtC/OUe
2I4DLSvfB93HGM6iu6OlJJJPvHfCgyt4XNyYHz9yw88h/PXlQGN6Ee24aGayAedH
4VD/oFa12vQH6llxEbG+vPyzqDNQt9o7DyAjwRWI4jkXV/i2gMy7o/pLZGh26rSk
XowC16AXuKklLK6qLUysdel+yVFTSp5yXUOe20whwZe3Q9GxM05plrUD5lNJ5Sxe
o7DSXiacImZCuCjhjpPhYgZpxHv8/w==
=iv/l
-----END PGP SIGNATURE-----

--a5Hbs5LAOYUyUbtQ--


