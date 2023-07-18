Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B2B7579AB
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 12:54:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLiLJ-00035R-If; Tue, 18 Jul 2023 06:54:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qLiLH-000350-Ch
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 06:54:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qLiLF-0004Uo-Tp
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 06:54:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689677644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DsIhAx2efrp8I+W9z9XzF1i1i1a5GpamwYc4P5wpq8I=;
 b=QFAM2ydOQgMSUCoZhcg6eILCltiOB08ADAVMtCsAoR7pH5Y/9zrMWY0RXh62+y8G8dHfwn
 TZuR2CM4UyaJaynTz3G3pudEmF88f0AnLK11KUnO5eRsFiTbvD+cgJsbI9E0ChbpEqfAM8
 IPoGVoAiPurMYt5Aqp99PCphk001NgM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-YGoAHdEgNraBZMG4TUtdGg-1; Tue, 18 Jul 2023 06:54:03 -0400
X-MC-Unique: YGoAHdEgNraBZMG4TUtdGg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fbe590234aso32468225e9.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 03:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689677641; x=1692269641;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DsIhAx2efrp8I+W9z9XzF1i1i1a5GpamwYc4P5wpq8I=;
 b=TcDB/7Cy7sRE+Hwbcq9nty1Nx+J/n267s4DoCt3N41sDDVX6BDxX5A8nrsmod9Ucoa
 s00w1+aWm2Y+CWiL1wtRGBTRK57DSG1fSUDKD4yE++4iydCsu0ls3pyormqXhqE3RQL/
 0D1dYnSbk7brj35elrp3TfH49ZnJc9KELfBDu2TXWKiF618guCCbRFSAXGUezZUl2i0D
 LApWM4FoeD94L+sEFzZNIrWhGkeRqVY2uNqkn64IM4eOgXmSKo1k1uZvsOZvNjEL3oLx
 aSzeiMiFuiGau1HkXdhl6Pk7KRD/Adn58hPpwLPwx8ORek/NKiAB8+5DaSJuotMmkTY9
 nxEg==
X-Gm-Message-State: ABy/qLYyPFq8Hw2SjSVjx4X/LsWngyqhMumZegxaJmXIetEAgQcWQlWr
 JwTnomywq6tBYrqBP9xqpHcz7Kt8l3w5G49YKOlLMMM4z8TV2nuB8YHXQMYwRpGtaadmDGeJ+K/
 czXMZGdG3onxsPVs8ylH/eDE=
X-Received: by 2002:a1c:4b0e:0:b0:3fc:855:db42 with SMTP id
 y14-20020a1c4b0e000000b003fc0855db42mr1731821wma.34.1689677641492; 
 Tue, 18 Jul 2023 03:54:01 -0700 (PDT)
X-Google-Smtp-Source: APBJJlENTEebIZcJP5KFOWUrZLaGqCEFNLZY16D2a0B3fg7//VxotudhUuAhZGQJYknSGiGKUF+9Eg==
X-Received: by 2002:a1c:4b0e:0:b0:3fc:855:db42 with SMTP id
 y14-20020a1c4b0e000000b003fc0855db42mr1731814wma.34.1689677641175; 
 Tue, 18 Jul 2023 03:54:01 -0700 (PDT)
Received: from redhat.com ([2a02:14f:174:a216:963c:8e9a:5e99:d745])
 by smtp.gmail.com with ESMTPSA id
 q7-20020a7bce87000000b003fba137857esm1865488wmj.14.2023.07.18.03.53.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jul 2023 03:54:00 -0700 (PDT)
Date: Tue, 18 Jul 2023 06:53:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: peili.dev@gmail.com
Cc: qemu-devel@nongnu.org, eperezma@redhat.com
Subject: Re: [PATCH 1/2] Reduce vdpa initialization / startup overhead
Message-ID: <20230718065156-mutt-send-email-mst@kernel.org>
References: <20230418225638.1467969-1-peili.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418225638.1467969-1-peili.dev@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Tue, Apr 18, 2023 at 06:56:37PM -0400, peili.dev@gmail.com wrote:
> From: Pei Li <peili.dev@gmail.com>
> 
> Currently, part of the vdpa initialization / startup process
> needs to trigger many ioctls per vq, which is very inefficient
> and causing unnecessary context switch between user mode and
> kernel mode.
> 
> This patch creates an additional ioctl() command, namely
> VHOST_VDPA_GET_VRING_GROUP_BATCH, that will batching
> commands of VHOST_VDPA_GET_VRING_GROUP into a single
> ioctl() call.
> 
> Signed-off-by: Pei Li <peili.dev@gmail.com>

This is all very exciting, but what exactly is the benefit?
No optimization patches are going to be merged without
numbers showing performance gains.
In this case, can you show gains in process startup time?
Are they significant enough to warrant adding new UAPI?

> ---
>  hw/virtio/vhost-vdpa.c                       | 31 +++++++++++++++-----
>  include/standard-headers/linux/vhost_types.h |  3 ++
>  linux-headers/linux/vhost.h                  |  7 +++++
>  3 files changed, 33 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index bc6bad23d5..6d45ff8539 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -679,7 +679,8 @@ static int vhost_vdpa_set_backend_cap(struct vhost_dev *dev)
>      uint64_t f = 0x1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2 |
>          0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH |
>          0x1ULL << VHOST_BACKEND_F_IOTLB_ASID |
> -        0x1ULL << VHOST_BACKEND_F_SUSPEND;
> +        0x1ULL << VHOST_BACKEND_F_SUSPEND |
> +        0x1ULL << VHOST_BACKEND_F_IOCTL_BATCH;
>      int r;
>  
>      if (vhost_vdpa_call(dev, VHOST_GET_BACKEND_FEATURES, &features)) {
> @@ -731,14 +732,28 @@ static int vhost_vdpa_get_vq_index(struct vhost_dev *dev, int idx)
>  
>  static int vhost_vdpa_set_vring_ready(struct vhost_dev *dev)
>  {
> -    int i;
> +    int i, nvqs = dev->nvqs;
> +    uint64_t backend_features = dev->backend_cap;
> +
>      trace_vhost_vdpa_set_vring_ready(dev);
> -    for (i = 0; i < dev->nvqs; ++i) {
> -        struct vhost_vring_state state = {
> -            .index = dev->vq_index + i,
> -            .num = 1,
> -        };
> -        vhost_vdpa_call(dev, VHOST_VDPA_SET_VRING_ENABLE, &state);
> +
> +    if (!(backend_features & BIT_ULL(VHOST_BACKEND_F_IOCTL_BATCH))) {
> +        for (i = 0; i < nvqs; ++i) {
> +            struct vhost_vring_state state = {
> +                .index = dev->vq_index + i,
> +                .num = 1,
> +            };
> +            vhost_vdpa_call(dev, VHOST_VDPA_SET_VRING_ENABLE, &state);
> +        }
> +    } else {
> +        struct vhost_vring_state states[nvqs + 1];
> +        states[0].num = nvqs;
> +        for (i = 1; i <= nvqs; ++i) {
> +            states[i].index = dev->vq_index + i - 1;
> +            states[i].num = 1;
> +        }
> +
> +        vhost_vdpa_call(dev, VHOST_VDPA_SET_VRING_ENABLE_BATCH, &states[0]);
>      }
>      return 0;
>  }
> diff --git a/include/standard-headers/linux/vhost_types.h b/include/standard-headers/linux/vhost_types.h
> index c41a73fe36..068d0e1ceb 100644
> --- a/include/standard-headers/linux/vhost_types.h
> +++ b/include/standard-headers/linux/vhost_types.h
> @@ -164,4 +164,7 @@ struct vhost_vdpa_iova_range {
>  /* Device can be suspended */
>  #define VHOST_BACKEND_F_SUSPEND  0x4
>  
> +/* IOCTL requests can be batched */
> +#define VHOST_BACKEND_F_IOCTL_BATCH 0x6
> +
>  #endif
> diff --git a/linux-headers/linux/vhost.h b/linux-headers/linux/vhost.h
> index f9f115a7c7..4c9ddd0a0e 100644
> --- a/linux-headers/linux/vhost.h
> +++ b/linux-headers/linux/vhost.h
> @@ -180,4 +180,11 @@
>   */
>  #define VHOST_VDPA_SUSPEND		_IO(VHOST_VIRTIO, 0x7D)
>  
> +/* Batch version of VHOST_VDPA_SET_VRING_ENABLE
> + *
> + * Enable/disable the ring while batching the commands.
> + */
> +#define VHOST_VDPA_SET_VRING_ENABLE_BATCH	_IOW(VHOST_VIRTIO, 0x7F, \
> +					     struct vhost_vring_state)
> +
>  #endif
> -- 
> 2.25.1
> 
> 


