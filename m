Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBE0794302
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 20:25:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdxCd-0001BA-3v; Wed, 06 Sep 2023 14:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qdxCV-0001AM-2F
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 14:24:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qdxCS-0008Rz-LM
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 14:24:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694024663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bj93e5B3PO2GJeoYti57Nzfj9e9kkRyLjMDmGPF90AA=;
 b=bfKTKMtKuBHEU4P4XGY1b7SMqhgRfcVIFZIqxSwDKnYzKBEU1NNsTozvpqSSapjURFDb9G
 mbc/Dcktuxh5uY1ySZtE05upw5zI0cvNTlDra2rjpDLr4rTUkhAoHb7CO3lJggMzCQPPdi
 q7swImgI9JTiqN41n/UVwdG9qr6UYkg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-227-6CoPXzhoMTKkJXRUP7sh-A-1; Wed, 06 Sep 2023 14:24:19 -0400
X-MC-Unique: 6CoPXzhoMTKkJXRUP7sh-A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 048D39472E1;
 Wed,  6 Sep 2023 18:24:19 +0000 (UTC)
Received: from localhost (unknown [10.39.193.221])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 712AE2026D4B;
 Wed,  6 Sep 2023 18:24:18 +0000 (UTC)
Date: Wed, 6 Sep 2023 14:24:17 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/13] linux-user patch queue
Message-ID: <20230906182417.GA1282636@fedora>
References: <20230901204251.137307-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="fg/H0IasfMW7wWjp"
Content-Disposition: inline
In-Reply-To: <20230901204251.137307-1-richard.henderson@linaro.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--fg/H0IasfMW7wWjp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--fg/H0IasfMW7wWjp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmT4w9EACgkQnKSrs4Gr
c8h2rggAwBVHPvYVGkbysGTp6k3TGAPac4VPg8q+PStJhM2HTJEMdYZAoPUNKU0e
i3QhyOqSW97ia8JgSR8XJMC/2XEzHbHf0+1F/L8mvaHrSqFb2aVWbuDgE6rfXPEH
Esb1c6O0+kiOaY4kxtr4GZrNNQnYmTP5hOWPHuBbUeeu1x2ewnBqiPNFjtX4wncf
6af8LI/pgC472KPgUdt7XOM0c3DhLAKGWlVLVQTKHp2mzaGuVmolT2W3U/n1/dwx
Ob9O9hN2uH9sBuIjJ0kc0zPeLgdVrVu4tWENhdrMpjmujdc1Ii6zm13K7HHX2qa6
cWY5UYVfkp7jPf7Zy4BDtt0nuRh1gQ==
=QVt5
-----END PGP SIGNATURE-----

--fg/H0IasfMW7wWjp--


