Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7434C811AD8
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 18:23:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDSwG-0006rN-TN; Wed, 13 Dec 2023 12:22:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rDSwE-0006r3-IU
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 12:22:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rDSwC-00013w-QM
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 12:22:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702488142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dtvIzkvphsV6qYj9ygT46S/BmyRR915C9vUyPGz8qXI=;
 b=HGD+5Mr9ZeRuyWa8AUZSA9V45arQZ3v3JwYb5a0aIMTTVv7ft+pJpD7D69WkjnKUbsVyWO
 QPDIRxN1zzWHWvmfFwABM1KC3l0w3LAp71RhvFP+8/lXTwsr8/fCmGjMSABJoXlviWTNdq
 YMGM4+3qkbDO9/a9exq0iqIDzBOoHN0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-2aUOdMW8OiGHGegGEn2d6g-1; Wed, 13 Dec 2023 12:22:17 -0500
X-MC-Unique: 2aUOdMW8OiGHGegGEn2d6g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CE541101AA49;
 Wed, 13 Dec 2023 17:22:16 +0000 (UTC)
Received: from localhost (unknown [10.39.195.82])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4EF5051E3;
 Wed, 13 Dec 2023 17:22:16 +0000 (UTC)
Date: Wed, 13 Dec 2023 12:22:14 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org
Subject: Re: [PULL for-8.2 0/2] Fix for building with Xen 4.18
Message-ID: <20231213172214.GA1490586@fedora>
References: <20231212102214.243921-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0Wgl8AaisvWEDnya"
Content-Disposition: inline
In-Reply-To: <20231212102214.243921-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
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


--0Wgl8AaisvWEDnya
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--0Wgl8AaisvWEDnya
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmV56EYACgkQnKSrs4Gr
c8gquwf5Aeq8WiUtHDCw+2NQZdliFUNKUKIv6mj2EuccshvQ3n8YhcMq3mX1zt0r
wyYHUSQFPx87+kSP6D9/PjowAGl22SDX8ZFjEHzI9jkgwORx0KDVZ5f3jXD/Ptn4
DSMDEEz3UDnZHSqXruZvyi9c2ZkjGeNpjTuEeRUuz0nKf02xKR8C5WYFrJwm+FPM
5BzVS75+QyE+K0LxLhFzhJP23RbnAf3bAt/3hyvxxHFCaYyLoNkwM1ZjCQfoIogN
cM0/NWpQ7y4JLK7X8AvFtcniwb5z/1Wsg0sGw6izfsvhMFKOoEl4Is3xkz+S2EF2
px01B9mAOBbdCe8mLssT3iuY7+MuoA==
=AfLu
-----END PGP SIGNATURE-----

--0Wgl8AaisvWEDnya--


