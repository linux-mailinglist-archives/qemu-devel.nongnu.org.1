Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E56782D33B
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 04:08:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPDK3-0006xb-T9; Sun, 14 Jan 2024 22:07:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rPDK2-0006xM-9w
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 22:07:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rPDK0-000222-Lk
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 22:07:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705288051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x5Z+tOleCfUMgH0v2zTuWruz7MV5zs4QALe4Kwh+u18=;
 b=dKTPbW/O+q3Q085MbM1w4Z+UcvMs1Y0p+ueplR9H4yS/nC3esM2PxIqDKdMAUsDHwxBKyl
 HUrRgRpoeCFjc0bf4HtyI3xGmPGBrDI4c71AOoiBQUP+rRaVyVabkhvmu2CcLtdskXK2ee
 8MPiOQhDHaGPjjQqQsLpH7BFlU3AakI=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-NUBtgGLwMtmRv3_HnWeWaA-1; Sun, 14 Jan 2024 22:07:29 -0500
X-MC-Unique: NUBtgGLwMtmRv3_HnWeWaA-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-6d9b8ff5643so4439610b3a.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jan 2024 19:07:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705288048; x=1705892848;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x5Z+tOleCfUMgH0v2zTuWruz7MV5zs4QALe4Kwh+u18=;
 b=WnAbQXRgfae9fvPozQ0rSTBqAfOwjOdg7iXAgdLm6ccPiqChy9+OZquVaLibELg6Ue
 UCyo//lvQirz5vkOCsR2nWsOJMCWC5rXgISY1J1FmsxCahgKsQl/VhQSDGlPeAMDEW0U
 h6TmpCplEX/3v0dXHyTRMbTnbUf0myPwhvXxgSleLzq3mzdpX3TAt21RWP3dJVz9b2N4
 HQLIBm7mMmAxPvdDt3by911xU5JgTk4Sj2JSbbBOcCBeXaNvK6c0YuUKfIPiIRkxkhff
 hZiir485BzsM3VjrmtDpVykLRW1C85rzeRfRfgRvfpslyz38T/KwyKwTeA3aULBtt4Xw
 MO7w==
X-Gm-Message-State: AOJu0YxoCRIDRcDy/xaCdH6DCF27wfvpf1/9TjTx5zqmd2th7W27n8p6
 jXvd4IHIkUS9eqt5ViwT93KSLMixCJ0V1RJQDmU9+bkdywxzAD3TPVyYsOXqEmVrhSOEh8cugDc
 PwlrbVyQ5jk8bl52vaxX4lJhn8KXxLaSAw4FQL+Y=
X-Received: by 2002:a05:6a00:939f:b0:6da:d8c8:f2ad with SMTP id
 ka31-20020a056a00939f00b006dad8c8f2admr2584887pfb.43.1705288048215; 
 Sun, 14 Jan 2024 19:07:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgGLKpHu3MSZf+gKvdfS2Z2wfjMSqf23/TmbF01tUw+w4v0c4Je74/mFC26ykxZsZ9meCiURsSzH2MzZ1ru5s=
X-Received: by 2002:a05:6a00:939f:b0:6da:d8c8:f2ad with SMTP id
 ka31-20020a056a00939f00b006dad8c8f2admr2584881pfb.43.1705288047975; Sun, 14
 Jan 2024 19:07:27 -0800 (PST)
MIME-Version: 1.0
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
 <1701970793-6865-26-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1701970793-6865-26-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Jan 2024 11:07:16 +0800
Message-ID: <CACGkMEvH92AFeNxGc7XPyXNF+L3WmQ9n9Pdd3JDkeEEog2b9Kw@mail.gmail.com>
Subject: Re: [PATCH 25/40] vdpa: add asid to dma_batch_once API
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

I wonder if we need a check if vhost doesn't support ASID but asid is not z=
ero?

Thanks


