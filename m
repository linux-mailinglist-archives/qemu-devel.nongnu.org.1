Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0168E7CEA2D
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 23:44:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtEJd-0006f8-Li; Wed, 18 Oct 2023 17:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qtEJT-0006eR-20
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:42:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qtEJO-0002aZ-8C
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:42:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697665359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pPNyo+sNwDLjQJ9EYoQBCZNJN9e5djdUk0VrpcCHbQ4=;
 b=Wumep7dunMnupmmjtDQSkS2pwnwH/5z9G+Up6LKhVybgkhs8p2NouSHobuEi5JJS4k6lC5
 7Z07RnCQkptqTyojUbCAR4bE+wiv/3l5xDsI7AWwJ46e6vAfB3EUdrUmRE9d/+Mg80+zUr
 fv1sGfoejNj1t8UysMX7kUar9VbS9fY=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-QLjxMu4YNOWJDpKWpelPIw-1; Wed, 18 Oct 2023 17:42:38 -0400
X-MC-Unique: QLjxMu4YNOWJDpKWpelPIw-1
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-794c9992f15so10354439f.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:42:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697665357; x=1698270157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pPNyo+sNwDLjQJ9EYoQBCZNJN9e5djdUk0VrpcCHbQ4=;
 b=jvu1E8cB0MQKvUR4PHUEoPZU5QH5eHzXwOL51dSfAwZtbIPDnmX8YKqQTugdRO5Uud
 aF61wCN02MJr6OE6nr6iCvOOgNFVr61OLbD99fUHWuGwA4ELPHCtR6dplLXr4uZLhuk7
 LNlUwNRYr87LC6qHMEXx4pZvuq7kW+crGygYlY8Fr7edkx62acSioYspRTWcTe6MCMhS
 MKOBfOw5zqJZkYGXFyONJ828sZlb8dM9paSa9KZ5aFGuqoyIUiuVE5awHztEtavRUJD3
 FDWAMDyKWzP4minOEwdMnCyOFZ7F5e++1/VuzVxPJC19DkF4ulesNZz9lFB66VidU48W
 pAXQ==
X-Gm-Message-State: AOJu0YyJTtd1C0/dR6oVAP8QTDg9+KDoasAA/o5eUBTCEIHhTy4Ma6JI
 bRVajfDRkuSlnUI3ug4ANVhmdI9AsjDzioG8WyIuVwGNStXHdQ6mG7pNzT/WEtZPS9ap94lfyWa
 +xwIVwK/J+wRbWk0=
X-Received: by 2002:a05:6602:585:b0:79d:27ef:23c3 with SMTP id
 v5-20020a056602058500b0079d27ef23c3mr45539iox.5.1697665357642; 
 Wed, 18 Oct 2023 14:42:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgn9GIBvvKAnH7blaNobxSqFry+4XRY6X6hmqsDowlPeKCFNGeVNs4hutWPwuUIrEhSd24fw==
X-Received: by 2002:a05:6602:585:b0:79d:27ef:23c3 with SMTP id
 v5-20020a056602058500b0079d27ef23c3mr45524iox.5.1697665357348; 
 Wed, 18 Oct 2023 14:42:37 -0700 (PDT)
Received: from redhat.com ([38.15.60.12]) by smtp.gmail.com with ESMTPSA id
 b25-20020a02c999000000b0042bb6431487sm1493101jap.65.2023.10.18.14.42.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:42:36 -0700 (PDT)
Date: Wed, 18 Oct 2023 15:42:34 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 clg@redhat.com, jean-philippe@linaro.org, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, peterx@redhat.com,
 david@redhat.com, philmd@linaro.org, zhenzhong.duan@intel.com,
 yi.l.liu@intel.com
Subject: Re: [PATCH v3 13/13] vfio: Remove 64-bit IOVA address space assumption
Message-ID: <20231018154234.4c47801d.alex.williamson@redhat.com>
In-Reply-To: <20231011175516.541374-14-eric.auger@redhat.com>
References: <20231011175516.541374-1-eric.auger@redhat.com>
 <20231011175516.541374-14-eric.auger@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
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

On Wed, 11 Oct 2023 19:52:29 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> Now we retrieve the usable IOVA ranges from the host,
> we now the physical IOMMU aperture and we can remove

s/now/use/?

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
> he memory API causing duplicate IOMMU MR notifier registration

s/he/the/

> for instance.
> 
> Until we find a better solution, make sure the vfio_find_hostwin()
> is not called anymore for IOMMU region.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> v2 -> v3:
> - take into account the avail IOVA range may not be existing
> - Create as many VFIOHostDMAWindow as valid IOVA ranges
> - rebase on top of vfio-next
> 
> I have not found any working solution to the IOMMU MR resizing.
> So I can remove this patch or remove the check for IOMMU MR. Maybe
> this is an issue which can be handled separately?

Am I correct that the only thing we're solving here is the FIXME?

Without this change we assume a 64-bit IOVA address space for the
"hostwin" and the previous patch 03/ already sets the usable IOVA range
for the IOMMU aperture.  Kernel code will error on mappings outside of
the usable IOVA ranges regardless, so at best we're making the failure
occur earlier in QEMU rather than at the time of the DMA mapping.

I think the FIXME comment had assumed the hostwin support would be more
universal, but perhaps we're just doubling down on a relic of SPAPR
support that we can safely ignore, and at some point remove.  It really
seems to serve the same purpose as the new iova_ranges and if it were
worthwhile to fail the range in QEMU before trying to map it in the
kernel, we could test it against iova_ranges directly.

Unless this serves some purpose that I'm not spotting, maybe we should
drop this patch, consider hostwin to be SPAPR specific, and avoid
further entanglements with it here so that it can be more easily
removed.  Thanks,

Alex

> ---
>  hw/vfio/common.c    | 14 +++++++-------
>  hw/vfio/container.c | 23 +++++++++++++++++------
>  2 files changed, 24 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 9d804152ba..1447b6fdc4 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -654,13 +654,6 @@ static void vfio_listener_region_add(MemoryListener *listener,
>          goto fail;
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
> @@ -720,6 +713,13 @@ static void vfio_listener_region_add(MemoryListener *listener,
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
>      /* Here we assume that memory_region_is_ram(section->mr)==true */
>  
>      /*
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 5122ff6d92..eb9d962881 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -693,12 +693,23 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>          vfio_get_iommu_info_migration(container, info);
>          g_free(info);
>  
> -        /*
> -         * FIXME: We should parse VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE
> -         * information to get the actual window extent rather than assume
> -         * a 64-bit IOVA address space.
> -         */
> -        vfio_host_win_add(container, 0, (hwaddr)-1, container->pgsizes);
> +        if (container->nr_iovas == -1) {
> +            /*
> +             * no available info on usable IOVA ranges,
> +             * assume 64b IOVA space
> +             */
> +            vfio_host_win_add(container, 0, (hwaddr)-1, container->pgsizes);
> +        } else {
> +            GList *l;
> +
> +            g_assert(container->nr_iovas);
> +            for (l = container->iova_ranges; l; l = l->next) {
> +                Range *r = l->data;
> +
> +                vfio_host_win_add(container, range_lob(r), range_upb(r),
> +                                  container->pgsizes);
> +            }
> +        }
>  
>          break;
>      }


