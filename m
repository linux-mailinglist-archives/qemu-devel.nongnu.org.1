Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FAE7F15E2
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 15:40:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r55Rq-0003lj-EK; Mon, 20 Nov 2023 09:40:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r55Rj-0003O9-SC
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 09:40:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r55Ri-0004kB-8P
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 09:40:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700491217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ki6tsznw8WKdd8e/rLtn+oDdOzt1kWjtQsb8gOhZ+0I=;
 b=LfMjkpZ7mbJbN234aJtZtkOiEWYzAaYD1ZLVGEspUWHA5/9DmZJlNa4jPlh0otHMy72qcl
 IFLPGZWE4EGc/VD+AWHRsKKryGnfhQMgWwuW5bSej5VeUCUFFBHB48OeQafD8LNDXd+veL
 R8izpUBFZKVKk9qcGu2t+S/H6AdU8Fw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-BoPVTFdWOmKr-GqqZb9HsQ-1; Mon, 20 Nov 2023 09:40:13 -0500
X-MC-Unique: BoPVTFdWOmKr-GqqZb9HsQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 826BC185A787;
 Mon, 20 Nov 2023 14:40:12 +0000 (UTC)
Received: from localhost (unknown [10.39.195.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EA63810F45;
 Mon, 20 Nov 2023 14:40:10 +0000 (UTC)
Date: Mon, 20 Nov 2023 09:40:09 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PULL 0/1] target/xtensa fixes for v8.2
Message-ID: <20231120144009.GA568920@fedora>
References: <20231119191152.848781-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="f/Ymy9RqfaO4JIDF"
Content-Disposition: inline
In-Reply-To: <20231119191152.848781-1-jcmvbkbc@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
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


--f/Ymy9RqfaO4JIDF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--f/Ymy9RqfaO4JIDF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVbb8kACgkQnKSrs4Gr
c8jCXAgAgRyVMNLI3K9hEdTNcwNQqlVjgYhI1P2aBk8F/4ggLLUCGaRiyYg5+r1K
5Xclfc7apA52JXe0JM8v87Gyhbdxz2lxvTRjSRPILpwng/L2DjKu+qDj2WWhueJK
287s9UsdAU7YQZjoBwNlzL/4RY5yfKaTKiXKoXX8YqWQnVkCkkX3MqVl0bOSMI3k
VXNIxXMZC8NElzlv0OwdqQGiKIeaxAVAJREjv8vxUquIH07xLGBhsGvZ3usAv76h
Mn4ZibdTlcbGcDE6H6fhfuyTHaYJlaFkH8xqAisHDOJYR8HbmUV10OxR5dAXRSZH
pAJRfOPpIniNCvU42QDW9+gegKOrPg==
=Xq2e
-----END PGP SIGNATURE-----

--f/Ymy9RqfaO4JIDF--


