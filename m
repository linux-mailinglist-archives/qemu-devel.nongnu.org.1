Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C57B02F06
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Jul 2025 09:10:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaqqO-00058N-FD; Sun, 13 Jul 2025 03:09:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uaqnQ-0001ns-SJ
 for qemu-devel@nongnu.org; Sun, 13 Jul 2025 03:06:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uaqnP-00078O-3L
 for qemu-devel@nongnu.org; Sun, 13 Jul 2025 03:06:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752390405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j16BD+2Q7WR3XkCFCJ/I4hKgjODFQOrTAGyOnI71SQI=;
 b=GnTLFR/UCEhKgTyYTujt1rMKugQ1JnKf7m4FNOjeTawcfYNydHNfehsTG4k4UnVx8hlXjv
 +yosAUB2N5SsBTEEn6RxXQirfGqFakewq2+4h0Hg2b4Rn4Sl3i6WtnO0DsKdQ9K4rg1ynM
 Q2sbd2yrkPDql0OSAlDVjzpwVVgbfrA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-YRIPJmgJMdqUtm7e_rsyYg-1; Sun,
 13 Jul 2025 03:06:43 -0400
X-MC-Unique: YRIPJmgJMdqUtm7e_rsyYg-1
X-Mimecast-MFC-AGG-ID: YRIPJmgJMdqUtm7e_rsyYg_1752390402
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2CB0319560AA; Sun, 13 Jul 2025 07:06:42 +0000 (UTC)
Received: from localhost (unknown [10.2.16.7])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6CD3619560A3; Sun, 13 Jul 2025 07:06:40 +0000 (UTC)
Date: Sun, 13 Jul 2025 03:06:35 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/36] target-arm queue
Message-ID: <20250713070635.GA204657@fedora>
References: <20250711133429.1423030-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DII1S7/sWofPFsN1"
Content-Disposition: inline
In-Reply-To: <20250711133429.1423030-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--DII1S7/sWofPFsN1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--DII1S7/sWofPFsN1
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhzWvoACgkQnKSrs4Gr
c8g2MQgApXguttugxVGHWqhK28XLC/XABQaiwzFKGXwwWW62XfuHz9GUR7DOENrG
NdOKYTGhKJ1BZgOW+tmKKrIRhtJzFw2i9KxZH34Rv0vbiKH5q1s602rOFc+BM2S5
Lufl0wIPbsZjfMhv6VBkdNxcZQAvm2gaNUg83byWsxxz0+KumzatYq16O6FzRaT6
g6OfqCntDYCsCOHuQx6JpnHNaDJgr/Q1aGVtKIVqOPoKZfWroAB3zwhYHWyC6ucK
UIcgzpHvbB5DcKdiL32OCPVDVW/AHpdJGs0DPtq9GisDqgYqobEtprtC7dDA2pfS
NtD51RDrdmBHNHuXG0Jaarzb4Tzlmw==
=u0Tn
-----END PGP SIGNATURE-----

--DII1S7/sWofPFsN1--


