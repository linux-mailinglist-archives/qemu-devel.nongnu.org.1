Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C62A4C004
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Mar 2025 13:14:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp4gE-0002rB-Kk; Mon, 03 Mar 2025 07:13:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tp4f8-0002a7-Dn
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 07:12:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tp4f6-0004S7-RS
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 07:12:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741003963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VwAbQbX7EJPekNcjtg5SVNCtRKf79I4dDS4/lO07Q2s=;
 b=EktAwdbtTllBEwn5nstdKpQmO8yHEUu/Zw/+kOLLK/Rh9Wm3Ff/IBzx1qMCSDePzk7DcQ1
 7jfTimCXwmj3TR49kYfcQ3gZvv8tJFM1zxLcOOA5WvgZ/PpzC/ADGoGvkNFcTKY2p9vDBy
 GP2rNWuMblkGLTf7SwK3TGE76bm2HiI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-363-C3Zfhj2DNVWr_V04kSP9_Q-1; Mon,
 03 Mar 2025 07:12:37 -0500
X-MC-Unique: C3Zfhj2DNVWr_V04kSP9_Q-1
X-Mimecast-MFC-AGG-ID: C3Zfhj2DNVWr_V04kSP9_Q_1741003956
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 82BA71800876; Mon,  3 Mar 2025 12:12:36 +0000 (UTC)
Received: from localhost (unknown [10.2.16.61])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5EC881800374; Mon,  3 Mar 2025 12:12:34 +0000 (UTC)
Date: Mon, 3 Mar 2025 20:12:32 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Konstantin Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PULL 0/3] Misc QGA patches for 2025-02-26
Message-ID: <20250303121232.GA215632@fedora>
References: <20250226122120.85790-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="fHLOay16/Ks9Ki2x"
Content-Disposition: inline
In-Reply-To: <20250226122120.85790-1-kkostiuk@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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


--fHLOay16/Ks9Ki2x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--fHLOay16/Ks9Ki2x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfFnLAACgkQnKSrs4Gr
c8gOwwf6AjQ1OmeHFQn44dyir+o6qfuXARcCTIdfgTwKmVd4zsL5ixOomxRInhNa
t0LiWK3P0Ig62Ec35jTwXAgxzBZcL/4AvukxIwxnn+7aTJVdTJfWqLlzXJGgRHCi
72X9ELQ7ZTkOa5KspoblcZt13cdBnC7kNHzgE/pet65PJP0/bZI93UA3omAsx8dh
rqAjrWL0BxXO0tZROj/2BlYuQo0JJj2ZcOzU5WFTJXksj7M+bdv9V2qLY86L/JN3
asNxM2eBoIVHAbBPR8Odn4en/XL6/QmYWexG4X3UPzvxMZNQRYDmoin0EOFDswdS
pFn3hDP4fVWGAxZBu3HM2DFjWqLabQ==
=RpUb
-----END PGP SIGNATURE-----

--fHLOay16/Ks9Ki2x--


