Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B608060DB
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 22:34:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAd2J-0005KK-2d; Tue, 05 Dec 2023 16:32:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rAd2F-0005Jn-JP
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 16:32:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rAd2E-0007ZY-3R
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 16:32:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701811970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FpZKZOvJ21Pc/b19keqg69iPhC6H4JcTl7dCU239Hvs=;
 b=TUuGN9kxfHIWgp44nlGyVACInnuZytILHFO/jzqOxD1tsEXEHM3dIeIncTxD26xEJIZP1+
 KNLUJzEwHVDkc2PQomSWySAajjrf84u4asqpxvB0NidOJU+b9pkfkbLAwbQY0PPFTDYtwC
 vy5fcpwcwDqttlRhpEIc7RmmxUMtTOQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-249-OCYAGa4nOJurFuXJZgeN5A-1; Tue,
 05 Dec 2023 16:32:45 -0500
X-MC-Unique: OCYAGa4nOJurFuXJZgeN5A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 045713C0257D;
 Tue,  5 Dec 2023 21:32:44 +0000 (UTC)
Received: from localhost (unknown [10.39.194.111])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8026B1C060AF;
 Tue,  5 Dec 2023 21:32:43 +0000 (UTC)
Date: Tue, 5 Dec 2023 16:32:40 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jeuk Kim <jeuk20.kim@gmail.com>
Cc: stefanha@redhat.com, jeuk20.kim@gmail.com, jeuk20.kim@samsung.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PULL 0/1] ufs fix for 2023-12-05
Message-ID: <20231205213240.GA1997833@fedora>
References: <cover.1701752391.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3VdRyNXCOdqDl64B"
Content-Disposition: inline
In-Reply-To: <cover.1701752391.git.jeuk20.kim@samsung.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


--3VdRyNXCOdqDl64B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--3VdRyNXCOdqDl64B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVvlvgACgkQnKSrs4Gr
c8gxzAf8CKmeHw1VdzjnU6o229lYV8PvyFqkUqsNXNiTsmcYlN5yjxl19oWCbtvP
E8KOy/0eVz6V9QtLIBOM1cv++h2lEM1W2uXjJCytvfMmnbPpQFzTjX8PAOAylxqc
N+Ya+Y1cQJtbsHdQV4/zT7vrmD6xc7neN/SNYHVyZ+FOv1myFpzOrD3jXYNEcGk1
qyHFfNXEisZ8ZhxIIuqRgbAXkLd2s4kYmN24zpgq8ocChtvJHtz81ebbjSjZfGie
jmxa3PuBST5CJELvPNS2EcQRxaG4PHe5bYXhfwGekUhlSTSUHo0gqFOb0iRi36Ub
mM3oa5ylvqJ9fI21uHs/NCpt0b+GHw==
=FgM2
-----END PGP SIGNATURE-----

--3VdRyNXCOdqDl64B--


