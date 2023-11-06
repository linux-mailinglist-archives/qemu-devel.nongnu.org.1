Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C93257E26B6
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 15:24:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r00Wm-0007zL-6g; Mon, 06 Nov 2023 09:24:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r00Wc-0007tW-4f
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:24:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r00WX-000603-T7
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:24:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699280657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d+FUm+JVhtnFSN678LjcyKX4V84EbcLLTpSEC5Plevw=;
 b=Dorncr1HUy6bJQEFd9zRsyzF2YGpT/5hqQ3Ym9uhtEPFGjbe9VYUgql5OagRNrHp7Kay+Y
 dQ8g+zsnKtmmjwdHt2U3tY0EltdJ/pvN9Xjp5lgML6ukLRfWnuOjCb0hC8XdeiMikDs9OI
 MsW+2cbwPL89BO500Io0Nz5HaE2rcAI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-H5QKhJRtNJKtydmM6eRxMQ-1; Mon,
 06 Nov 2023 09:24:01 -0500
X-MC-Unique: H5QKhJRtNJKtydmM6eRxMQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1D1761C06913;
 Mon,  6 Nov 2023 14:24:01 +0000 (UTC)
Received: from localhost (unknown [10.39.195.175])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 59FA8143;
 Mon,  6 Nov 2023 14:23:59 +0000 (UTC)
Date: Mon, 6 Nov 2023 22:22:40 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, stefanha@gmail.com
Subject: Re: [PULL 00/10] loongarch-to-apply queue
Message-ID: <20231106142240.GA929013@fedora>
References: <20231103062332.2413724-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WvR2tFBUFC1bRZTs"
Content-Disposition: inline
In-Reply-To: <20231103062332.2413724-1-gaosong@loongson.cn>
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


--WvR2tFBUFC1bRZTs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--WvR2tFBUFC1bRZTs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVI9rAACgkQnKSrs4Gr
c8ipYgf9EKpX/JdKTMazebuu8R8p3xvsKrK4Lh3cx86MZEs/5N5BYk5ntPcvg92w
JAwM/S0VsN8NTz4nHit/gX9Oxpgs4+3/SFqNXuVD6qZV5fOOO9ERZayUjKjY5a6s
nJNPv7a6T24tNHSrJKasZ9xDHc31bnP/B73BgvxNBqUdUjxVLITHjVgsJjzhES6y
l+0bi8nzCiXhZfd+/Ng6XyAc+EEKZ+6Rdq9Isgi0iUGn5b7m872ci6VlqcpYaRjx
piwXeBXkxinnmEb4otKqU4vo9xdkiDoihfOjPWZ+Zyq8GIQlFUKIujKc1z3Trzzw
Pme1ITkHTMCR9JgjD/Zw0RTq4c8hZQ==
=2BmT
-----END PGP SIGNATURE-----

--WvR2tFBUFC1bRZTs--


