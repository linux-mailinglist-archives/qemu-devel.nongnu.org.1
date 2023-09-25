Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACEB7ADB95
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 17:36:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qknd3-0005Bd-6V; Mon, 25 Sep 2023 11:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qknd1-0005B4-D9
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 11:36:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qkncz-0001N6-Ii
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 11:36:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695656164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AapqIH5btS+DfaJb0yG0ZXCmgoun+rE/HM23Y0piMjI=;
 b=iPA7dwQSfiJdXXgd5wJsfXa2sAAG5ujHa9ZlA//fsICD25eSUGwCsVjmeMgG5VCVwcZaFp
 wNfgeoGLut5J8IDZdTmOfmuRY4Xa5NITg2ZWq4dfDVfJKOiisvnmx0dYq//dLZInussEZR
 qGy4/FnxzfPWr8ELlaWxLMBCAbM3JDU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-690-tInGCYs-MDyM2H18nWqdHw-1; Mon, 25 Sep 2023 11:36:02 -0400
X-MC-Unique: tInGCYs-MDyM2H18nWqdHw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D281E802D38;
 Mon, 25 Sep 2023 15:36:01 +0000 (UTC)
Received: from localhost (unknown [10.39.194.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6901910CD7C0;
 Mon, 25 Sep 2023 15:36:01 +0000 (UTC)
Date: Mon, 25 Sep 2023 11:36:00 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/30] target-arm queue
Message-ID: <20230925153600.GA309747@fedora>
References: <20230921173720.3250581-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="I30WY1tsAFS25r8L"
Content-Disposition: inline
In-Reply-To: <20230921173720.3250581-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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


--I30WY1tsAFS25r8L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--I30WY1tsAFS25r8L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmURqOAACgkQnKSrs4Gr
c8jXMQf6A5ez6S0Vk5wyZ+VS7ma78CHIvwSsHlLfuXKs7fDEdNxOSV1WFzR4ACC0
e8f3XFx7cUd3UnTjTasMHzBP82JAsBc5wkAVYt9/jfCDAuQw5L195vIHUqqGB9o1
Ktthb7aI5KhtNpn5RRdvk3rX3rx/RKPSUkPp26nOstf3hVKF26XLWvlyWM98zrrm
VCNmaO1nb5cThnrYX+EPouw6wS99PdPZYa87St/T62Uha/QqZY0rDniaxGIduW0N
BP0FNQN4ubTGPzvAhyD5C8Wb2fQ1ckytl1vxjdJWM1s1E49f7WyOI6qxrqy0GQES
9bnJORDVvHR6yLpLuAochxYbDuvtQQ==
=taUE
-----END PGP SIGNATURE-----

--I30WY1tsAFS25r8L--


