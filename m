Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1E28117D0
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 16:44:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDRNu-0007ZW-SL; Wed, 13 Dec 2023 10:42:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rDRNs-0007Yz-T6
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 10:42:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rDRNq-0006Li-Tg
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 10:42:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702482169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qlrs0/3L0KzTDGzbw15UlqbekevumT/6RfQqZp1thHs=;
 b=LVpXJuPl4VqQbdSzZm4C1xAuFfDh4MQRvkIsxlxVYzoCUfUjxw36+XZ75+Kk5Qrwej1wpX
 fKUfrNw8RXF6+3y66L0kvMWRsMbtl0MMCj2ew4/JlnwEKoKuokLzdOyTvvyCoj9CXhcjZC
 oIpOBLEq7w/EsGhbisKMneyaRWWnA0Q=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-YIclVPwhMQ-haFFsjpBf7g-1; Wed, 13 Dec 2023 10:42:47 -0500
X-MC-Unique: YIclVPwhMQ-haFFsjpBf7g-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-5d12853cb89so79572277b3.3
 for <qemu-devel@nongnu.org>; Wed, 13 Dec 2023 07:42:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702482167; x=1703086967;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qlrs0/3L0KzTDGzbw15UlqbekevumT/6RfQqZp1thHs=;
 b=LWsQdvHEgggLkVGQnGdH/QfPZgpLyrAagJIMvu0kHEAK4kvaihd7HAY6X16aWlLaHe
 CdUJgcS0K7ZwpaGhJWyTwVwQRttoxsn6IqnnvL+1slIV/ydXs2/1gLlFkg1+Fh7OwuJb
 kvm1Ls92+wc3aspaxN8tXbN/Tx/JE+i2z5ybmhzMwgCnQnCJprRIQXBSSCzX7KAxdDSk
 eSNvye+aRn6NAbTcHUL3aeSpxCB0dTguQV6+vp954Ec57LSqHeXJ0A2IP5wWf5a+BDfZ
 LEdtFLUwI8TcY1TSEvOWidNIRdWqyIJsCqKZe1doLglYFQEKwuC56xH9vyNZuvThQKvD
 krhg==
X-Gm-Message-State: AOJu0YzrmCdNQgvcVd98s6zS4l4A+I+/xr9WLZsB7p6syEIu7mBMvuu3
 jTchmj1zIEaIhzm4Uf2drw0GtTEJmH3ZI5bHkuTxAeAG5KtdPHcac2hyL9e28w/WGKvKFf1hW6U
 VDH5ce6Ya20yREMQA1uDEzepi/y54OeY=
X-Received: by 2002:a81:4404:0:b0:5e1:7589:3030 with SMTP id
 r4-20020a814404000000b005e175893030mr2910907ywa.53.1702482167422; 
 Wed, 13 Dec 2023 07:42:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFaNe3pJJEZ8JIivgA+Q/sUkwKZoRusdl6X7CZKL4tBTP5s1EUpJgwMB2M/DFGHoaejwoOHOqkC26eOJkH5cgo=
X-Received: by 2002:a81:4404:0:b0:5e1:7589:3030 with SMTP id
 r4-20020a814404000000b005e175893030mr2910894ywa.53.1702482167096; Wed, 13 Dec
 2023 07:42:47 -0800 (PST)
MIME-Version: 1.0
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
 <1701970793-6865-26-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1701970793-6865-26-git-send-email-si-wei.liu@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 13 Dec 2023 16:42:10 +0100
Message-ID: <CAJaqyWcX82b+cQc0B-P5OmpBxvPu8brcJMkfWCYY48BoK6=zMg@mail.gmail.com>
Subject: Re: [PATCH 25/40] vdpa: add asid to dma_batch_once API
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: jasowang@redhat.com, mst@redhat.com, dtatulea@nvidia.com, 
 leiyang@redhat.com, yin31149@gmail.com, boris.ostrovsky@oracle.com, 
 jonah.palmer@oracle.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
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

On Thu, Dec 7, 2023 at 7:51=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.com> w=
rote:
>
> So that DMA batching API can operate on other ASID than 0.
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>  hw/virtio/trace-events |  4 ++--
>  hw/virtio/vhost-vdpa.c | 14 ++++++++------
>  2 files changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> index 3411a07..196f32f 100644
> --- a/hw/virtio/trace-events
> +++ b/hw/virtio/trace-events
> @@ -32,8 +32,8 @@ vhost_user_create_notifier(int idx, void *n) "idx:%d n:=
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
> -vhost_vdpa_map_batch_begin(void *v, int fd, uint32_t msg_type, uint8_t t=
ype)  "vdpa_shared:%p fd: %d msg_type: %"PRIu32" type: %"PRIu8
> -vhost_vdpa_dma_batch_end(void *v, int fd, uint32_t msg_type, uint8_t typ=
e)  "vdpa_shared:%p fd: %d msg_type: %"PRIu32" type: %"PRIu8
> +vhost_vdpa_map_batch_begin(void *v, int fd, uint32_t msg_type, uint8_t t=
ype, uint32_t asid)  "vdpa_shared:%p fd: %d msg_type: %"PRIu32" type: %"PRI=
u8" asid: %"PRIu32
> +vhost_vdpa_dma_batch_end(void *v, int fd, uint32_t msg_type, uint8_t typ=
e, uint32_t asid)  "vdpa_shared:%p fd: %d msg_type: %"PRIu32" type: %"PRIu8=
" asid: %"PRIu32
>  vhost_vdpa_listener_region_add_unaligned(void *v, const char *name, uint=
64_t offset_as, uint64_t offset_page) "vdpa_shared: %p region %s offset_wit=
hin_address_space %"PRIu64" offset_within_region %"PRIu64
>  vhost_vdpa_listener_region_add(void *vdpa, uint64_t iova, uint64_t llend=
, void *vaddr, bool readonly) "vdpa: %p iova 0x%"PRIx64" llend 0x%"PRIx64" =
vaddr: %p read-only: %d"
>  vhost_vdpa_listener_region_del_unaligned(void *v, const char *name, uint=
64_t offset_as, uint64_t offset_page) "vdpa_shared: %p region %s offset_wit=
hin_address_space %"PRIu64" offset_within_region %"PRIu64
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 999a97a..2db2832 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -161,11 +161,12 @@ int vhost_vdpa_dma_unmap(VhostVDPAShared *s, uint32=
_t asid, hwaddr iova,
>      return ret;
>  }
>
> -static bool vhost_vdpa_map_batch_begin(VhostVDPAShared *s)
> +static bool vhost_vdpa_map_batch_begin(VhostVDPAShared *s, uint32_t asid=
)
>  {
>      int fd =3D s->device_fd;
>      struct vhost_msg_v2 msg =3D {
>          .type =3D VHOST_IOTLB_MSG_V2,
> +        .asid =3D asid,
>          .iotlb.type =3D VHOST_IOTLB_BATCH_BEGIN,
>      };
>
> @@ -178,7 +179,7 @@ static bool vhost_vdpa_map_batch_begin(VhostVDPAShare=
d *s)
>          return false;
>      }
>
> -    trace_vhost_vdpa_map_batch_begin(s, fd, msg.type, msg.iotlb.type);
> +    trace_vhost_vdpa_map_batch_begin(s, fd, msg.type, msg.iotlb.type, ms=
g.asid);
>      if (write(fd, &msg, sizeof(msg)) !=3D sizeof(msg)) {
>          error_report("failed to write, fd=3D%d, errno=3D%d (%s)",
>                       fd, errno, strerror(errno));
> @@ -193,17 +194,18 @@ static void vhost_vdpa_dma_batch_begin_once(VhostVD=
PAShared *s)
>          return;
>      }
>
> -    if (vhost_vdpa_map_batch_begin(s)) {
> +    if (vhost_vdpa_map_batch_begin(s, 0)) {
>          s->iotlb_batch_begin_sent =3D true;
>      }
>  }
>
> -static bool vhost_vdpa_dma_batch_end(VhostVDPAShared *s)
> +static bool vhost_vdpa_dma_batch_end(VhostVDPAShared *s, uint32_t asid)

Maybe adding the asid parameter is not needed? We already have it in
s->asid by the end of the series, and kernel will also complain if
wrong asid is send.

Actually, dma_map and dma_unmap have the asid parameter because maps
out of batch, but I think there are no IOTLB operation out of batch by
the end of the series, isn't it?

Thanks!

>  {
>      struct vhost_msg_v2 msg =3D {};
>      int fd =3D s->device_fd;
>
>      msg.type =3D VHOST_IOTLB_MSG_V2;
> +    msg.asid =3D asid;
>      msg.iotlb.type =3D VHOST_IOTLB_BATCH_END;
>
>      if (s->map_thread_enabled && !qemu_thread_is_self(&s->map_thread)) {
> @@ -215,7 +217,7 @@ static bool vhost_vdpa_dma_batch_end(VhostVDPAShared =
*s)
>          return false;
>      }
>
> -    trace_vhost_vdpa_dma_batch_end(s, fd, msg.type, msg.iotlb.type);
> +    trace_vhost_vdpa_dma_batch_end(s, fd, msg.type, msg.iotlb.type, msg.=
asid);
>      if (write(fd, &msg, sizeof(msg)) !=3D sizeof(msg)) {
>          error_report("failed to write, fd=3D%d, errno=3D%d (%s)",
>                       fd, errno, strerror(errno));
> @@ -233,7 +235,7 @@ static void vhost_vdpa_dma_batch_end_once(VhostVDPASh=
ared *s)
>          return;
>      }
>
> -    if (vhost_vdpa_dma_batch_end(s)) {
> +    if (vhost_vdpa_dma_batch_end(s, 0)) {
>          s->iotlb_batch_begin_sent =3D false;
>      }
>  }
> --
> 1.8.3.1
>


