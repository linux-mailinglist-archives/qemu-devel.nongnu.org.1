Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D227EB593
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 18:35:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2xIW-0002ni-Dx; Tue, 14 Nov 2023 12:34:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r2xIU-0002lf-U1
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 12:33:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r2xIS-0003XM-Aw
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 12:33:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699983235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G7I0/ZsqtAwG6FD7Thsu54QsDhUzInxNTC+gyDC9nIc=;
 b=C7onf1XL96vMmrtfk+MpckSzhQi5uxN6P+t+pqV+VI/oI4AqrqqUzDHV04pfbBBGX11Gdm
 rJJ86YAwl4EZUa6viq9jMHCT+zA2fwO//P+VVErcdo3AfekfhMwor7owUeEcK4r12Uf9rp
 ylTjQ/38SdVb7pMBWrYFkG0I/oQIaOk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-SR4vY2u0MU-j0PR3SM6fIw-1; Tue, 14 Nov 2023 12:33:51 -0500
X-MC-Unique: SR4vY2u0MU-j0PR3SM6fIw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB4B582A698
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 17:33:50 +0000 (UTC)
Received: from localhost (unknown [10.39.192.64])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 313512026D4C;
 Tue, 14 Nov 2023 17:33:49 +0000 (UTC)
Date: Tue, 14 Nov 2023 12:32:07 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com
Subject: Re: [PULL 0/2] Net patches
Message-ID: <20231114173207.GA274041@fedora>
References: <20231114030937.5461-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="1UjePoJGsShPpOBP"
Content-Disposition: inline
In-Reply-To: <20231114030937.5461-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--1UjePoJGsShPpOBP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--1UjePoJGsShPpOBP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVTrxcACgkQnKSrs4Gr
c8g5CAf+PA3Ez/SCrui93uBjA9usZP3TZvB7neNb5RzVPws1KHY9fyXk56hBSgmP
/oB/WKstxo3KdXZCkxz7xj6GLuZIbEeO56eB1YFvkgkpFPv0OcZH/xun5OmxjzeQ
9Xq7pvsJzDCTMn83Y98+rG0kfxuQfsRfnL5ee42tkrxp9U4WQbXUFERhQbmUjop/
F4w1Zrog6Ha/Gy802z2Uj3j7h/7kxdAPPwu6+YQgpJzTRucAHQ65Xigt/yTZTV7B
Zj4hZSGjTyZHCalNgliXW/Q8TebSpbJEekSCVMr5CvXErd4YhhOtz9WG9NiweG0W
T1a2g5vIoMR64Lax+4RIysT6SPngdw==
=csk8
-----END PGP SIGNATURE-----

--1UjePoJGsShPpOBP--


