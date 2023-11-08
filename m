Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDAF7E589F
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 15:23:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0jSA-0002dm-PC; Wed, 08 Nov 2023 09:22:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r0jS9-0002cZ-AU
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 09:22:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r0jS6-0003iB-Cl
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 09:22:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699453357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BYoGSyNTntXyU4y3KBaBNAnudTqyhut204YypCfLaUk=;
 b=dQTdbwZew0vgYRmUFILRvmfEhhE7y0PESHRdmg0OiJXjdsm2o40dSQBikoJAM6zLkiuWkb
 NneMGujsRj/LCRv9CUEDDjYPSISu4jbJj4ECrVh7hNpMENxv++rAZ1hTp24pQ1VPBk6ldg
 zb7lJVrd4+L1mHMgmHa5HPoq75vZcDQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-CJecKoBmNaCyy5UAiPDiRg-1; Wed,
 08 Nov 2023 09:22:34 -0500
X-MC-Unique: CJecKoBmNaCyy5UAiPDiRg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CC8DC280AA20
 for <qemu-devel@nongnu.org>; Wed,  8 Nov 2023 14:22:33 +0000 (UTC)
Received: from localhost (unknown [10.39.192.179])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E2A3925C2;
 Wed,  8 Nov 2023 14:22:32 +0000 (UTC)
Date: Wed, 8 Nov 2023 22:20:10 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PULL 0/5] Misc fixes patches
Message-ID: <20231108142010.GA1062256@fedora>
References: <20231107190817.1607710-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LOE9d2Utzo46qUcB"
Content-Disposition: inline
In-Reply-To: <20231107190817.1607710-1-berrange@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
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


--LOE9d2Utzo46qUcB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--LOE9d2Utzo46qUcB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVLmRoACgkQnKSrs4Gr
c8glEwf8Co/zVbgItaXXyRJIRaQT0HWj8KZNce1d+5Q3pANOglO1pYdfIML1y5Bj
3atcj/Z0kN2Fn263e+FtOo/rOzznPaojkgeRynJNH30f9GBezIVNuVTTiP5gcyVU
g4Z8XdfMDne7YLgRNgOlmki9xBFAKRDx+68c9KlEbC+tJkApqldHU2KWTufIwV83
XVKhKzBC05OcPsUyJWjYevimmvo+0bZFXbfo+95hYQlfvixNnAlqnVqgzMAzqQ0U
1TcDfzFdxutaJdl83tY527QGX2guYZCqxN7W/VpeQi9FWoh0tIK3vPnJuLLSVTMg
GXxceJfQ5dr2HjGFoK0ZIK35KQNO4Q==
=ErGx
-----END PGP SIGNATURE-----

--LOE9d2Utzo46qUcB--


