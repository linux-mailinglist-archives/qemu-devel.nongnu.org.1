Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E117ECA8E
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 19:35:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3KiI-0005hZ-F1; Wed, 15 Nov 2023 13:34:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r3KiG-0005hL-GS
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 13:34:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r3KiE-000320-WB
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 13:34:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700073245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IcTy9NgMgYprDx60No81iOkvL5M+7HEtJWEb3Rwnilk=;
 b=KK3HPO1XxPMD6jfsvLOZVoFE4VSr7FMo+ZA17pRV9UdZbMPn0868yXKrwD6uGqHp6Fg5zK
 GKdRLrigx4q1rXO+/hyw/JNxauo90WtwHMNB1PEsGzpTjNQc/fO82h1cuBe6Iq1UROQKaK
 oLdkbGvgTPnWFR09AiXBZuNOtI1v5V8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-UAlH5Q9PPDKAT3m3060QrA-1; Wed, 15 Nov 2023 13:34:02 -0500
X-MC-Unique: UAlH5Q9PPDKAT3m3060QrA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B0C7E85A59D;
 Wed, 15 Nov 2023 18:34:01 +0000 (UTC)
Received: from localhost (unknown [10.39.192.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 34F571C060AE;
 Wed, 15 Nov 2023 18:34:00 +0000 (UTC)
Date: Wed, 15 Nov 2023 13:33:59 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/3] tcg+sparc patch queue
Message-ID: <20231115183359.GA315832@fedora>
References: <20231114192656.176451-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/b/VtiUq9aeZ9Q56"
Content-Disposition: inline
In-Reply-To: <20231114192656.176451-1-richard.henderson@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
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


--/b/VtiUq9aeZ9Q56
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--/b/VtiUq9aeZ9Q56
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVVDxcACgkQnKSrs4Gr
c8iOMggAq3HQy+8OWIKc8JhCVkw1EkoulD0ayHiTH9/95SkrgiC/wNpkgjCJ4++a
sLq00bwLGmEbvNHFnPQEL6UhQLR8oOu0Z2EBKrLFJgL28V+IDS/PM9fQKn62F2gX
yTdyHgb344WZYHOvuLfcAjcdCb0YMsc+8gh74gVtl0Q4BuayBYABFQQQDaFl/Pzi
a9auUM+8EuhIoOUSC5yloQAPh2JmdIgw0c+BcekSYqwzm32tjn+rlUuGcpceIrRR
UKvi5S/QhCNn96EMRZrCltSOH1X68SVAYacVRgt7cy4M6Q+0BmdMgRZBj4o+Hwau
YSVnXpYXUhytOOC4g2hO+HO8Xe4EAw==
=6cJW
-----END PGP SIGNATURE-----

--/b/VtiUq9aeZ9Q56--


