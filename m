Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C5270E690
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 22:35:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Yj2-0007VW-Vg; Tue, 23 May 2023 16:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q1Yis-0007SG-O2
 for qemu-devel@nongnu.org; Tue, 23 May 2023 16:35:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q1Yio-0005Ba-Sm
 for qemu-devel@nongnu.org; Tue, 23 May 2023 16:35:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684874106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g3E/x39V8NlhTpTKVQj0IYsVLqooqk3IsgzG9qM1ukE=;
 b=akgLGde0279vRgcoufVR9zdJxLF6hJi1j5oPwnh659qG6U2lOmkx+9uiNL1j5fVPnNE36L
 es/oP3CJ/eVQukXuP+tDwanAGxaaTt7JzB0u1F4l2MpPKOi+VjgAKZ+usYFPwinqVmVell
 +BEY+hljHQi5Kk87X18OgQawmzCPvLo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-489-gHFiiG2MNACUBQbMODaYnA-1; Tue, 23 May 2023 16:35:04 -0400
X-MC-Unique: gHFiiG2MNACUBQbMODaYnA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 410DA8002BF;
 Tue, 23 May 2023 20:35:03 +0000 (UTC)
Received: from localhost (unknown [10.39.192.61])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AC762200AD47;
 Tue, 23 May 2023 20:35:02 +0000 (UTC)
Date: Tue, 23 May 2023 16:35:01 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Markus Armbruster <armbru@redhat.com>,
 Erik Schilling <erik.schilling@linaro.org>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>, virtio-fs@redhat.com,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 03/13] hw/virtio: fix typo in VIRTIO_CONFIG_IRQ_IDX
 comments
Message-ID: <20230523203501.GB140337@fedora>
References: <20230418162140.373219-1-alex.bennee@linaro.org>
 <20230418162140.373219-4-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="JA4+quDfuMdiE1Nu"
Content-Disposition: inline
In-Reply-To: <20230418162140.373219-4-alex.bennee@linaro.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--JA4+quDfuMdiE1Nu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 18, 2023 at 05:21:30PM +0100, Alex Benn=E9e wrote:
> Fixes: 544f0278af (virtio: introduce macro VIRTIO_CONFIG_IRQ_IDX)
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> ---
>  hw/display/vhost-user-gpu.c    | 4 ++--
>  hw/net/virtio-net.c            | 4 ++--
>  hw/virtio/vhost-user-fs.c      | 4 ++--
>  hw/virtio/vhost-user-gpio.c    | 2 +-
>  hw/virtio/vhost-vsock-common.c | 4 ++--
>  hw/virtio/virtio-crypto.c      | 4 ++--
>  6 files changed, 11 insertions(+), 11 deletions(-)
>=20
> diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
> index 71dfd956b8..7c61a7c3ac 100644
> --- a/hw/display/vhost-user-gpu.c
> +++ b/hw/display/vhost-user-gpu.c
> @@ -489,7 +489,7 @@ vhost_user_gpu_guest_notifier_pending(VirtIODevice *v=
dev, int idx)
> =20
>      /*
>       * Add the check for configure interrupt, Use VIRTIO_CONFIG_IRQ_IDX =
-1
> -     * as the Marco of configure interrupt's IDX, If this driver does not
> +     * as the macro of configure interrupt's IDX, If this driver does not
>       * support, the function will return
>       */

The entire comment could be rewritten to make the punctuation and
grammar correct, if you want.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--JA4+quDfuMdiE1Nu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmRtI3UACgkQnKSrs4Gr
c8jahAgAjNJL7hdL0me7Krt5f48JEWKVlbfdPmI5YsuNOD2rK9wUPekqO14fMTGG
SweDE5VEvQfMEHxfB1Blk20yRbk5sb09K2bO0FOnvvgzNdqGXxpQqQs/qv3Py+WB
MzAvyNWG8oTGRS/9n8iOosrueQTeXJ7hwstKGA9TVW9nbX2za5+TIPi1MDNxL8nO
ax/dzHey5HXCJCVamyP0lQDlYq/8EWfsoY4rwXQkgvr/bExzQV/HCuIIjzpQSfXl
4HOE9ps/HaOghhB26uiOjO8pCGgBaMBfVR3oHOqJNtBrOJPRSaU6ChjTPRjTH3Ab
hRwIHK2d8V1TnX4LimyqVUy9hBzmeQ==
=ZMIo
-----END PGP SIGNATURE-----

--JA4+quDfuMdiE1Nu--


