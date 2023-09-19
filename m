Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D22D87A698B
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 19:23:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qieQq-0001jC-TB; Tue, 19 Sep 2023 13:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qieQo-0001iA-F4
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 13:22:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qieQm-0000Ug-Tm
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 13:22:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695144155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oMGyB3R4K6ih3BVDoZ9abP8pvxM14IpOrRfJzzUzO6U=;
 b=i6YqXUGQuTZ+EHhGKSVkXF0LOq+ncLRYUMKzaIZ5VboZQf9SzghCae7v8XW0C9jT5hPLZU
 7l2Z/J9D8Woy+MtXHHtAodFcshTFFha32WBefwU57l4J9OXcTy0adXalvCtBb9ozI9bZYa
 naZCU+r08itTAIAq3ck5Q+YyMqynTDg=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-QHEfC0AfM8yhRMb9rXuEHQ-1; Tue, 19 Sep 2023 13:22:34 -0400
X-MC-Unique: QHEfC0AfM8yhRMb9rXuEHQ-1
Received: by mail-il1-f198.google.com with SMTP id
 e9e14a558f8ab-34fc277401cso34915155ab.2
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 10:22:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695144153; x=1695748953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oMGyB3R4K6ih3BVDoZ9abP8pvxM14IpOrRfJzzUzO6U=;
 b=nfmXxY+9bCQBm2Hc4zx21d6zy434/KkLV1IwzrvjeMXAB5zmT4niRfCtmhh4e1dKNX
 4UQcJr14WqIsHji9WKCVLlv4M0e3nEmwkDjrEJAOaaaOvrpweKpqikFjSrEC3wino0C1
 APHx505ChSuJkndhqzc5VO4ZYk2xEKsKWYNRmkMkT0uAKezTrBiNFdv6/M8yvJp6lm77
 a6a/4/QrT+Ztilzuds9MZdyuikqyiHFGlse8l6Xry6Jyrn8UxvxCig0q0w37guSXZ76h
 7xaOYqCd6yCnTin+Y62IDhzKywzoAhe9R4ryzLZFu9ouHAe1w9DPPf2TnAV0qFWbYym8
 J72g==
X-Gm-Message-State: AOJu0YwRBqODIu8nwDFsq6DXO0TO+bDPxPiTqbvPm/3IpIr8xa/5Osfs
 QcWQmQJQOygOL7oheGVPa9ZwvjL0ry0+ogoHwnX1c4FqJi4M6bjPukXBWhQDDbYi1X2Mmb33uVU
 /WiYA/v5KxcQl4Zg=
X-Received: by 2002:a05:6e02:20c2:b0:34f:cff6:5e2f with SMTP id
 2-20020a056e0220c200b0034fcff65e2fmr529492ilq.30.1695144153256; 
 Tue, 19 Sep 2023 10:22:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFw2AfRoXE0NVplLSr16K2PAceWImHrYL5alcXYGmqjlTTXqscRyAi1nOf0dPmNqxYQFIBizw==
X-Received: by 2002:a05:6e02:20c2:b0:34f:cff6:5e2f with SMTP id
 2-20020a056e0220c200b0034fcff65e2fmr529481ilq.30.1695144153020; 
 Tue, 19 Sep 2023 10:22:33 -0700 (PDT)
Received: from redhat.com ([38.15.60.12]) by smtp.gmail.com with ESMTPSA id
 ga7-20020a0566381f0700b0043193e32c78sm3483137jab.152.2023.09.19.10.22.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 10:22:32 -0700 (PDT)
Date: Tue, 19 Sep 2023 11:22:30 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 clg@redhat.com, jean-philippe@linaro.org, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, peterx@redhat.com,
 david@redhat.com, philmd@linaro.org
Subject: Re: [PATCH v2 12/12] vfio: Remove 64-bit IOVA address space assumption
Message-ID: <20230919112230.5dfe14fa.alex.williamson@redhat.com>
In-Reply-To: <20230913080423.523953-13-eric.auger@redhat.com>
References: <20230913080423.523953-1-eric.auger@redhat.com>
 <20230913080423.523953-13-eric.auger@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, 13 Sep 2023 10:01:47 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> Now we retrieve the usable IOVA ranges from the host,
> we now the physical IOMMU aperture and we can remove
> the assumption of 64b IOVA space when calling
> vfio_host_win_add().
> 
> This works fine in general but in case of an IOMMU memory
> region this becomes more tricky. For instance the virtio-iommu
> MR has a 64b aperture by default. If the physical IOMMU has a
> smaller aperture (typically the case for VTD), this means we
> would need to resize the IOMMU MR when this latter is linked
> to a container. However this happens on vfio_listener_region_add()
> when calling the IOMMU MR set_iova_ranges() callback and this
> would mean we would have a recursive call the
> vfio_listener_region_add(). This looks like a wrong usage of
> the memory API causing duplicate IOMMU MR notifier registration
> for instance.
> 
> Until we find a better solution, make sure the vfio_find_hostwin()
> is not called anymore for IOMMU region.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> I have not found any working solution to the IOMMU MR resizing.
> So I can remove this patch or remove the check for IOMMU MR. Maybe
> this is an issue which can be handled separately?
> ---
>  hw/vfio/common.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 26da38de05..40cac1ca91 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1112,13 +1112,6 @@ static void vfio_listener_region_add(MemoryListener *listener,
>  #endif
>      }
>  
> -    hostwin = vfio_find_hostwin(container, iova, end);
> -    if (!hostwin) {
> -        error_setg(&err, "Container %p can't map guest IOVA region"
> -                   " 0x%"HWADDR_PRIx"..0x%"HWADDR_PRIx, container, iova, end);
> -        goto fail;
> -    }
> -
>      memory_region_ref(section->mr);
>  
>      if (memory_region_is_iommu(section->mr)) {
> @@ -1177,6 +1170,14 @@ static void vfio_listener_region_add(MemoryListener *listener,
>          return;
>      }
>  
> +    hostwin = vfio_find_hostwin(container, iova, end);
> +    if (!hostwin) {
> +        error_setg(&err, "Container %p can't map guest IOVA region"
> +                   " 0x%"HWADDR_PRIx"..0x%"HWADDR_PRIx, container, iova, end);
> +        goto fail;
> +    }
> +
> +
>      /* Here we assume that memory_region_is_ram(section->mr)==true */
>  
>      /*
> @@ -2594,12 +2595,10 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>          vfio_get_iommu_info_migration(container, info);
>          g_free(info);
>  
> -        /*
> -         * FIXME: We should parse VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE
> -         * information to get the actual window extent rather than assume
> -         * a 64-bit IOVA address space.
> -         */
> -        vfio_host_win_add(container, 0, (hwaddr)-1, container->pgsizes);
> +        g_assert(container->nr_iovas);

This assert is a problem for older kernels.

> +        vfio_host_win_add(container, 0,
> +                          container->iova_ranges[container->nr_iovas - 1].end,
> +                          container->pgsizes);

This doesn't address the assumption about the min_iova and adds an
assumption that the kernel provided list is sorted.  Thanks,

Alex


