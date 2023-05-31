Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3D8718A8B
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 21:51:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4RqR-0005z6-9w; Wed, 31 May 2023 15:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q4RqO-0005uu-FE
 for qemu-devel@nongnu.org; Wed, 31 May 2023 15:50:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q4RqL-0003RQ-KL
 for qemu-devel@nongnu.org; Wed, 31 May 2023 15:50:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685562649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yidvGRAT/OnP5PqG+xEcTx82SlvRwvyy1Kdgkf5/4pY=;
 b=Q7PZT/zcH91sp9tX066gyFRABstWY8y3ff0JiXFKnbJEO2pO9MJZqVVeQ864we0YD3L2B7
 sk0HnaZcNZ964WiASrU6OqAJvMSWZNOoyaDj1PEk8FOXeg1jI0QNiBGtN7YyKUmuuOKdVH
 gIieZXyJ7XUdMrlmtltQ8RquGOiPvUE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-5fq1aeImPn-bTRYXg3IKzw-1; Wed, 31 May 2023 15:50:45 -0400
X-MC-Unique: 5fq1aeImPn-bTRYXg3IKzw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CA493800888;
 Wed, 31 May 2023 19:50:44 +0000 (UTC)
Received: from localhost (unknown [10.39.192.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 14743C154D7;
 Wed, 31 May 2023 19:50:43 +0000 (UTC)
Date: Wed, 31 May 2023 15:50:42 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: kwolf@redhat.com
Cc: Paolo Bonzini <pbonzini@redhat.com>, eblake@redhat.com,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 sgarzare@redhat.com, qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org, Julia Suvorova <jusual@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paul Durrant <paul@xen.org>, Anthony Perard <anthony.perard@citrix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 0/6] block: add blk_io_plug_call() API
Message-ID: <20230531195042.GA1509371@fedora>
References: <20230530180959.1108766-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="RoKjmCOI6qwAyphs"
Content-Disposition: inline
In-Reply-To: <20230530180959.1108766-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


--RoKjmCOI6qwAyphs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Kevin,
Do you want to review the thread-local blk_io_plug() patch series or
should I merge it?

Thanks,
Stefan

--RoKjmCOI6qwAyphs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmR3pRIACgkQnKSrs4Gr
c8h2Xgf/fXnY9mbKX8MwRoUNXIaProbM9HoJz8wrU/R4i3OpVIfIGHwbXa/Xpt7G
/Oyn/gXv+daEcC7yfOf8B+PzcCucvadYTcN/DvioPKz0ve4czwEjxsJnQznutoUx
kfTVC1OTkgkijEi4GpUNt83ghjVEmp6oos0ggfWSCyQZYWR6MK1/Lh5svV8viiR1
GJq+d2LBDnbC5eCk0dCqdZemAh0tuPr5nSR8edI5WUG830VgsaQnE0gzvF5IsfN5
9VxD3iP6bQHS59zn/hoOV91tqA+ohhwP/qHsUAQQLpQLo5dfH6d6fZ9Y3Y3n53HG
sLBl2KWOYj4e5Q4tSgmBoUplfPCdvQ==
=ndb5
-----END PGP SIGNATURE-----

--RoKjmCOI6qwAyphs--


