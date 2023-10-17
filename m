Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C381C7CCBAF
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 21:05:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qspMk-0007ic-Kx; Tue, 17 Oct 2023 15:04:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qspMh-0007gA-Vf
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 15:04:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qspMg-0000gT-3J
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 15:04:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697569464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3fGUj1Z+Lsm3l69AufSHTGDEbD0yLUmaj8Z3b71VW9o=;
 b=USpG9st4Xlzhn7DCeCuLgEWvU4q1xNcl7TnyDj9rL8N+x10PjEaXMwtYDkYY6J1L9GGyUq
 mF7ZAXrUAHmVtNchG26iDmpPC46eYdMvi++6MFhp5VqeJA6KVlM1gMpodu5sDkuZ5Lq2S5
 f1tvKN2Hgqnpc419LfABuQYkDrhDV14=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-364-jJc4X93qOUem4jk--cSX3Q-1; Tue, 17 Oct 2023 15:04:11 -0400
X-MC-Unique: jJc4X93qOUem4jk--cSX3Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6CB2F29AB3E8
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 19:04:11 +0000 (UTC)
Received: from localhost (unknown [10.39.192.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E1543492BFC;
 Tue, 17 Oct 2023 19:04:10 +0000 (UTC)
Date: Tue, 17 Oct 2023 15:04:09 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, stefanha@redhat.com,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PULL 0/9] virtio-gpu patches
Message-ID: <20231017190409.GA243642@fedora>
References: <20231016135404.899743-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xhM7r5BHSxNc6zCh"
Content-Disposition: inline
In-Reply-To: <20231016135404.899743-1-marcandre.lureau@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
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


--xhM7r5BHSxNc6zCh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--xhM7r5BHSxNc6zCh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUu2qkACgkQnKSrs4Gr
c8jzmQgAnAha43VecGDbjSWIBXppbBPqWR7BVB55YdH88yJOsWLSusMJu7wmFtWv
QzgFTMt1IHbAPlVFDETKxKQ6gI69r4FgwaYW0GxYXUSRTx08rdUnKVppglCU/KnF
M5mgQim6vaiESDgpxx9C9w5pSJmJap3Pa5kXkfzcvxEqnPNhkcInEScfNiAvP+bA
xPDgF575Y24lw+Nl2BEhLv9l2/hIbKUmBeaUMnyukTZ7KTVNr2SepGLdgw+It7Yh
51qe+YZyLXF8OOQFuDIRLc/1r89aGifDMo356HYDEQJ8HuFOvcdp8m2SWFaUeCHB
s6jE1l/AzyJpCKZHjn3rkDBHEvg+UA==
=j/Zd
-----END PGP SIGNATURE-----

--xhM7r5BHSxNc6zCh--


