Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA48803764
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 15:47:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAACk-0004jV-Cf; Mon, 04 Dec 2023 09:45:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rAACg-0004jB-78
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 09:45:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rAACe-0003r2-F3
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 09:45:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701701142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PCbprzdfFqFK45U8PSvA3nnOJTPCVh3ncdifUNaVPHE=;
 b=PTzn97O1FijeHNuSnqUsQKCTX2czYZlEUNhIZhE9GQ4JMNrg5Ok1vdQuLOZBzaUh83VGQN
 kzy3Im+rpGF2okcYNUeO4IRVFo/dvYSpKqE2EY3XLs8adY0sAATriQYZ6n+X2WeU2lAeeB
 IvSnhAOGzv47Gt/rgOIxqoFEKC8+t4U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-tNwz5HQ6MHKwdqM6unQzLw-1; Mon, 04 Dec 2023 09:45:41 -0500
X-MC-Unique: tNwz5HQ6MHKwdqM6unQzLw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BCE9B101A53B;
 Mon,  4 Dec 2023 14:45:40 +0000 (UTC)
Received: from localhost (unknown [10.39.192.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2954A492BFC;
 Mon,  4 Dec 2023 14:45:39 +0000 (UTC)
Date: Mon, 4 Dec 2023 09:45:38 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Het Gala <het.gala@nutanix.com>, peterx@redhat.com,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>
Subject: Re: [PULL 0/1] Migration 20231201 patches
Message-ID: <20231204144538.GA1491611@fedora>
References: <20231201163613.1371497-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="fJmiFVHNYXWMY2Ut"
Content-Disposition: inline
In-Reply-To: <20231201163613.1371497-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
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


--fJmiFVHNYXWMY2Ut
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--fJmiFVHNYXWMY2Ut
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVt5hIACgkQnKSrs4Gr
c8gq6AgAw2OhkkrsomG2EvVfxSGc13nkl8SAS2fxwAOHPgit1CaGNFtJmx+yeGzX
HoITB6Jyji0j4gCdVmvxuFRTkKyUu6ZoGr/1LARGTKgVQJx0iXxHt2IqnMAII+ns
uzOr0xnNfpCpzT/0gaNH7wp0cczGpGN2rBkmez8wU3EO74inCJTjsl5KoUhc6rZ+
GQPG3+iY72cu9PnbSsk4B4m8DKJvQzwnf/uBAGg62pTTydANfDHbfAxJo5o9q1nw
PpYDfjyxoThbuVWLPlORZmgjXxiEh8WuSnylSjRENOwR5CzQOvPPSmKIFbleraew
6e87ED50K0Bst9NQDVG2pOIUZtKHsw==
=n4hb
-----END PGP SIGNATURE-----

--fJmiFVHNYXWMY2Ut--


