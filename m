Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CCF79A98A
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 17:20:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfihP-0001hy-3E; Mon, 11 Sep 2023 11:19:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qfihI-0001hN-Ra
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 11:19:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qfih7-0007Bz-GS
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 11:19:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694445559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rt4KuZIqDJ53FEmQ19YAlmJR/eXRUYxFRVrLeHhgfhs=;
 b=R8jns1YQXl6W9DA+qJDDifQwzoNJxTh+4ES1BAiVGSEpraDQR6EfS+Qdk9B/Fo5aRr7jUS
 y8upaM6nJoisrd/+mkTdeYfCyml+YRJ/W99Ri2FhGH86mkOExoJqt4+ipgcHR1tj+mXEaL
 GASbC9tblL1k2p3B13gGgxIvcqoPd0o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-ReKTSJP4PDiALaXUOSstEA-1; Mon, 11 Sep 2023 11:19:17 -0400
X-MC-Unique: ReKTSJP4PDiALaXUOSstEA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 10A46856DED;
 Mon, 11 Sep 2023 15:19:17 +0000 (UTC)
Received: from localhost (unknown [10.39.195.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 99D592027045;
 Mon, 11 Sep 2023 15:19:16 +0000 (UTC)
Date: Mon, 11 Sep 2023 11:19:15 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/26] target-arm queue
Message-ID: <20230911151915.GA4101362@fedora>
References: <20230908170557.773048-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="u34AWLRDFJ1loeR6"
Content-Disposition: inline
In-Reply-To: <20230908170557.773048-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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


--u34AWLRDFJ1loeR6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--u34AWLRDFJ1loeR6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmT/L/MACgkQnKSrs4Gr
c8hirAf+PwEY8qSt/TXn55t8QeIACmVJxdEX1qjMOfOtWMVL2v3nTH5bTGsx1y1V
LBbgcisV1WcHKmnU/PlSC+zgRSC4QlT2H3uQGo3MbYASFBZRuKQLp5ur1zsSTdqr
E+CKwoNZ1OvY7WLJDMR5hNM82nzy6qLiyAo3+zhp+e9lYwpw0YajHltFEt9AGV0+
/+np18Dr4253s91xJLJ27Xg9O2CVQpP2N7GORjhkIWIWRKRhyCUacS7271MPDu4q
ztkRetFwHgMkyeURj9d6m4BWP/LkIOmDbDTXtXSXAQQr0W4MCA1KMzujniqMkWRi
zFf9VQUvAGKe8t/pdpkh7EXF6j39jw==
=0MGu
-----END PGP SIGNATURE-----

--u34AWLRDFJ1loeR6--


