Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A957811AD7
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 18:23:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDSwO-0006sn-H8; Wed, 13 Dec 2023 12:22:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rDSwL-0006sS-Sk
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 12:22:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rDSwK-00014h-FD
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 12:22:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702488152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eGNMg1fo9MWt90cZ8ze06eimnj4/imgGncDA1tSpU74=;
 b=cwAGK/jvqYabJhD6fDw1JxXLBK/x4pxpzhrU96n/1udSklqPYxv5izVncYWfUMKX1qTGf3
 ArSCfS5ah6qj9geAd9IfnvoiysnUt3zLRQC/WnD+v/N2Y8O+qXFSHrcyxLVBGqIuZkKjMD
 yoSe+mbeZkCYUjgfnTXutFVE3rv3eOI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-122-dwLWsyC0PgqiQ-tYGahbVQ-1; Wed,
 13 Dec 2023 12:22:26 -0500
X-MC-Unique: dwLWsyC0PgqiQ-tYGahbVQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5BB8E1C06527;
 Wed, 13 Dec 2023 17:22:26 +0000 (UTC)
Received: from localhost (unknown [10.39.195.82])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B3DEB1C060B1;
 Wed, 13 Dec 2023 17:22:25 +0000 (UTC)
Date: Wed, 13 Dec 2023 12:22:24 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, kwolf@redhat.com, stefanha@redhat.com,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH for-8.2] block: Fix AioContext locking in
 qmp_block_resize()
Message-ID: <20231213172224.GA1490642@fedora>
References: <20231208124352.30295-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="rZjCxxqwmMvhWOa+"
Content-Disposition: inline
In-Reply-To: <20231208124352.30295-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--rZjCxxqwmMvhWOa+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--rZjCxxqwmMvhWOa+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmV56FAACgkQnKSrs4Gr
c8jfsQgAvWHNUzmDIjv0EP7mOg8JKjFr7gx6lrHxIOZoGlG3V/GT7o27YNvKWBEQ
o+2L3ZUi6/nrn8UklLr7fKq4OxL3JixB0kKVBO4m3gxVzSMzqwMtL5mX6ChCEERj
gIfS/yqt7tx2jyE5IO6HfJRm1j08PSahnGI9jOXf2QYWEVLloPKDQDs1lR40zLOH
+E1cMYZsNLya/65K+rTOeTvIZR27fNBr031eK1FinoyTom2gMp4TOk2TZg0Dck9f
b8ELJUBtrWcxw1FpzBP3gPCgln+VbggzP5kzAZwjgXbDzaCncZ4j1CbfHZTjxSX7
WeEs3jvoxuwmZosOt7Tubu3447N/nA==
=a5S5
-----END PGP SIGNATURE-----

--rZjCxxqwmMvhWOa+--


