Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 236B0A14464
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Jan 2025 23:12:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYY4d-0003yZ-UQ; Thu, 16 Jan 2025 17:10:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tYY4V-0003xd-Ul
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 17:10:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tYY4U-0004JK-7i
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 17:10:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737065437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3w/7Xt83amm/l8+9d346Cvv8xvPaOw1+n1RLVeOI+Fc=;
 b=TwBP20p2V4RFSwnLVx31Vx/h12+MTWDgDheglYw1eKR3z72SXSROrY1WUUQDkC3bbyVvDT
 U1LMI2uCmyaoHaFMU28APK3ZznXMEqLUVB6KVUTtF0gFl422y8wPI1nZG5SFZzZ/EmK1X+
 JGlBr/8n+c0shOO8OjTe1qeKht9EC68=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215--MrRq8HIO2CqLybNWlljYw-1; Thu,
 16 Jan 2025 17:10:34 -0500
X-MC-Unique: -MrRq8HIO2CqLybNWlljYw-1
X-Mimecast-MFC-AGG-ID: -MrRq8HIO2CqLybNWlljYw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C5AD1955DCC; Thu, 16 Jan 2025 22:10:32 +0000 (UTC)
Received: from localhost (unknown [10.2.16.180])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E5DEA195608A; Thu, 16 Jan 2025 22:10:28 +0000 (UTC)
Date: Thu, 16 Jan 2025 17:10:27 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Jason Wang <jasowang@redhat.com>, xen-devel@lists.xenproject.org,
 qemu-block@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>,
 David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [PULL 0/8] Xen regression fixes and cleanups
Message-ID: <20250116221027.GA378432@fedora>
References: <20250116084332.1864967-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="8HLMaDdlMH1p57ew"
Content-Disposition: inline
In-Reply-To: <20250116084332.1864967-1-dwmw2@infradead.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--8HLMaDdlMH1p57ew
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--8HLMaDdlMH1p57ew
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmeJg9MACgkQnKSrs4Gr
c8i1bgf+MHoLNCA3PrVNq+8PBjcLbABt0e/iUMP1lMjdZbfbSuXOKnOXzkuuV4j/
B4VgoC3lPDm5BLF8YmliXE377/khnnh87uFifbar35rL/CZ/FQaMQ1+LSmqx5muk
B38lJR6aA16v/FmcOfQiIe3ucNcqVoxUGLMUD9maouS05t0EhSN3ZYEbwn8lU65O
8OoVoBRgKlBH+3KQf+x5pdKC8WkFm1rzhak5WfY2G7kghzspSYvTaz9z2TPfgobq
ejm6N8Nstls4VrqBOPUzcuJpOC5nDsx1DgabuTiGWkPwSZ1wccDNn+rfJkb85tEz
uO8oEL54Z5Ie9w4+tfuhOl7MdVcLiw==
=eYTV
-----END PGP SIGNATURE-----

--8HLMaDdlMH1p57ew--


