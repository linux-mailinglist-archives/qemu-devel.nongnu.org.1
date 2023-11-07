Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0B27E336D
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:03:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CMc-0001Ft-BI; Mon, 06 Nov 2023 22:02:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r0CMN-0000xb-3Y
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:02:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r0CML-0008Ue-Bp
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:02:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699326149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YUJYzoUcN2fQNaCVVEajGtdtPWHtd+VJ6XLl/ErWdxk=;
 b=bT1kwRnmzCJt2lUtkTz7eaQfy1nwoYBTcTdu8Yk1zgM8qnsHVBmOYXqDy71trgKRyqWlP4
 cSc6xay5ECCQK1cyu/Ewbivtkfqcayc6w7W26lMzZuWzionH+YojqZfm8YgubgScZaeZIq
 ov8IggYkY8wszVIxnRcP+5l+xiI0XU0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-YixyhY1tPsKZOHFDPgHhkg-1; Mon, 06 Nov 2023 22:02:11 -0500
X-MC-Unique: YixyhY1tPsKZOHFDPgHhkg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4B12585A58C
 for <qemu-devel@nongnu.org>; Tue,  7 Nov 2023 03:02:11 +0000 (UTC)
Received: from localhost (unknown [10.39.192.48])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 793E92026D66;
 Tue,  7 Nov 2023 03:02:10 +0000 (UTC)
Date: Tue, 7 Nov 2023 11:02:08 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, stefanha@redhat.com,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PULL 00/10] Gpu patches
Message-ID: <20231107030208.GA952689@fedora>
References: <20231106133219.2173660-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="35iUHam1Sxf8L46D"
Content-Disposition: inline
In-Reply-To: <20231106133219.2173660-1-marcandre.lureau@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
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


--35iUHam1Sxf8L46D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--35iUHam1Sxf8L46D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVJqLAACgkQnKSrs4Gr
c8jWcAf+M4cBbsgh7Del3Y+o6mFvtK5pO5kZRkNgCS8umEJOCJ5jWVIOBNk2ECA4
WBW4DwoP0V7baBzO5/tKdQcFAOCtPEwcQmdkiOATBSxXpFROmhS60KVfYAg3ScpF
8uSihZl7mK1oUsInAp1gYW3dl8PMOtFRCeBuy0/wYWZgquUywQWp6sxnGWP3Thnd
evyi0F+pK4atlN/NWYYrMU+5KydPncnl3Cfd9EiC+nJOlJxH4d/K/7FTuT7Tt99e
NHQTsaz9sl9r3OMJQvTjtb4FLUwdywXFagUmdDyhA28uvCRMzcgM1WzG9CCoV+Lf
YZna01vdQm2kCaBT3NUn3g3emElDVQ==
=GjDg
-----END PGP SIGNATURE-----

--35iUHam1Sxf8L46D--


