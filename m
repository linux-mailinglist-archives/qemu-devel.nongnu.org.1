Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C247079D6C1
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 18:50:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg6aB-0001bw-Tu; Tue, 12 Sep 2023 12:49:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qg6a9-0001bA-6w
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 12:49:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qg6a6-0008Ia-AI
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 12:49:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694537381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DmLAODhxoAPFqa8eqoyQxQq1QSc/kZRZ096IU51ZvL8=;
 b=Pozt3m4N2KYRiY/B5M+jxl/9nKfxNXA0h+qjcswOwlFlHwb2Ka0qZ9UqMFXHy2KD84YFJK
 N6Htm8T5Md5aSfVxybe7uP6bixanuQffBBaOCuEEcknJYcNroKW/YR6qWn/sKDgmiPplU6
 9KnU1ATEh1rGhjeBVxQqk2KTtOfsxpg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-93-9yrEk442M0C3spX_HysQXg-1; Tue, 12 Sep 2023 12:49:39 -0400
X-MC-Unique: 9yrEk442M0C3spX_HysQXg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 697FC8BF4A6;
 Tue, 12 Sep 2023 16:49:39 +0000 (UTC)
Received: from localhost (unknown [10.39.193.246])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F3F8F40C6EA8;
 Tue, 12 Sep 2023 16:49:38 +0000 (UTC)
Date: Tue, 12 Sep 2023 12:49:27 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, eesposit@redhat.com,
 pbonzini@redhat.com, vsementsov@yandex-team.ru, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 17/21] block: Take graph rdlock in
 bdrv_drop_intermediate()
Message-ID: <20230912164927.GD72318@fedora>
References: <20230911094620.45040-1-kwolf@redhat.com>
 <20230911094620.45040-18-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="loeMYsOB+XEjcpbl"
Content-Disposition: inline
In-Reply-To: <20230911094620.45040-18-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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


--loeMYsOB+XEjcpbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2023 at 11:46:16AM +0200, Kevin Wolf wrote:
> The function reads the parents list, so it needs to hold the graph lock.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
> ---
>  block.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--loeMYsOB+XEjcpbl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUAlpcACgkQnKSrs4Gr
c8gWzQgAosTlXudU2aOO46DvQLqFHLqAOaXmQXV5sQia00cU/svzj1m7W8tEX8Tp
4WIDCC039+AS6b545jaf2t8ft+qm7Cq8l1sDgtVj91Cktacw3i6CPG4v9S/0st4b
KxdqV0ry6s8SMjHpGwmYf+wEwpdlfyFOiAazKS754tGJviBb+EA0VH6/OmZTkVt0
yUnWh2I/eLDdbBL5ZjaALO8Z0MOYMYyYkcJOME6E2W0qKAmoXqd5cqGkJvxITe2W
xmftqMgaiRzA2cd7RHRGir0Hb6mKgsMtncnuB659Sa7xXQMQWj1Ng6QkLm8q/34d
pSGE5rapF3if/IpVo5kuyGEguHLXJg==
=qvH8
-----END PGP SIGNATURE-----

--loeMYsOB+XEjcpbl--


