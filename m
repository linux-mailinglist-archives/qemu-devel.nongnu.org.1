Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 241A97EA3BF
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 20:29:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2cbw-0006Wy-Rn; Mon, 13 Nov 2023 14:28:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r2cbt-0006WU-5O
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 14:28:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r2cbq-0004GE-N4
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 14:28:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699903713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7sHPzteZO5yJtfx+Mjb/sWjLe2A2POXmru5FVHQrXv0=;
 b=QBK9hsEC+8er0AqL/M1XFQTagTOg0JiiqyxrDP4kpEDZjQHs2etVTUf6j3M3mvrGCV4jQ5
 yP2eLNIPNnsNnYRahKL45w41HMrLr8QxnZnkK8IQBfAFDpk5NkMv03K84ZZcBWpX7pbmZY
 HwiWwwcw7jvAw2Tv4ISQUlbctO1pWJg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-wXQGVcowOYSFzhJx1avu1Q-1; Mon, 13 Nov 2023 14:28:29 -0500
X-MC-Unique: wXQGVcowOYSFzhJx1avu1Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B05D0185A781
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 19:28:29 +0000 (UTC)
Received: from localhost (unknown [10.39.192.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AF43C1C060B9;
 Mon, 13 Nov 2023 19:28:28 +0000 (UTC)
Date: Mon, 13 Nov 2023 14:26:58 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>
Subject: Re: [GIT PULL 0/1] Host Memory Backends and Memory devices queue
 2023-11-13
Message-ID: <20231113192658.GA241522@fedora>
References: <20231113084642.150354-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="n+CI2h3hI6TI9FqT"
Content-Disposition: inline
In-Reply-To: <20231113084642.150354-1-david@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
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


--n+CI2h3hI6TI9FqT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--n+CI2h3hI6TI9FqT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVSeIIACgkQnKSrs4Gr
c8icvQf/SPE4UChGQ8/kVX4uP7ZI8zQwXwouiA9hR15jTX93B+qRoHiYo3deowAQ
9eK2/7dGB9IRRQ9ovWrG0UWCmfA8MAb9beRmYaiNreQnfbB6w5jI/q2lXWnvsLp1
1kh0MrOrOLTt5M9jd7shCaDQSx8NwR3vugDZ5oERWNR5VKenTizUWMHzt1ogRKYv
IWZsFxnT4/Xn772z3TGiIzsVNLOx7PYiKs2kg49unt2RkoXnVqbGDwNiHRmniXRR
zrkB6rEFw0KEGVuGeE34I3dNPcQCkXOQxve6AVMJU07ruC87SjT/FbZjet8eUxF9
/6GAslHn9Om4tkMGAwBWIWYxGRiPQg==
=LgrW
-----END PGP SIGNATURE-----

--n+CI2h3hI6TI9FqT--


