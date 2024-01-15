Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D33D782D345
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 04:20:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPDVa-0003d8-9M; Sun, 14 Jan 2024 22:19:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rPDVY-0003cQ-B5
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 22:19:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rPDVW-00047s-OO
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 22:19:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705288765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O7QNSByQk4QgQg+iy6bDvmqe5VDM7M8ubtUW5N0o/bA=;
 b=Wpu71UUD+T//zuD2gYENhTfsLfLXtWqHS14FEiZXjXgd9WHYJ2tK6RKUJdRLd9/xgbVPab
 86sQ6EOXHhwtQQ85ULNb21SQnfjfDziOBb1EJQbDYEoeAUScNM5SzGo4Ayw1ICRt4ckjak
 Vcyh4XQ85wy448wSQeVX6ZTAteK1Ibs=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-zze412xsP_enBerLu3UBrQ-1; Sun, 14 Jan 2024 22:19:24 -0500
X-MC-Unique: zze412xsP_enBerLu3UBrQ-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-6da380cc0d6so10440619b3a.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jan 2024 19:19:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705288763; x=1705893563;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O7QNSByQk4QgQg+iy6bDvmqe5VDM7M8ubtUW5N0o/bA=;
 b=L30wpOZLbRssN8LBt1XXm0jL3c513LfybAzGKu5ZqAzwuFqaIhk7lL/inB1wzeW8w/
 3xPR2n6DuQBzNXOna01zRDAhnYM3l7mcAgmtdJXVsnE6p3wzcwvhQC3dYGTrppbtVV4z
 ePjhx7GnxVDugSnA/M3Vb4vJtfhm/Ah6deI83Dof97QnhAU+UcFkWsrE7nkj0LnrBLxF
 r9sPuQOsDB5WiblY0B6E5f+fWC3SZBTharCqR4dRO173TGhDjyxHMje0CzsQbJOHdRfM
 eX2ZJTXjx6wTjLPnTNT3BUjda27VxSD0TVC/VlB8/dufE9jyoIqzTV343fEDP6upP7+8
 Rg0g==
X-Gm-Message-State: AOJu0YxDsDXmval7UTlxgcPaazlbhzeM3MTONjwX5Iam1Aq+teNFeVlg
 b3W+hxLU7qKtfd/tKAa37n0/WTIzP+QP3r4vfu9bWq5IIFVG3n7SRt3HanO62VNZT48ZOps3Iqz
 lRcriosuCfTjsc4YQ/nZkmC/RpzLTmzTR9O3+7+4=
X-Received: by 2002:a62:6283:0:b0:6ce:751b:81d9 with SMTP id
 w125-20020a626283000000b006ce751b81d9mr5098025pfb.9.1705288763152; 
 Sun, 14 Jan 2024 19:19:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUlvsIQhNDl/YjSGivSF9ghJrv0Gd4x1wxTExTWF++CWR6G6NKn52gf6K3PJ/w1wGB9BWOf1tzFuz63d3YWmU=
X-Received: by 2002:a62:6283:0:b0:6ce:751b:81d9 with SMTP id
 w125-20020a626283000000b006ce751b81d9mr5098014pfb.9.1705288762886; Sun, 14
 Jan 2024 19:19:22 -0800 (PST)
MIME-Version: 1.0
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
 <1701970793-6865-29-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1701970793-6865-29-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Jan 2024 11:19:11 +0800
Message-ID: <CACGkMEvgCvNe=bY8kgJP0KCT+uq=MmwDaivc8i12CxZo9FosgA@mail.gmail.com>
Subject: Re: [PATCH 28/40] vdpa: support iotlb_batch_asid
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
> Then it's possible to specify ASID when calling the DMA
> batching API. If the ASID to work on doesn't align with
> the ASID for ongoing transaction, the API will fail the
> request and return negative, and the transaction will
> remain intact as if no failed request ever had occured.
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>  hw/virtio/vhost-vdpa.c         | 25 +++++++++++++++++++------
>  include/hw/virtio/vhost-vdpa.h |  1 +
>  net/vhost-vdpa.c               |  1 +
>  3 files changed, 21 insertions(+), 6 deletions(-)
>
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index d3f5721..b7896a8 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -189,15 +189,25 @@ static bool vhost_vdpa_map_batch_begin(VhostVDPASha=
red *s, uint32_t asid)
>
>  static int vhost_vdpa_dma_batch_begin_once(VhostVDPAShared *s, uint32_t =
asid)
>  {
> -    if (!(s->backend_cap & (0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH)) ||
> -        s->iotlb_batch_begin_sent) {
> +    if (!(s->backend_cap & (0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH))) {
>          return 0;
>      }
>
> -    if (vhost_vdpa_map_batch_begin(s, asid)) {
> -        s->iotlb_batch_begin_sent =3D true;
> +    if (s->iotlb_batch_begin_sent && s->iotlb_batch_asid !=3D asid) {
> +        return -1;
> +    }
> +
> +    if (s->iotlb_batch_begin_sent) {
> +        return 0;
>      }
>
> +    if (!vhost_vdpa_map_batch_begin(s, asid)) {
> +        return 0;
> +    }
> +
> +    s->iotlb_batch_begin_sent =3D true;
> +    s->iotlb_batch_asid =3D asid;
> +
>      return 0;
>  }
>
> @@ -237,10 +247,13 @@ static int vhost_vdpa_dma_batch_end_once(VhostVDPAS=
hared *s, uint32_t asid)
>          return 0;
>      }
>
> -    if (vhost_vdpa_dma_batch_end(s, asid)) {
> -        s->iotlb_batch_begin_sent =3D false;
> +    if (!vhost_vdpa_dma_batch_end(s, asid)) {
> +        return 0;
>      }
>
> +    s->iotlb_batch_begin_sent =3D false;
> +    s->iotlb_batch_asid =3D -1;
> +
>      return 0;
>  }
>
> diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdp=
a.h
> index 0fe0f60..219316f 100644
> --- a/include/hw/virtio/vhost-vdpa.h
> +++ b/include/hw/virtio/vhost-vdpa.h
> @@ -61,6 +61,7 @@ typedef struct vhost_vdpa_shared {
>      bool map_thread_enabled;
>
>      bool iotlb_batch_begin_sent;
> +    uint32_t iotlb_batch_asid;
>
>      /*
>       * The memory listener has been registered, so DMA maps have been se=
nt to
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index e9b96ed..bc72345 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -1933,6 +1933,7 @@ static NetClientState *net_vhost_vdpa_init(NetClien=
tState *peer,
>          s->vhost_vdpa.shared->device_fd =3D vdpa_device_fd;
>          s->vhost_vdpa.shared->iova_range =3D iova_range;
>          s->vhost_vdpa.shared->shadow_data =3D svq;
> +        s->vhost_vdpa.shared->iotlb_batch_asid =3D -1;

This seems a trick, uAPI defines asid as:

        __u32 asid;

So technically -1U is a legal value.

Thanks

>          s->vhost_vdpa.shared->refcnt++;
>      } else if (!is_datapath) {
>          s->cvq_cmd_out_buffer =3D mmap(NULL, vhost_vdpa_net_cvq_cmd_page=
_len(),
> --
> 1.8.3.1
>


