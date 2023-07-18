Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4187584DD
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 20:33:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLpUd-0004Hi-IK; Tue, 18 Jul 2023 14:32:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qLpUb-0004HA-DZ
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 14:32:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qLpUa-0007eY-0W
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 14:32:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689705131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T6PNuht4ykXdUB7aW0agTTP0mv0XCA5wCYAnyLNMsXs=;
 b=DnGxPDzpS04n0o/qwHyTs2/5LZAdJC/snUn/f1MPEVjGRFWGOIE2NzI2cAGhrkQLevJ/Uz
 TJ+0JsWQaB90vx3Kw41DL/e4JCBvfni92uczSECPE2EW8dJc+402LNevocmqnvRYX0dRpQ
 ZJFYkPohYprysolgp94bptgGR2LMXN0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-670-YZNspfXlMEOifg67UyzACA-1; Tue, 18 Jul 2023 14:32:05 -0400
X-MC-Unique: YZNspfXlMEOifg67UyzACA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 26C02936D3C
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 18:32:04 +0000 (UTC)
Received: from localhost (unknown [10.39.192.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9FED94087C62;
 Tue, 18 Jul 2023 18:32:03 +0000 (UTC)
Date: Tue, 18 Jul 2023 14:32:02 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-fs@redhat.com,
 "Michael S . Tsirkin" <mst@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH v2 2/4] vhost-user: Interface for migration state transfer
Message-ID: <20230718183202.GL44841@fedora>
References: <20230712111703.28031-1-hreitz@redhat.com>
 <20230712111703.28031-3-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OFXlAdfcAqaoeCSw"
Content-Disposition: inline
In-Reply-To: <20230712111703.28031-3-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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


--OFXlAdfcAqaoeCSw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 12, 2023 at 01:17:00PM +0200, Hanna Czenczek wrote:
> Add the interface for transferring the back-end's state during migration
> as defined previously in vhost-user.rst.
>=20
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  include/hw/virtio/vhost-backend.h |  24 +++++
>  include/hw/virtio/vhost.h         |  79 ++++++++++++++++
>  hw/virtio/vhost-user.c            | 147 ++++++++++++++++++++++++++++++
>  hw/virtio/vhost.c                 |  37 ++++++++
>  4 files changed, 287 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--OFXlAdfcAqaoeCSw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmS22qEACgkQnKSrs4Gr
c8hGpgf8CyYr73yfcwyeNjwvgo7NRU8Cjbdh3JG93gfcdq+YlTKoWb1H40sgSDOm
gQzamo9tsxmVqzLEZi5OTtyXFykgqMUSA3hJS52RbgyjCVG5iqP431aM0zvMrQAC
ZIUQVSNtE0ssZEm1PZB65Q+41/uiHBe1447Qsk3hcCxOi8r5XItv2B5iey54owNf
Mcg4VuDSpRxhHSJlUXS4xyuR5wdS5KQqdnv3qhewqme0HK8Kuc8f6ZAcHnrDFL9c
cEwGWUGB64JlrJsu5RqorOoxTRE7n1lwAu8bq1CcmMYEGQALVgY4NIHtT0716bSG
/xShMZH4PlAxpB4j4nbx5HBw4yu4fA==
=bf6d
-----END PGP SIGNATURE-----

--OFXlAdfcAqaoeCSw--


