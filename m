Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3A382A921
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 09:29:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNqQx-0004k9-Lh; Thu, 11 Jan 2024 03:29:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rNqQq-0004jy-Ci
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 03:28:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rNqQm-0005rE-Jz
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 03:28:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704961732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QscS0JJebfi4PWD4Ax081e46C1bFSN07un0QnlRAqwM=;
 b=MHxAlPL8i8rp1WZ31j6LBGa7kqLrEn35PBOZHWTv75Kmg1KbrcEbYFgN15+pBNc9Fh6q8n
 qVfy5TE+aDOwwzxJEOlcvm8VxJM9IBvUvhU8CqyJiT3lh0KNJI666t02Kef5nJazQIqMam
 UkW+v3OhTTBaWmV9eSSuuXzrLo7ZNJQ=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-yv9H4zyvPKG1yxot9VYIJA-1; Thu, 11 Jan 2024 03:28:50 -0500
X-MC-Unique: yv9H4zyvPKG1yxot9VYIJA-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-6d9b8fef16aso3771017b3a.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 00:28:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704961729; x=1705566529;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QscS0JJebfi4PWD4Ax081e46C1bFSN07un0QnlRAqwM=;
 b=DG6UOLIkNGgewXy3nxgc8Djf2osVl/br5GZGNnZsRqb2qL300uQbaGaj8bmYlYz85E
 Cm++bzCv0opwMoVe2MLxPWxP61AducaHvv9MMAQOm8J8mBYjZ+yruNocv10pw56Dfhy3
 U63MQySyVKdSeeZR1Cw6f90Q1NSJ40fEI5kerv4hUzlGnRJfyQg+nNYiAqsY9rsrd1iE
 MMiHrd/S9NF48O+ZG1m3YLOrRMZcQVlAtBdQzp6UG6bNa46BYT9uUWpuSRgISg4EJKGx
 l5/IBEVUuaCmqj878HlzJwdzvz1xNW5YAlIW70BL/t9J5K11H8W9W74Zct+hHJlJouYC
 qqqw==
X-Gm-Message-State: AOJu0YwLG7QuLKPXNzrfWkBPKjrAAMPhVpkfweHYrfJG038BzuFGBQmA
 xXRYRPwn9R9ZZiK1VbuJpMBLVBBpd4DmZaI7wu3NldMPzj6T2+71vvbPuN6hLCf/clIDOS+/vB7
 F38eLQtTh0WJvbghkALZYGQ7CIPUqFWe0DYGvKKI=
X-Received: by 2002:a05:6a00:1805:b0:6d9:8ddc:37e0 with SMTP id
 y5-20020a056a00180500b006d98ddc37e0mr590341pfa.28.1704961729527; 
 Thu, 11 Jan 2024 00:28:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExN5tCn4aKTlUhkjUymZo2iih1Du2chjVIX4s0iuQM0pM7PFG1B+qhffYkGDgO6jv3tSo6/7vLHK829CTktu4=
X-Received: by 2002:a05:6a00:1805:b0:6d9:8ddc:37e0 with SMTP id
 y5-20020a056a00180500b006d98ddc37e0mr590333pfa.28.1704961729257; Thu, 11 Jan
 2024 00:28:49 -0800 (PST)
MIME-Version: 1.0
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
 <1701970793-6865-20-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1701970793-6865-20-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 11 Jan 2024 16:28:38 +0800
Message-ID: <CACGkMEvP-j8r_a9Jt=rSP1F47m3b3mAqLUUxUii+fgru+Nd2bQ@mail.gmail.com>
Subject: Re: [PATCH 19/40] vdpa: should avoid map flushing with persistent
 iotlb
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: eperezma@redhat.com, mst@redhat.com, dtatulea@nvidia.com, 
 leiyang@redhat.com, yin31149@gmail.com, boris.ostrovsky@oracle.com, 
 jonah.palmer@oracle.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Dec 8, 2023 at 2:50=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> w=
rote:
>
> Today memory listener is unregistered in vhost_vdpa_reset_status
> unconditionally, due to which all the maps will be flushed away
> from the iotlb. However, map flush is not always needed, and
> doing it from performance hot path may have innegligible latency
> impact that affects VM reboot time or brown out period during
> live migration.
>
> Leverage the IOTLB_PERSIST backend featuae, which ensures durable
> iotlb maps and not disappearing even across reset. When it is
> supported, we may conditionally keep the maps for cases where the
> guest memory mapping doesn't change. Prepare a function so that
> the next patch will be able to use it to keep the maps.
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>  hw/virtio/trace-events |  1 +
>  hw/virtio/vhost-vdpa.c | 20 ++++++++++++++++++++
>  2 files changed, 21 insertions(+)
>
> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> index 77905d1..9725d44 100644
> --- a/hw/virtio/trace-events
> +++ b/hw/virtio/trace-events
> @@ -66,6 +66,7 @@ vhost_vdpa_set_owner(void *dev) "dev: %p"
>  vhost_vdpa_vq_get_addr(void *dev, void *vq, uint64_t desc_user_addr, uin=
t64_t avail_user_addr, uint64_t used_user_addr) "dev: %p vq: %p desc_user_a=
ddr: 0x%"PRIx64" avail_user_addr: 0x%"PRIx64" used_user_addr: 0x%"PRIx64
>  vhost_vdpa_get_iova_range(void *dev, uint64_t first, uint64_t last) "dev=
: %p first: 0x%"PRIx64" last: 0x%"PRIx64
>  vhost_vdpa_set_config_call(void *dev, int fd)"dev: %p fd: %d"
> +vhost_vdpa_maybe_flush_map(void *dev, bool reg, bool flush, bool persist=
) "dev: %p registered: %d flush_map: %d iotlb_persistent: %d"
>
>  # virtio.c
>  virtqueue_alloc_element(void *elem, size_t sz, unsigned in_num, unsigned=
 out_num) "elem %p size %zd in_num %u out_num %u"
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index ea2dfc8..31e0a55 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -1471,6 +1471,26 @@ out_stop:
>      return ok ? 0 : -1;
>  }
>
> +static void vhost_vdpa_maybe_flush_map(struct vhost_dev *dev)

Nit: Not a native speaker, but it looks like
vhost_vdpa_may_flush_map() is better.

> +{
> +    struct vhost_vdpa *v =3D dev->opaque;
> +
> +    trace_vhost_vdpa_maybe_flush_map(dev, v->shared->listener_registered=
,
> +                                     v->shared->flush_map,
> +                                     !!(dev->backend_cap &
> +                                     BIT_ULL(VHOST_BACKEND_F_IOTLB_PERSI=
ST)));
> +
> +    if (!v->shared->listener_registered) {
> +        return;
> +    }
> +
> +    if (!(dev->backend_cap & BIT_ULL(VHOST_BACKEND_F_IOTLB_PERSIST)) ||
> +        v->shared->flush_map) {
> +        memory_listener_unregister(&v->shared->listener);
> +        v->shared->listener_registered =3D false;
> +    }

Others look good.

Thanks

> +}
> +
>  static void vhost_vdpa_reset_status(struct vhost_dev *dev)
>  {
>      struct vhost_vdpa *v =3D dev->opaque;
> --
> 1.8.3.1
>


