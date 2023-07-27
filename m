Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F40B76556C
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 15:57:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP1K9-0007bV-St; Thu, 27 Jul 2023 09:46:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qP1K2-0007Zq-0m
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 09:46:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qP1Jz-0002ZK-Hx
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 09:46:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690465583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OtyG4xHHVnLid0FX7E0W0qJZkcLnLtsDa5kTrc0KIuI=;
 b=APS4oesgGfPOfN6oK9inThFh0ahEwQgI1BSpk4maIDnbr2uBjEJowY4m61wEcSKBX8xW2S
 ppD3sLCnkBJ0nMFEdIBDiyXg3zCURFX2uytnuvS8ZzZOWr1ci18rYmqU3Gmgif9fR1t/+4
 RSB+RY0Fnyt9rnRT+bD0dUVU4XtaY30=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-114-YFc2QStwMwCpUvISq4ORmw-1; Thu, 27 Jul 2023 09:46:19 -0400
X-MC-Unique: YFc2QStwMwCpUvISq4ORmw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2052D924908;
 Thu, 27 Jul 2023 13:46:19 +0000 (UTC)
Received: from localhost (unknown [10.39.193.84])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 913E91454150;
 Thu, 27 Jul 2023 13:46:18 +0000 (UTC)
Date: Thu, 27 Jul 2023 09:46:16 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org, hare@suse.de, mjrosato@linux.ibm.com,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 dmitry.fomichev@wdc.com, Kevin Wolf <kwolf@redhat.com>, dlemoal@kernel.org
Subject: Re: [PATCH v2] block/file-posix: fix g_file_get_contents return path
Message-ID: <20230727134616.GA868174@fedora>
References: <20230727115844.8480-1-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TZ7UV44oKKVKxaV+"
Content-Disposition: inline
In-Reply-To: <20230727115844.8480-1-faithilikerun@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


--TZ7UV44oKKVKxaV+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 27, 2023 at 07:58:44PM +0800, Sam Li wrote:
> The g_file_get_contents() function returns a g_boolean. If it fails, the
> returned value will be 0 instead of -1. Solve the issue by skipping
> assigning ret value.
>=20
> This issue was found by Matthew Rosato using virtio-blk-{pci,ccw} backed
> by an NVMe partition e.g. /dev/nvme0n1p1 on s390x.
>=20
> Signed-off-by: Sam Li <faithilikerun@gmail.com>
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/file-posix.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Thanks, applied to my block tree:
https://gitlab.com/stefanha/qemu/commits/block

Stefan

--TZ7UV44oKKVKxaV+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTCdSgACgkQnKSrs4Gr
c8iA+AgAoOZqXIxICnlBrOscJu+yOPlm3CtKPzrQ6a3o2KN6d4L9WJA93B3Lsthx
IGj5eHJSNqz8smmk3msuoiZDGAHbJXeFNIccBqKCdJ+uqnNI/KyCKWmitD/2YsVm
61kh/gTxt8jHsMX/ykK5PYLkgvGVTVxsGwQVenFM1ifBp38cZDZz91J2GNrEAbxf
IdvmZrEGih/bh48vhxLKSrhUvC7k+TTYaBOgSluw8gz4H/Mc8fA9neGQPprzqDFX
3RmgbHtzeAcBIjPiEK0+6dd2DGOvdr1CJZqLwh5KQTwReXFM9m/MLERfGt/6WBzs
9qTCFg3djRM48uZ4KuPthB0Jo/XTxg==
=7q7X
-----END PGP SIGNATURE-----

--TZ7UV44oKKVKxaV+--


