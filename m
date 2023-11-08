Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A70357E589B
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 15:23:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0jS9-0002c7-Ht; Wed, 08 Nov 2023 09:22:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r0jS7-0002ad-9u
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 09:22:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r0jS0-0003hp-8b
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 09:22:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699453352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5mg/bcYBBgYT1nUrcanUbO7u3Pmumg3opUbeSUZ3QOQ=;
 b=I5IlpIMnl0souUXDHQB1FEEx9l0BdibOlpP0fhpcDl9UgyWcm1aa7xDCUj1oQyJxtBoJPN
 Snup2E/lvTRhQg5VV8Hv4bNnKL0DICSyv2XgXe09olU5rhBuHj11Lz4XCENBclM0IyQg0x
 izhUWkY1Pdp/HXpMisRRwbTdfk6teEw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-0tukRp23NiyzNK2_sYNvqw-1; Wed, 08 Nov 2023 09:22:30 -0500
X-MC-Unique: 0tukRp23NiyzNK2_sYNvqw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 22E7E101AA42
 for <qemu-devel@nongnu.org>; Wed,  8 Nov 2023 14:22:30 +0000 (UTC)
Received: from localhost (unknown [10.39.192.179])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 585C6502B;
 Wed,  8 Nov 2023 14:22:29 +0000 (UTC)
Date: Wed, 8 Nov 2023 22:19:55 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PULL 00/11] s390x and MAINTAINERS updates
Message-ID: <20231108141955.GA1062224@fedora>
References: <20231107183228.276424-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PyP6dpBOIhixygQM"
Content-Disposition: inline
In-Reply-To: <20231107183228.276424-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--PyP6dpBOIhixygQM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--PyP6dpBOIhixygQM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVLmQsACgkQnKSrs4Gr
c8isywf/Wy4UB0majs2CidKlYtpg3BdltMAHxmVUoN/FNbH51ok96APV4S13XH1T
WwjoJJyeeDEg9uCb9GzQ+Z9sM3h39WxszoD75iJ/o8dKSsNBXBovXKc7L0bRwlwn
5pwSAtWmDxeU3xKmg9y47w2oGsVDZ81qs/VKUUqhK2k87a6QS6O0L471+elIOteX
9EzmXdksLmT3jO1II/US0sI0Q2yZ1A+lC/Q4hGAYRH9k6iplgPQuTjct8Uo38vV8
IMEi+LrAyJwiq7+6F7azjNx2DxFSnCwsfdQxRM4G/ku3x+iXPK2FZeLTBkQF6U7U
DPyO6uCgAx2hS18WWOFu8w3AYc5+HQ==
=8aBm
-----END PGP SIGNATURE-----

--PyP6dpBOIhixygQM--


