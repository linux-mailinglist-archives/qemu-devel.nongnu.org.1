Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F888C63C4
	for <lists+qemu-devel@lfdr.de>; Wed, 15 May 2024 11:35:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7B1r-0000dS-L9; Wed, 15 May 2024 05:34:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1s7B1q-0000cl-Bh
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:34:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1s7B1o-0000JU-5L
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:34:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715765667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QT1Y3Dg5qprGhsoVjJqUpRXwWFOCdwyz/ZV3+vaHPqo=;
 b=aSgPRiE3kLURlrmzocwXAyLKgrQJQTqdQ10xuB5684mOnEWmjks7LCqKaSPrPchTSUYLvC
 ibVz0hrxG5QZSDAx6lc1GnmB5dVJn8TI6rWm4QHtcYPSK/pxEPHznoWC2Io/xu5nte9YS8
 14ABiJWxRxHZ+dB84fhOOqTEhkNQy7E=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-JjuLV6aPPju-OhGj9f3SDQ-1; Wed, 15 May 2024 05:34:25 -0400
X-MC-Unique: JjuLV6aPPju-OhGj9f3SDQ-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-792d2abbc65so508741585a.2
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 02:34:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715765665; x=1716370465;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QT1Y3Dg5qprGhsoVjJqUpRXwWFOCdwyz/ZV3+vaHPqo=;
 b=j+t8EjzgwN1Ea1aB6oHzSs6IEdzN+QoeQJ11QmpalY8teyWAPkgAK8g3IWeEbt9X7o
 WyVFtuqj9XNhAre9KUKrPE3OhfTtNDzw1Va0pVb+/J/12kWoZgrSsj+7DkRednRHWYtJ
 rWhiPePkf6G/qbKIQSuH7o2x1shYadvXBRDhLvA86JBRkCoAKh6FNsBD68kNb3UcqCTM
 3ENeoFCq4+zKwNvyqywzdO+JoJ6ydDXXTO+DT1EURr43HlUgu6Wyr9dlLgNCGUC0bijv
 1QDYmpBDhRp3cct2mwkqNTvOUL7PINqEDRVldv8Djh9dzf+tb3DYoHGki7TxQyzEOUuc
 7aKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcXO3mlohtlbF5sfDjNODnSXFDmTC4DyXiepBuZAxM6rWVa82/pIznP3olzq1EQX0hg/KAUPzeRwTgLAzV4lHS3sqHWJo=
X-Gm-Message-State: AOJu0YzzwovGumNTYoP/JRUuSYy5MOWNAldMpPABssqplIuWWqnqe5ZT
 gdK3cj/iPa9k8r7XDw394Pi3HxrDgyk+MCtyaM/EgRkUb2PjitNAtliiRQ5O90vroiTJCvHYXFZ
 kHv2/2wsloddNLYjz2/JSwCrlgMGBNSoFdRZYRf6gqeNIVeV+h4fe
X-Received: by 2002:a05:620a:e02:b0:792:9d4c:6436 with SMTP id
 af79cd13be357-792c75ffab9mr1644045485a.48.1715765665042; 
 Wed, 15 May 2024 02:34:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCEWaq6iP8i8V7aMA+nFdfC0PiiGCBpTxBjxh4FDp9uUp84+g0quwO7w1cq/VwP7kPbLWUZg==
X-Received: by 2002:a05:620a:e02:b0:792:9d4c:6436 with SMTP id
 af79cd13be357-792c75ffab9mr1644043585a.48.1715765664636; 
 Wed, 15 May 2024 02:34:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792bf2fca1dsm661770585a.92.2024.05.15.02.34.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 May 2024 02:34:23 -0700 (PDT)
Message-ID: <dc44fa98-dd80-4dd4-a8ad-9d359078ee4c@redhat.com>
Date: Wed, 15 May 2024 11:34:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 8/9] vfio: Add Error** argument to .get_dirty_bitmap()
 handler
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>
References: <20240514153130.394307-1-clg@redhat.com>
 <20240514153130.394307-9-clg@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20240514153130.394307-9-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
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



On 5/14/24 17:31, Cédric Le Goater wrote:
> Let the callers do the error reporting. Add documentation while at it.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
> 
>  Changes in v6:
> 
>  - Fixed the line wrapping (Avihai)
>  - Fixed query_dirty_bitmap documentation (Avihai)
>    
>  Changes in v5:
> 
>  - Replaced error_setg() by error_setg_errno() in
>    vfio_devices_query_dirty_bitmap() and vfio_legacy_query_dirty_bitmap()
>  - ':' -> '-' in vfio_iommu_map_dirty_notify()
>  
>  include/hw/vfio/vfio-common.h         |  4 +-
>  include/hw/vfio/vfio-container-base.h | 21 +++++++--
>  hw/vfio/common.c                      | 61 ++++++++++++++++++---------
>  hw/vfio/container-base.c              |  7 +--
>  hw/vfio/container.c                   | 14 +++---
>  5 files changed, 72 insertions(+), 35 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 46f88493634b5634a9c14a5caa33a463fbf2c50d..68911d36676667352e94a97895828aff4b194b57 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -274,9 +274,9 @@ bool
>  vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer);
>  int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>                                      VFIOBitmap *vbmap, hwaddr iova,
> -                                    hwaddr size);
> +                                    hwaddr size, Error **errp);
>  int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
> -                          uint64_t size, ram_addr_t ram_addr);
> +                          uint64_t size, ram_addr_t ram_addr, Error **errp);
>  
>  /* Returns 0 on success, or a negative errno. */
>  int vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index 326ceea52a2030eec9dad289a9845866c4a8c090..42cfbf32dc737606c3f620d126f35d85d4833534 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -84,8 +84,8 @@ void vfio_container_del_section_window(VFIOContainerBase *bcontainer,
>  int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
>                                             bool start, Error **errp);
>  int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
> -                                      VFIOBitmap *vbmap,
> -                                      hwaddr iova, hwaddr size);
> +                                      VFIOBitmap *vbmap, hwaddr iova,
> +                                      hwaddr size, Error **errp);
>  
>  void vfio_container_init(VFIOContainerBase *bcontainer,
>                           VFIOAddressSpace *space,
> @@ -138,9 +138,22 @@ struct VFIOIOMMUClass {
>       */
>      int (*set_dirty_page_tracking)(const VFIOContainerBase *bcontainer,
>                                     bool start, Error **errp);
> +    /**
> +     * @query_dirty_bitmap
> +     *
> +     * Get bitmap of dirty pages from container
> +     *
> +     * @bcontainer: #VFIOContainerBase from which to get dirty pages
> +     * @vbmap: #VFIOBitmap internal bitmap structure
> +     * @iova: iova base address
> +     * @size: size of iova range
> +     * @errp: pointer to Error*, to store an error if it happens.
> +     *
> +     * Returns zero to indicate success and negative for error
> +     */
>      int (*query_dirty_bitmap)(const VFIOContainerBase *bcontainer,
> -                              VFIOBitmap *vbmap,
> -                              hwaddr iova, hwaddr size);
> +                              VFIOBitmap *vbmap, hwaddr iova, hwaddr size,
> +                              Error **errp);
>      /* PCI specific */
>      int (*pci_hot_reset)(VFIODevice *vbasedev, bool single);
>  
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 919c4c52bc1590fd6c0bda37ba5881f58ff2ffff..9b5123d45fc1f9d5be4bbbf92898f89cd11e1363 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1140,8 +1140,8 @@ static int vfio_device_dma_logging_report(VFIODevice *vbasedev, hwaddr iova,
>  }
>  
>  int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
> -                                    VFIOBitmap *vbmap, hwaddr iova,
> -                                    hwaddr size)
> +                                    VFIOBitmap *vbmap, hwaddr iova, hwaddr size,
> +                                    Error **errp)
>  {
>      VFIODevice *vbasedev;
>      int ret;
> @@ -1150,10 +1150,10 @@ int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>          ret = vfio_device_dma_logging_report(vbasedev, iova, size,
>                                               vbmap->bitmap);
>          if (ret) {
> -            error_report("%s: Failed to get DMA logging report, iova: "
> -                         "0x%" HWADDR_PRIx ", size: 0x%" HWADDR_PRIx
> -                         ", err: %d (%s)",
> -                         vbasedev->name, iova, size, ret, strerror(-ret));
> +            error_setg_errno(errp, -ret,
> +                             "%s: Failed to get DMA logging report, iova: "
> +                             "0x%" HWADDR_PRIx ", size: 0x%" HWADDR_PRIx,
> +                             vbasedev->name, iova, size);
>  
>              return ret;
>          }
> @@ -1163,7 +1163,7 @@ int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>  }
>  
>  int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
> -                          uint64_t size, ram_addr_t ram_addr)
> +                          uint64_t size, ram_addr_t ram_addr, Error **errp)
>  {
>      bool all_device_dirty_tracking =
>          vfio_devices_all_device_dirty_tracking(bcontainer);
> @@ -1180,13 +1180,17 @@ int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
>  
>      ret = vfio_bitmap_alloc(&vbmap, size);
>      if (ret) {
> +        error_setg_errno(errp, -ret,
> +                         "Failed to allocate dirty tracking bitmap");
>          return ret;
>      }
>  
>      if (all_device_dirty_tracking) {
> -        ret = vfio_devices_query_dirty_bitmap(bcontainer, &vbmap, iova, size);
> +        ret = vfio_devices_query_dirty_bitmap(bcontainer, &vbmap, iova, size,
> +                                              errp);
>      } else {
> -        ret = vfio_container_query_dirty_bitmap(bcontainer, &vbmap, iova, size);
> +        ret = vfio_container_query_dirty_bitmap(bcontainer, &vbmap, iova, size,
> +                                                errp);
>      }
>  
>      if (ret) {
> @@ -1234,12 +1238,13 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>      }
>  
>      ret = vfio_get_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
> -                                translated_addr);
> +                                translated_addr, &local_err);
>      if (ret) {
> -        error_report("vfio_iommu_map_dirty_notify(%p, 0x%"HWADDR_PRIx", "
> -                     "0x%"HWADDR_PRIx") = %d (%s)",
> -                     bcontainer, iova, iotlb->addr_mask + 1, ret,
> -                     strerror(-ret));
> +        error_prepend(&local_err,
> +                      "vfio_iommu_map_dirty_notify(%p, 0x%"HWADDR_PRIx", "
> +                      "0x%"HWADDR_PRIx") failed - ", bcontainer, iova,
> +                      iotlb->addr_mask + 1);
> +        error_report_err(local_err);
>      }
>  
>  out_unlock:
> @@ -1259,12 +1264,19 @@ static int vfio_ram_discard_get_dirty_bitmap(MemoryRegionSection *section,
>      const ram_addr_t ram_addr = memory_region_get_ram_addr(section->mr) +
>                                  section->offset_within_region;
>      VFIORamDiscardListener *vrdl = opaque;
> +    Error *local_err = NULL;
> +    int ret;
>  
>      /*
>       * Sync the whole mapped region (spanning multiple individual mappings)
>       * in one go.
>       */
> -    return vfio_get_dirty_bitmap(vrdl->bcontainer, iova, size, ram_addr);
> +    ret = vfio_get_dirty_bitmap(vrdl->bcontainer, iova, size, ram_addr,
> +                                &local_err);
> +    if (ret) {
> +        error_report_err(local_err);
> +    }
> +    return ret;
>  }
>  
>  static int
> @@ -1296,7 +1308,7 @@ vfio_sync_ram_discard_listener_dirty_bitmap(VFIOContainerBase *bcontainer,
>  }
>  
>  static int vfio_sync_dirty_bitmap(VFIOContainerBase *bcontainer,
> -                                  MemoryRegionSection *section)
> +                                  MemoryRegionSection *section, Error **errp)
>  {
>      ram_addr_t ram_addr;
>  
> @@ -1327,7 +1339,14 @@ static int vfio_sync_dirty_bitmap(VFIOContainerBase *bcontainer,
>          }
>          return 0;
>      } else if (memory_region_has_ram_discard_manager(section->mr)) {
> -        return vfio_sync_ram_discard_listener_dirty_bitmap(bcontainer, section);
> +        int ret;
> +
> +        ret = vfio_sync_ram_discard_listener_dirty_bitmap(bcontainer, section);
> +        if (ret) {
> +            error_setg(errp,
> +                       "Failed to sync dirty bitmap with RAM discard listener");
> +            return ret;
> +        }
>      }
>  
>      ram_addr = memory_region_get_ram_addr(section->mr) +
> @@ -1335,7 +1354,7 @@ static int vfio_sync_dirty_bitmap(VFIOContainerBase *bcontainer,
>  
>      return vfio_get_dirty_bitmap(bcontainer,
>                     REAL_HOST_PAGE_ALIGN(section->offset_within_address_space),
> -                   int128_get64(section->size), ram_addr);
> +                                 int128_get64(section->size), ram_addr, errp);
>  }
>  
>  static void vfio_listener_log_sync(MemoryListener *listener,
> @@ -1344,16 +1363,16 @@ static void vfio_listener_log_sync(MemoryListener *listener,
>      VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
>                                                   listener);
>      int ret;
> +    Error *local_err = NULL;
>  
>      if (vfio_listener_skipped_section(section)) {
>          return;
>      }
>  
>      if (vfio_devices_all_dirty_tracking(bcontainer)) {
> -        ret = vfio_sync_dirty_bitmap(bcontainer, section);
> +        ret = vfio_sync_dirty_bitmap(bcontainer, section, &local_err);
>          if (ret) {
> -            error_report("vfio: Failed to sync dirty bitmap, err: %d (%s)", ret,
> -                         strerror(-ret));
> +            error_report_err(local_err);
>              vfio_set_migration_error(ret);
>          }
>      }
> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
> index 7c0764121d24b02b6c4e66e368d7dff78a6d65aa..4fa250c46fd16333d2e2358ede8b0a0afdb185b3 100644
> --- a/hw/vfio/container-base.c
> +++ b/hw/vfio/container-base.c
> @@ -64,11 +64,12 @@ int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
>  }
>  
>  int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
> -                                      VFIOBitmap *vbmap,
> -                                      hwaddr iova, hwaddr size)
> +                                      VFIOBitmap *vbmap, hwaddr iova,
> +                                      hwaddr size, Error **errp)
>  {
>      g_assert(bcontainer->ops->query_dirty_bitmap);
> -    return bcontainer->ops->query_dirty_bitmap(bcontainer, vbmap, iova, size);
> +    return bcontainer->ops->query_dirty_bitmap(bcontainer, vbmap, iova, size,
> +                                               errp);
>  }
>  
>  void vfio_container_init(VFIOContainerBase *bcontainer, VFIOAddressSpace *space,
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index c35221fbe7dc5453050f97cd186fc958e24f28f7..e00db6546c652c61a352f8e4cd65b212ecfb65bc 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -130,6 +130,7 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
>      };
>      bool need_dirty_sync = false;
>      int ret;
> +    Error *local_err = NULL;
>  
>      if (iotlb && vfio_devices_all_running_and_mig_active(bcontainer)) {
>          if (!vfio_devices_all_device_dirty_tracking(bcontainer) &&
> @@ -165,8 +166,9 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
>  
>      if (need_dirty_sync) {
>          ret = vfio_get_dirty_bitmap(bcontainer, iova, size,
> -                                    iotlb->translated_addr);
> +                                    iotlb->translated_addr, &local_err);
>          if (ret) {
> +            error_report_err(local_err);
>              return ret;
>          }
>      }
> @@ -236,7 +238,8 @@ vfio_legacy_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
>  
>  static int vfio_legacy_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>                                            VFIOBitmap *vbmap,
> -                                          hwaddr iova, hwaddr size)
> +                                          hwaddr iova, hwaddr size,
> +                                          Error **errp)
>  {
>      const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
>                                                    bcontainer);
> @@ -264,9 +267,10 @@ static int vfio_legacy_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>      ret = ioctl(container->fd, VFIO_IOMMU_DIRTY_PAGES, dbitmap);
>      if (ret) {
>          ret = -errno;
> -        error_report("Failed to get dirty bitmap for iova: 0x%"PRIx64
> -                " size: 0x%"PRIx64" err: %d", (uint64_t)range->iova,
> -                (uint64_t)range->size, errno);
> +        error_setg_errno(errp, errno,
> +                         "Failed to get dirty bitmap for iova: 0x%"PRIx64
> +                         " size: 0x%"PRIx64, (uint64_t)range->iova,
> +                         (uint64_t)range->size);
>      }
>  
>      g_free(dbitmap);

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric


