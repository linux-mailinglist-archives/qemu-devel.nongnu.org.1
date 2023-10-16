Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBA17CB368
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 21:40:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsTRG-0008SO-2y; Mon, 16 Oct 2023 15:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qsTRD-0008S0-V4
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 15:39:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qsTRB-0000sZ-WD
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 15:39:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697485176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tQNi8/PVkhcglbIa/KW9Q3o1KGYcHuFRodWRrL+lFeY=;
 b=Mu38BFnIfL8Z+zedpUh0ubmQwkAmsk7iATnU0YKcCJ40mreTW3keHI9onokgPP+M6wc1mi
 1xwd1OtgBXhUvJAu7ZQFz6PIAoE0QjIWlyAbfvED5URYuIxVmpNu7pZdxp2sRpxVy4CRO0
 SxJr+NaExIEb/lhpF8UwmdL72vV6quY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-54-RO-YMq6_MK6rSrV1xLSmHA-1; Mon, 16 Oct 2023 15:39:20 -0400
X-MC-Unique: RO-YMq6_MK6rSrV1xLSmHA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DFD2F381258B;
 Mon, 16 Oct 2023 19:39:19 +0000 (UTC)
Received: from localhost (unknown [10.39.195.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6B59D40C6F79;
 Mon, 16 Oct 2023 19:39:19 +0000 (UTC)
Date: Mon, 16 Oct 2023 15:39:18 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: lv.mengzhao@zte.com.cn
Cc: mst@redhat.com, kwolf@redhat.com, hreitz@redhat.com,
 qemu-devel@nongnu.org, hu.jian@zte.com.cn
Subject: Re: [PATCH] virtio-blk: don't start dataplane during the stop of
 dataplane
Message-ID: <20231016193918.GA163275@fedora>
References: <202310111414266586398@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="1NKsJIRyuIDa+bt4"
Content-Disposition: inline
In-Reply-To: <202310111414266586398@zte.com.cn>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
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


--1NKsJIRyuIDa+bt4
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

Thanks, applied to my block tree:
https://gitlab.com/stefanha/qemu/commits/block

Stefan

--1NKsJIRyuIDa+bt4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUtkWYACgkQnKSrs4Gr
c8jQ2gf9Erm//hSka7v3awToX9qaI+oLcB7T/MJHA+CBdbkvnq/MX30nD0g9+sGY
9PY/88b1EbEGdNB6A85WZILOooqOaBuAfeKsCcuxN8xuFJpeFYtJKIG2gFeIPqdc
jsIkNBIAo3htMbWu1VuA1gweyRhmmG64CAByPhgXmgbF1rJTGIcV1szO8byO1loj
VB7HXGJtdSr6k5rWJ8P7VU13ioQ/hdQVKkIaMNdcfxQqzzcIvW+vul8Q2luRDIfU
VJ0bbxh9q8PbmCeK/kDvrVcs3XPvVtB338XkFX8khmM32qVas3m1XSKWJnyA4qOH
PwqDMO7EydZn+g6kdxcIdavZ4jRlPg==
=jcik
-----END PGP SIGNATURE-----

--1NKsJIRyuIDa+bt4--


