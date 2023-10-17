Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9107CC588
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 16:05:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qskgS-0008TB-Do; Tue, 17 Oct 2023 10:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qskg9-0008F1-7H
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 10:04:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qskg2-0000Pg-Im
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 10:04:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697551443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G2NMs/c//SR6fisMiteewS/OFZJTWXMg+5i8/TzaPsQ=;
 b=gDGWZYw7W9L+9L1RlBp0g/UqkKAUmTWuyFdIDwFWS01jx11h8eMT3mjv5UgfgPI0TuaCGL
 EYi1wVQ51qO3oFJascEANB6T+x9McJXV2jCfCOR4GnKB9Zx1Lgpk7z20iYD1v14g56b2zS
 tyFjmK7rn4yJeU+HRhH5seB0OylGetM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-og3wFbJDNUK0BWFgESNIqQ-1; Tue, 17 Oct 2023 10:03:51 -0400
X-MC-Unique: og3wFbJDNUK0BWFgESNIqQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C1392825EB9;
 Tue, 17 Oct 2023 14:03:48 +0000 (UTC)
Received: from localhost (unknown [10.39.192.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CF011C15BBC;
 Tue, 17 Oct 2023 14:03:47 +0000 (UTC)
Date: Tue, 17 Oct 2023 10:03:46 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: lv.mengzhao@zte.com.cn
Cc: mst@redhat.com, kwolf@redhat.com, hreitz@redhat.com,
 qemu-devel@nongnu.org, hu.jian@zte.com.cn
Subject: Re: [PATCH] virtio-blk: don't start dataplane during the stop of
 dataplane
Message-ID: <20231017140346.GA216511@fedora>
References: <202310111414266586398@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="EZKvwwGNz6ys+oC2"
Content-Disposition: inline
In-Reply-To: <202310111414266586398@zte.com.cn>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--EZKvwwGNz6ys+oC2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 11, 2023 at 02:14:26PM +0800, lv.mengzhao@zte.com.cn wrote:
> From: hujian <hu.jian@zte.com.cn>
>=20
> During the stop of dataplane for virtio-blk, virtio_bus_cleanup_host_noti=
fier() is be
> called to clean up notifier at the end, if polled ioeventfd, virtio_blk_h=
andle_output()
> is used to handle io request. But due to s->dataplane_disabled is false, =
it will be
> returned directly, which drops io request.
> Backtrace:
> ->virtio_blk_data_plane_stop
>   ->virtio_bus_cleanup_host_notifier
>     ->virtio_queue_host_notifier_read
>       ->virtio_queue_notify_vq
>         ->vq->handle_output
>           ->virtio_blk_handle_output
>             ->if (s->dataplane  && !s->dataplane_stoped)
>               ->if (!s->dataplane_disabled)
>                 ->return *
>             ->virtio_blk_handle_output_do
> The above problem can occur when using "virsh reset" cmdline to reset gue=
st, while
> guest does io.
> To fix this problem, don't try to start dataplane if s->stopping is true,=
 and io would
> be handled by virtio_blk_handle_vq().
>=20
> Signed-off-by: hujian <hu.jian@zte.com.cn>
> ---
>  hw/block/virtio-blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I have dropped this patch again after Fiona pointed out it does not
compile and Kevin noticed that handling requests from the main loop
thread while the I/O is still being processed in the IOThread is going
to cause thread-safety issues.

Can you explain the problem you are seeing in more detail? You run
"virsh reset" while the guest is doing I/O. Then what happens?

Stefan

>=20
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index 39e7f23..c2d5938 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -1166,7 +1166,7 @@ static void virtio_blk_handle_output(VirtIODevice *=
vdev, VirtQueue *vq)
>  {
>      VirtIOBlock *s =3D (VirtIOBlock *)vdev;
>=20
> -    if (s->dataplane && !s->dataplane_started) {
> +    if (s->dataplane && !s->dataplane_started && !s->stopping) {
>          /* Some guests kick before setting VIRTIO_CONFIG_S_DRIVER_OK so =
start
>           * dataplane here instead of waiting for .set_status().
>           */
> --
> 1.8.3.1
>=20

--EZKvwwGNz6ys+oC2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUulEIACgkQnKSrs4Gr
c8gQmAf/WcmzIZiyKGD+gxH6B3znT2OQ58vmC5h26OZypKC20KfICpGZjIvVQR4C
ds+Pbn2o4MURrWYzYK9ZsRo+kVyYTI/beQMv3EeTk0hGWc0dwNLaHnNf6z5UOjTf
aRDnFW7q+4OvU9DFgfUak9mhn2Fvj924PFcf273SYW5BJUr1oL5HYupdMMtb0XIv
NzkRXRKpcuHq3TuYkXGQ3nnZ4eJ7Z2p3WdqvB4s/EW+myqJfwvvgPHq4EDSIaMkW
oGQ+F7ctmsS3pL9I+i0IdjQ0+OtvPQxxm0KRf/cnuIlCCFm9wG4yx7YXXTZCuMsV
LexD5EiydLnXeKrFwVlWwfLL0oonZQ==
=dI3s
-----END PGP SIGNATURE-----

--EZKvwwGNz6ys+oC2--


