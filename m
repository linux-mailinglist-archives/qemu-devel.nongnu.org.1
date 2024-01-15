Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D12982D328
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 03:41:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPCu0-0000Vv-97; Sun, 14 Jan 2024 21:40:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rPCtx-0000Vb-Eo
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 21:40:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rPCtv-0006XY-UN
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 21:40:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705286435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bs0wTYMrrLyajPPSC+bHLO/fH0+eLhZS/UQ9IF1qwpQ=;
 b=U8WF6M+EoMdCeuYE1+/2BXDCswJhFpTJ3Or1DSpRYhFw1hY0sQmsH5TClES1+jegmhuNMY
 /2JSczT1ortppOLtt5qlCIQScj1CKmCAuKe0wPkTyGjTSK5LnRaX7Qn+OSodQwzNY2+c4p
 UZpcZ7aeIDPOMh6DD6867cjMpRIYQzQ=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-rOGR1xfZMMCKouZLkXKSPQ-1; Sun, 14 Jan 2024 21:40:33 -0500
X-MC-Unique: rOGR1xfZMMCKouZLkXKSPQ-1
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-598f047f07fso722200eaf.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jan 2024 18:40:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705286433; x=1705891233;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bs0wTYMrrLyajPPSC+bHLO/fH0+eLhZS/UQ9IF1qwpQ=;
 b=f2wMGxNRy4KjdLPKLkVh1Ot1qiLt3agsbk+ibFgR5QLM/6FtnRI5yrxYBMBqARervO
 jo+igX4J7GPgQjjQCYaxeD+DvYHoaijT7LfCT+KyOyCa3osUxYPViWtU58JICduYbICO
 +ohSvFEIEDHmavbfF7FJIWxt/cTPXzgD2ghDZIVq9Fz+LdoGLcx2SqDHM3yn1rPSh/6F
 Iv41RQHOSaWKZzI9dsZgygTvCBf/rAUBipmWPkM8iYV2KcYplhATcn3Wwf39TbFefQO7
 THpzZwPBn7nkcXvkYHrcnOdgnYfsZXSD+TSp1J3GS7Os9n9EU3RU/J1t6LRKkOuCL6vf
 8BXw==
X-Gm-Message-State: AOJu0Yw27c/VzH7smgcqLDnDJJkhOyAdYtuK+lR7y7esz9k+NIKR/ZoZ
 OyB1tQzyCHzCq8kiX7AHzVLMQxYblyGza0fg1h45ZwA/k7y2IzLCS0ME3Rp0IaPS1jQ6qyWP5Uf
 oAsGHoQDoUUIcvzFBawmbO3OWrwDqWtZevtPYa9c=
X-Received: by 2002:a05:6358:4e55:b0:173:ab53:5e3c with SMTP id
 le21-20020a0563584e5500b00173ab535e3cmr6586795rwc.45.1705286432828; 
 Sun, 14 Jan 2024 18:40:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7/omlUTtiTzDcq+Imo6yEgK9KNTNW+PexV4+WYIdk43RptEztwpRAeXr6bX8N+wnHbP029MP1sPIDwC4hqSw=
X-Received: by 2002:a05:6358:4e55:b0:173:ab53:5e3c with SMTP id
 le21-20020a0563584e5500b00173ab535e3cmr6586777rwc.45.1705286432453; Sun, 14
 Jan 2024 18:40:32 -0800 (PST)
MIME-Version: 1.0
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
 <1701970793-6865-22-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1701970793-6865-22-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Jan 2024 10:40:21 +0800
Message-ID: <CACGkMEtn3L7YJwo7Zn6U-6dmgrt98B814S6mDYSUw75+87naeg@mail.gmail.com>
Subject: Re: [PATCH 21/40] vdpa: vhost_vdpa_dma_batch_end_once rename
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: eperezma@redhat.com, mst@redhat.com, dtatulea@nvidia.com, 
 leiyang@redhat.com, yin31149@gmail.com, boris.ostrovsky@oracle.com, 
 jonah.palmer@oracle.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
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

On Fri, Dec 8, 2023 at 2:51=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> w=
rote:
>
> No functional changes. Rename only.
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>  hw/virtio/vhost-vdpa.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 47c764b..013bfa2 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -191,7 +191,7 @@ static void vhost_vdpa_iotlb_batch_begin_once(VhostVD=
PAShared *s)
>      s->iotlb_batch_begin_sent =3D true;
>  }
>
> -static void vhost_vdpa_dma_end_batch(VhostVDPAShared *s)
> +static void vhost_vdpa_dma_batch_end_once(VhostVDPAShared *s)
>  {
>      struct vhost_msg_v2 msg =3D {};
>      int fd =3D s->device_fd;
> @@ -229,7 +229,7 @@ static void vhost_vdpa_listener_commit(MemoryListener=
 *listener)
>  {
>      VhostVDPAShared *s =3D container_of(listener, VhostVDPAShared, liste=
ner);
>
> -    vhost_vdpa_dma_end_batch(s);
> +    vhost_vdpa_dma_batch_end_once(s);
>  }
>
>  static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry =
*iotlb)
> @@ -1367,7 +1367,7 @@ static void *vhost_vdpa_load_map(void *opaque)
>              vhost_vdpa_iotlb_batch_begin_once(shared);
>              break;
>          case VHOST_IOTLB_BATCH_END:
> -            vhost_vdpa_dma_end_batch(shared);
> +            vhost_vdpa_dma_batch_end_once(shared);

It's better to explain why having a "_once" suffix is better here.

Thanks

>              break;
>          default:
>              error_report("Invalid IOTLB msg type %d", msg->iotlb.type);
> --
> 1.8.3.1
>


