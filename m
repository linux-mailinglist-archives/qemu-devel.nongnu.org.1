Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6526757FDB
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 16:42:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLltp-0007UZ-Lg; Tue, 18 Jul 2023 10:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qLltn-0007UB-2u
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 10:41:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qLltl-0000YA-Qu
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 10:41:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689691251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=igRjlgY6m3/4xtBH+ZYfHvg5VKVeA75YlZJY2FH/HNE=;
 b=VNrDMINSPxUIQRVp+v9rdgFTYXAujdr3Ov2wBCv48eSYhiGEIyit4Akt3sqZPqnAoZVA64
 wpcjtPbnB/79MG+NM5QmIZZbpqrXNVov9p171fHOdQKqHEe0mVngp854EJt8MzL00qs+CA
 kX5J+58bBEXySc7JOLv+s2g+xnJ16LI=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-496-h7Pk7YI_N9-_nYAXlFJH9g-1; Tue, 18 Jul 2023 10:40:46 -0400
X-MC-Unique: h7Pk7YI_N9-_nYAXlFJH9g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EF61D38188D8
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 14:33:46 +0000 (UTC)
Received: from localhost (unknown [10.39.193.253])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6C30E492B02;
 Tue, 18 Jul 2023 14:33:46 +0000 (UTC)
Date: Tue, 18 Jul 2023 10:33:44 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>
Subject: Re: [PATCH 3/6] vhost: Do not reset suspended devices on stop
Message-ID: <20230718143344.GD44841@fedora>
References: <20230711155230.64277-1-hreitz@redhat.com>
 <20230711155230.64277-4-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="XmqA7wPY2O8rEMaj"
Content-Disposition: inline
In-Reply-To: <20230711155230.64277-4-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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


--XmqA7wPY2O8rEMaj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 11, 2023 at 05:52:25PM +0200, Hanna Czenczek wrote:
> Move the `suspended` field from vhost_vdpa into the global vhost_dev
> struct, so vhost_dev_stop() can check whether the back-end has been
> suspended by `vhost_ops->vhost_dev_start(hdev, false)`.  If it has,
> there is no need to reset it; the reset is just a fall-back to stop
> device operations for back-ends that do not support suspend.
>=20
> Unfortunately, for vDPA specifically, RESUME is not yet implemented, so
> when the device is re-started, we still have to do the reset to have it
> un-suspend.
>=20
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  include/hw/virtio/vhost-vdpa.h |  2 --
>  include/hw/virtio/vhost.h      |  8 ++++++++
>  hw/virtio/vhost-vdpa.c         | 11 +++++++----
>  hw/virtio/vhost.c              |  8 +++++++-
>  4 files changed, 22 insertions(+), 7 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--XmqA7wPY2O8rEMaj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmS2osgACgkQnKSrs4Gr
c8jY+gf/Rlkp1MN/woL36Z6C85sLYfJUgmlxMuU9zWPxMZnGD27n/hrubwnY7xnp
jm7Is/Y8kJ/qpvGkMe9t8iaF/ZAlcXtdbceWIqaZ+16b+AKj7xPvxeaxiOMP2oBR
p9ky1/bGmfHD2HbuihoS3e3wBoWoiybZY83i83Ys8xBI6MFskKxOcPH6oZ9RknY5
JRfP/tsl/zuQKNnOzXiW1RsJoI8pUFypkAxte8T4yIl5HW0XfEbbPJbUkukVjpMU
OeIgzlj+2tCdWgvZatygLa66pyhfjArogD+VpTT+D7lN/HclA8YH1fMlU4Zr7LVM
iGzsG2H9zfii89GIHjtaLLNacYEc1g==
=LUbD
-----END PGP SIGNATURE-----

--XmqA7wPY2O8rEMaj--


