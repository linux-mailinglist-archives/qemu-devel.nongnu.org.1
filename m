Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B44BA7E34C2
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 06:01:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0ECM-00029E-9H; Tue, 07 Nov 2023 00:00:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r0ECA-000283-R2
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 00:00:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r0EC8-0004Ur-4y
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 00:00:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699333206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GoUF/aILeEE/M3x35iD56X0pkbPAVbh4+8ePsIl2rvw=;
 b=R/EZHi27ZcUz8qV9Jn/0lNmTpAUnmBpF5dEcqXhU49VTC7k74j/7/GygGwBDAwxC8QsZWA
 dDHKM8Tz/LzV+eMF1uTGaJclAIGIVs6eZ54IlMup6ksYX9tNTG09tiectQVpMeG0giIshx
 Rq9ufCTp5ACGncCFbF6LVho93XujRm8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-437-IRuZKiSmOxC-9FdICatXMg-1; Mon,
 06 Nov 2023 23:59:52 -0500
X-MC-Unique: IRuZKiSmOxC-9FdICatXMg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8FE813C108C6;
 Tue,  7 Nov 2023 04:59:52 +0000 (UTC)
Received: from localhost (unknown [10.39.192.48])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CC983492BE0;
 Tue,  7 Nov 2023 04:59:51 +0000 (UTC)
Date: Tue, 7 Nov 2023 12:59:49 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 00/35] tcg patch queue
Message-ID: <20231107045949.GA963945@fedora>
References: <20231107024842.7650-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2YjyetgWQSCAPBrh"
Content-Disposition: inline
In-Reply-To: <20231107024842.7650-1-richard.henderson@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
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


--2YjyetgWQSCAPBrh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--2YjyetgWQSCAPBrh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVJxEUACgkQnKSrs4Gr
c8iuwgf/Z2QTvyGorPAKp5FFeswLcLBEHskCdCyh/t1OE7iNfktzNCk62dv6lRpb
XqUxKiG3f5W6+B9CndQrRJcGl9zDbg9e0QEp07IYJIIR1AGYYQ0mgGhkaIpkxQGX
Rq8jjJlhJmM0N9TAUQnGljH9l85vyGQWJB3YDD5pzbRpXFS/v2Gjl9vWaC3i1MfH
QxksuUxZ2ht2Nze8mf9QOWsRaCIOWNQ8TLqKxvbe5hnVxOqfBTD7Yd5FaVfD9AU3
t2BBJxPWcMS1UoqbCLbX8AwbvxEW7E11HnNpV22rHC5Q0l+0YYV8yAyrpLo0l9eR
NVF0UliLY1Ni6Z4Jg3VUqrmri5cu0w==
=N1fe
-----END PGP SIGNATURE-----

--2YjyetgWQSCAPBrh--


