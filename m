Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF97AAC726
	for <lists+qemu-devel@lfdr.de>; Tue,  6 May 2025 15:58:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCIoF-0007D4-Cv; Tue, 06 May 2025 09:58:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uCIoC-0007CI-Tf
 for qemu-devel@nongnu.org; Tue, 06 May 2025 09:58:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uCIoB-0003M6-AY
 for qemu-devel@nongnu.org; Tue, 06 May 2025 09:58:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746539885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7tG3ZFPaFt0zB5DHfUPmJ0GV8RtENsogtf1mU52jlBo=;
 b=UZyIwRnW/+2SwXEedi+/GgFZ5toV8NkMqIRudsThkKwa4tVPtADkWhK61hQ1VaQf2XQDFS
 LtdyyxoxJLhFVuQgx09+XiyOI0BdAFavmN/ipU3jOmOwhoeAQlkThLW4StV4Zs1DCXM+5I
 c+Yi0K1g6Q8Q07PNeBLfP6UkSFaJzy0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-op-fC4_xOneyqV5IqVZnog-1; Tue,
 06 May 2025 09:58:03 -0400
X-MC-Unique: op-fC4_xOneyqV5IqVZnog-1
X-Mimecast-MFC-AGG-ID: op-fC4_xOneyqV5IqVZnog_1746539882
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 74D901955D9B
 for <qemu-devel@nongnu.org>; Tue,  6 May 2025 13:58:02 +0000 (UTC)
Received: from localhost (unknown [10.2.16.219])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9DD881800360; Tue,  6 May 2025 13:58:00 +0000 (UTC)
Date: Tue, 6 May 2025 09:57:58 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PULL 0/9] Misc patches (s390x, build env, clean-ups)
Message-ID: <20250506135758.GA302595@fedora>
References: <20250430185035.724919-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9lKgtatNp/CTcufJ"
Content-Disposition: inline
In-Reply-To: <20250430185035.724919-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--9lKgtatNp/CTcufJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--9lKgtatNp/CTcufJ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgaFWYACgkQnKSrs4Gr
c8g7vwgAqUdyRJefPUsyKN3L/FKtzkqljYOyDXAEqso78Kuj7WPwQUCv1f1oNhO1
WwPzs2fXFPlpc3utZpkoD+rRPEUoFTxgBNifF32jjhMX+qFvyW+5fPcd+2IFMEBS
aBHGtl7CWHWQXTopUeft0Dd15jVUOBcEBdY3/kvaX+MeF0ugfxZgElrZ+eqMthYq
kmOseemd2COwMruCeieDPRzp2ex1+VmS8u3Wyg6LPVy5Gcr6KIbCxRcQ8rDqYfZV
AuPPothk7idzoemP0cpWA79gg+5x4UkV1E4q7zrOPj6HrbI0aTYV7b8Yz2MnqkJG
mdf3nQujbhFoLv/22EYyoALV6RumvA==
=l0jE
-----END PGP SIGNATURE-----

--9lKgtatNp/CTcufJ--


