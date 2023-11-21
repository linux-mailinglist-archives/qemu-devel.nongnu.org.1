Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B0E7F344E
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 17:55:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5U1J-0000nF-GX; Tue, 21 Nov 2023 11:54:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r5U1G-0000io-Ed
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 11:54:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r5U1E-0007Yx-Pr
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 11:54:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700585671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=owN1PKIZmH7D5LFrIlrSJpgCV1U699E6nP7xgrXvt/E=;
 b=buLThD9xaIx2+70yUZci+of2H5VVTlxD9gaJCjjOJYj15kDvKoKqdhuT+GU6UZUY7kps9a
 K+AtaHE7v6JAO4dmdlFzJRpSPXjWLUSpKv7HxpTY8hKjJxxtJpIPXO6evxytzTACmVvT4P
 3TacmHdkxh0+6zYk4cEW3gYSCEVk0bY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-SAyZxSTTMfqvmWjwq9yZyg-1; Tue, 21 Nov 2023 11:54:29 -0500
X-MC-Unique: SAyZxSTTMfqvmWjwq9yZyg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4EC8A881E27;
 Tue, 21 Nov 2023 16:54:29 +0000 (UTC)
Received: from localhost (unknown [10.39.192.113])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D0C7E1C060B0;
 Tue, 21 Nov 2023 16:54:28 +0000 (UTC)
Date: Tue, 21 Nov 2023 11:54:27 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, kwolf@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PULL 0/9] Block layer fixes for 8.2.0-rc1
Message-ID: <20231121165427.GA3769075@fedora>
References: <20231121115302.52214-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NtqgaB/2lvhgJgH4"
Content-Disposition: inline
In-Reply-To: <20231121115302.52214-1-kwolf@redhat.com>
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


--NtqgaB/2lvhgJgH4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--NtqgaB/2lvhgJgH4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVc4MMACgkQnKSrs4Gr
c8guYwf+K7sgaiz0xMi6zwIbk4vZKJLbXfrLenMIWtpDYQhqNgRkz7KIeMe1Salj
vVk5af2/ZjqnWTqXx0e+wArVz/kmvH45T3/4NnELXlgm5vMM8m14dtDRMF1d3gbw
yxH3dZfBbLg5x2Wwd9Mp2i9Yc5ajcmSW6KGGPzR8P6Qd3XNM6fuqlLAQsR0Jwa3B
rouOpLnFpayq/dv4JfY3rAGQX4VjqdBq4e8xwe0UpIiL7N1/HbVGfaG5uiMKMgO2
oHwRthbm3M0B4AcngyqHrycsdoBgf+9oe5ZCH3x99186g66lyGm/jxic+bRxHLkB
oNcoYWLsnqHIGHkaaw1nT+gqB5kXvg==
=04kO
-----END PGP SIGNATURE-----

--NtqgaB/2lvhgJgH4--


