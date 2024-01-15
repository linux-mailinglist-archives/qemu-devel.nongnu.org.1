Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2509882D338
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 04:03:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPDFO-0004lg-5Q; Sun, 14 Jan 2024 22:02:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rPDFK-0004lP-KJ
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 22:02:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rPDFI-0001LC-VJ
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 22:02:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705287759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0r51jo1SpXibwL7z9sJc2tovQK61waqHTcSXEFWquy4=;
 b=jA3Zf6rUw5OoAg/gtBZ8OYqczHr/C25kF6NhOfE9nh2b3pycwl58K+PdZAUqXhf79fFa1W
 5/TDYDN8L52J9Jo/TCPdcYuaJi7XaTemFiuNg9EoccSVUN5r2ZMns3lFrBol4fi2PQ0e2U
 IHR3ZlFvwgpw0X2vdOEQFdVGn9iqig4=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-GGkIrjd0PS-BPGsAhr2nEQ-1; Sun, 14 Jan 2024 22:02:37 -0500
X-MC-Unique: GGkIrjd0PS-BPGsAhr2nEQ-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-5c17cff57f9so3686779a12.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jan 2024 19:02:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705287756; x=1705892556;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0r51jo1SpXibwL7z9sJc2tovQK61waqHTcSXEFWquy4=;
 b=pKmxqLctaYUDfuI/iuqHCc2hmpufsNTIZaJ50W315OUm0GgnVtpO4PcstqLHPphmim
 gvmMBCDnqW2pK3VE0Ag23auMHyvdEKQLAHufo0bgOypGZHALXsTiJEjyIveMrBzoxW2i
 /yFXdGPqGRnCD1gbt8TvI3YXPU9sGLXm8HomTV3V9jtLE94P1hOsM3/JlLysMOIfy37S
 jCJ/xsuUp3js/oFtwgzoFBVkTn72CI9b9UZMh4cCoCjEMSuq72m6G/kkUicdoxMgDLKa
 pFaF9nvvz8E04dSmVVKHeCHdrnU633Jy/YF/FViYfPLnAYssLbYGaEvbK47Czq8IMcAa
 opfw==
X-Gm-Message-State: AOJu0YzRisJj8xoajDLDYBTejWA1e0IjNt2GPq56fws0RQ9U0ENhyqmZ
 nPzXwxo/nSb604XQplFU0A7rNYygsjyXHo2NBSeKwQ0TurdBGKZj630swMDk3zo3DadhOyozC5w
 a4so8gBwdSlKdr/hEgFDx4soiBFLq6n2G1xXVoz4=
X-Received: by 2002:a05:6a20:9387:b0:19a:3f14:5a2e with SMTP id
 x7-20020a056a20938700b0019a3f145a2emr2181107pzh.85.1705287756586; 
 Sun, 14 Jan 2024 19:02:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHp6ntM2lPbbZQ5+gzH0+YyHLqDH9PuHXhhGH1QD65EMa/1RN0gNiGMFlBrd0DpblD6QnUB/ZWDyNGI34E8itU=
X-Received: by 2002:a05:6a20:9387:b0:19a:3f14:5a2e with SMTP id
 x7-20020a056a20938700b0019a3f145a2emr2181093pzh.85.1705287755807; Sun, 14 Jan
 2024 19:02:35 -0800 (PST)
MIME-Version: 1.0
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
 <1701970793-6865-23-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1701970793-6865-23-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Jan 2024 11:02:24 +0800
Message-ID: <CACGkMEs1gw2_tRSU-+h=W-xXRiYkrjiuP3KBi8dtfRsANaJ16Q@mail.gmail.com>
Subject: Re: [PATCH 22/40] vdpa: factor out vhost_vdpa_map_batch_begin
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: eperezma@redhat.com, mst@redhat.com, dtatulea@nvidia.com, 
 leiyang@redhat.com, yin31149@gmail.com, boris.ostrovsky@oracle.com, 
 jonah.palmer@oracle.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Dec 8, 2023 at 2:51=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> w=
rote:
>
> Refactoring only. No functional change.
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  hw/virtio/trace-events |  2 +-
>  hw/virtio/vhost-vdpa.c | 25 ++++++++++++++++---------
>  2 files changed, 17 insertions(+), 10 deletions(-)
>
> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> index 9725d44..b0239b8 100644
> --- a/hw/virtio/trace-events
> +++ b/hw/virtio/trace-events
> @@ -32,7 +32,7 @@ vhost_user_create_notifier(int idx, void *n) "idx:%d n:=
%p"
>  # vhost-vdpa.c
>  vhost_vdpa_dma_map(void *vdpa, int fd, uint32_t msg_type, uint32_t asid,=
 uint64_t iova, uint64_t size, uint64_t uaddr, uint8_t perm, uint8_t type) =
"vdpa_shared:%p fd: %d msg_type: %"PRIu32" asid: %"PRIu32" iova: 0x%"PRIx64=
" size: 0x%"PRIx64" uaddr: 0x%"PRIx64" perm: 0x%"PRIx8" type: %"PRIu8
>  vhost_vdpa_dma_unmap(void *vdpa, int fd, uint32_t msg_type, uint32_t asi=
d, uint64_t iova, uint64_t size, uint8_t type) "vdpa_shared:%p fd: %d msg_t=
ype: %"PRIu32" asid: %"PRIu32" iova: 0x%"PRIx64" size: 0x%"PRIx64" type: %"=
PRIu8
> -vhost_vdpa_listener_begin_batch(void *v, int fd, uint32_t msg_type, uint=
8_t type)  "vdpa_shared:%p fd: %d msg_type: %"PRIu32" type: %"PRIu8
> +vhost_vdpa_map_batch_begin(void *v, int fd, uint32_t msg_type, uint8_t t=
ype)  "vdpa_shared:%p fd: %d msg_type: %"PRIu32" type: %"PRIu8
>  vhost_vdpa_listener_commit(void *v, int fd, uint32_t msg_type, uint8_t t=
ype)  "vdpa_shared:%p fd: %d msg_type: %"PRIu32" type: %"PRIu8
>  vhost_vdpa_listener_region_add_unaligned(void *v, const char *name, uint=
64_t offset_as, uint64_t offset_page) "vdpa_shared: %p region %s offset_wit=
hin_address_space %"PRIu64" offset_within_region %"PRIu64
>  vhost_vdpa_listener_region_add(void *vdpa, uint64_t iova, uint64_t llend=
, void *vaddr, bool readonly) "vdpa: %p iova 0x%"PRIx64" llend 0x%"PRIx64" =
vaddr: %p read-only: %d"
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 013bfa2..7a1b7f4 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -161,7 +161,7 @@ int vhost_vdpa_dma_unmap(VhostVDPAShared *s, uint32_t=
 asid, hwaddr iova,
>      return ret;
>  }
>
> -static void vhost_vdpa_iotlb_batch_begin_once(VhostVDPAShared *s)
> +static bool vhost_vdpa_map_batch_begin(VhostVDPAShared *s)
>  {
>      int fd =3D s->device_fd;
>      struct vhost_msg_v2 msg =3D {
> @@ -169,26 +169,33 @@ static void vhost_vdpa_iotlb_batch_begin_once(Vhost=
VDPAShared *s)
>          .iotlb.type =3D VHOST_IOTLB_BATCH_BEGIN,
>      };
>
> -    if (!(s->backend_cap & (0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH)) ||
> -        s->iotlb_batch_begin_sent) {
> -        return;
> -    }
> -
>      if (s->map_thread_enabled && !qemu_thread_is_self(&s->map_thread)) {
>          struct vhost_msg_v2 *new_msg =3D g_new(struct vhost_msg_v2, 1);
>
>          *new_msg =3D msg;
>          g_async_queue_push(s->map_queue, new_msg);
>
> -        return;
> +        return false;
>      }
>
> -    trace_vhost_vdpa_listener_begin_batch(s, fd, msg.type, msg.iotlb.typ=
e);
> +    trace_vhost_vdpa_map_batch_begin(s, fd, msg.type, msg.iotlb.type);
>      if (write(fd, &msg, sizeof(msg)) !=3D sizeof(msg)) {
>          error_report("failed to write, fd=3D%d, errno=3D%d (%s)",
>                       fd, errno, strerror(errno));
>      }
> -    s->iotlb_batch_begin_sent =3D true;
> +    return true;
> +}
> +
> +static void vhost_vdpa_iotlb_batch_begin_once(VhostVDPAShared *s)
> +{
> +    if (!(s->backend_cap & (0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH)) ||
> +        s->iotlb_batch_begin_sent) {
> +        return;
> +    }
> +
> +    if (vhost_vdpa_map_batch_begin(s)) {
> +        s->iotlb_batch_begin_sent =3D true;
> +    }
>  }
>
>  static void vhost_vdpa_dma_batch_end_once(VhostVDPAShared *s)
> --
> 1.8.3.1
>


