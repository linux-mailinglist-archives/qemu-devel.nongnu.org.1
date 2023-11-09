Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F41517E626D
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 03:51:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0v7t-0007XX-Sz; Wed, 08 Nov 2023 21:50:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r0v7s-0007XL-3f
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 21:50:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r0v7q-0005nB-IB
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 21:50:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699498233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MSJXR9qkbEHtLSHUG0haSiGWMa0xei+Qd/AQV4LZMqw=;
 b=DNQkRajSZH2WE85uebb97UdOtyjkQSYIpQM9A0Ehi0iauoofCQy7xQ7pd12Fc31NRIMmqc
 Hw8fBMiBfQlQ80RKdwMq6zrCHV1qW1HT/6HNUK0feEuZVtbs6WxOn/EePKs1lZMZUlzxFT
 fTiKlwm/+w2HzIzGfP6ZrJHgA73gDEc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-KEOE0S_hORezlHUuFvBs1g-1; Wed, 08 Nov 2023 21:50:28 -0500
X-MC-Unique: KEOE0S_hORezlHUuFvBs1g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4FAE2803C8F
 for <qemu-devel@nongnu.org>; Thu,  9 Nov 2023 02:50:28 +0000 (UTC)
Received: from localhost (unknown [10.39.192.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8EA1B25C1;
 Thu,  9 Nov 2023 02:50:27 +0000 (UTC)
Date: Thu, 9 Nov 2023 10:50:24 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com
Subject: Re: [PULL v2 00/25] Block layer patches
Message-ID: <20231109025024.GA8088@fedora>
References: <20231108165841.102073-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9RSd0e26FEQ974zs"
Content-Disposition: inline
In-Reply-To: <20231108165841.102073-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
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


--9RSd0e26FEQ974zs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--9RSd0e26FEQ974zs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVMSPAACgkQnKSrs4Gr
c8i6TQf/V3oQhlYaJ5VV5GZ7VWSNI7oRoWEdeeOiSiDE5iRmgadOzPYauY4khxlc
giy3mjYqPY9iJWucICcPFwb6SxFItnV5I6FNpepo3FDbpnQRhecUhUbWIAT2Ls/N
B7p9lghOuyjFkYxy2eS1I+OPSjJtRzkMC33lAMufpuYQDBq9z19bQ2OOTGuHnFNf
S2rRackJ1C1v+D5vpMpgwZcMj5qf7Bc1kLb7LbD26h6akEaRLr+FNdXGiEIM92If
lBDoesyn6nV//C5JcGTZfk48F+FbES6uIAyj+MzSaQ9dS8abynsJhwn1l/JYNXf1
khTP8n0jNxNIEqgNpnxQfbPpSxGXVQ==
=PeWa
-----END PGP SIGNATURE-----

--9RSd0e26FEQ974zs--


