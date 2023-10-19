Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 930797D13B2
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 18:08:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qts1E-0005gX-Gb; Fri, 20 Oct 2023 12:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qts1B-0005VK-OM
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 12:06:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qts19-0001Rs-0B
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 12:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697817989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hGwIT2lbkJ5oPv6fPV85IDXbDyB1Lzrn9VWi2lna0eo=;
 b=iBiYFn3Pinh4uigSvessb2cqMV6jzfY4ugwrNyPititAjhyVxTquRSsHBuaYp9JBK1fmhW
 ccuYxKAFLFSrm6yTA0xcbp4o1tJGkXpmCofWGn+0zhTGo/6jQc9U47CiPgVLcEX2yLdFQ0
 4QwYTybRAdpQGdv13h/Y+u/mBwmmC64=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-DHe7j1fVM7KupAFuisacLQ-1; Fri, 20 Oct 2023 12:06:27 -0400
X-MC-Unique: DHe7j1fVM7KupAFuisacLQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 615AD857D0A;
 Fri, 20 Oct 2023 16:06:27 +0000 (UTC)
Received: from localhost (unknown [10.39.192.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ABE1B1121320;
 Fri, 20 Oct 2023 16:06:26 +0000 (UTC)
Date: Thu, 19 Oct 2023 11:51:01 -0700
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PULL 00/11] Migration 20231018 patches
Message-ID: <20231019185101.GA414230@fedora>
References: <20231018100651.32674-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="53u9y4h4sKU3nY9N"
Content-Disposition: inline
In-Reply-To: <20231018100651.32674-1-quintela@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--53u9y4h4sKU3nY9N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--53u9y4h4sKU3nY9N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUxepUACgkQnKSrs4Gr
c8gzhAf+PuKLBkuewsbWPUq2G//4bLqGuNYPXGCmi856zCFS/neCTMoex6afycU6
ps1VHsAiRXtmUDzDsI/QolI+LBBRssooXdSgqseoeyYv2kKz+hLKMY6EDFKfr+qQ
utoFtgvSSNRYddFRZysdPQLT5oCNyTiYWLNrg1XkXLJtqNgj6iQZpI2Tfjmb381q
F2EMlS3d0XBDIDUOk2Z4LBSk9j6daGLm8bKO/Mj2eQPgcmhPxhWQhP7qdL95u+Up
OYMdL5gPVfEWW9ZsqPysLg0x0OgGTwtv299/MrZCbsvd7KTHxLyZOGA+Y9rY876i
c2qvCnhB/3CBJcw6WW/V6oFczc55MA==
=tArV
-----END PGP SIGNATURE-----

--53u9y4h4sKU3nY9N--


