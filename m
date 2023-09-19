Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0B77A6B3D
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 21:14:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qig9c-00023O-Ql; Tue, 19 Sep 2023 15:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qig9a-000230-ND
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 15:12:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qig9Y-0007EW-9d
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 15:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695150775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jFwSLXxhyQW5utuc1M0bwqoJ1nvdmArquqX/KKp02QQ=;
 b=WwJMIjK3YeXSR3dBxhxpV24khTqG0K5/OLv94d9OqoPFCDNVmw9yKjtZI90T5b3F2SHyPx
 Pm9vGJ4FUsIw81lf6fTjUU/dRiCH5EP1TaYr61x2MUXBjkwR5Gt6QuHzr5AoTh4wgGkl2W
 3Gs4rohc5uCOTuuR50NYNS1LKVHQY7o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-424-OEe_As16PWmbbnUCSUKZ9Q-1; Tue, 19 Sep 2023 15:12:53 -0400
X-MC-Unique: OEe_As16PWmbbnUCSUKZ9Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED2A3801779
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 19:12:52 +0000 (UTC)
Received: from localhost (unknown [10.39.192.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8389E40C6EBF;
 Tue, 19 Sep 2023 19:12:52 +0000 (UTC)
Date: Tue, 19 Sep 2023 15:12:51 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL V2 00/17] Net patches
Message-ID: <20230919191251.GA1843253@fedora>
References: <20230918083132.55423-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Rt2t9pauRfrvgB2C"
Content-Disposition: inline
In-Reply-To: <20230918083132.55423-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--Rt2t9pauRfrvgB2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--Rt2t9pauRfrvgB2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUJ8rMACgkQnKSrs4Gr
c8hV5Qf/Zha//92Lzi30yvS/TZ8maDbPhlavX8x0QND7DDRjN19dwHRW9BghBki1
ycbo6Ns362Gs16FDhZ74aFRWqsOh0U9haQyEpjGp6K0Byji6jomO/0PoTeufQnXM
C1q/moVeHE4th7Ma8AolK7jNP2E3Pyp8YZ3TmjoWxhia0NmQvhdN8rbxFLG7D7V4
sC3RJED95LUEHgtTESWdXBGvZbw2kfa+rRESa0dLmZLfTJSWEQNlHqmeruFZ9qkk
E7qBXvgwAoB4EiDX/dnI5SC/aLWjiLD8EdAuA7NyRbIxSxyafHMqodoMSYUlleC9
5OUxgd/btg8sWCgbyjBifg0HZrNx2A==
=8X0O
-----END PGP SIGNATURE-----

--Rt2t9pauRfrvgB2C--


