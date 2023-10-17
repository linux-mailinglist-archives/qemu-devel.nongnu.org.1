Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDCD7CC803
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 17:51:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsmLQ-0004zA-9z; Tue, 17 Oct 2023 11:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qsmLN-0004yW-SO
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 11:50:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qsmLL-0003jR-5j
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 11:50:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697557850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sLBtG9mKMGWD53qZ0hBk91p+ICFkgN+IHW/ozq7ipaU=;
 b=gE4lJ3hqwi2APcm+g78+e4TCtoHASpO9V0y0P2qk25whF6jKX6+pcd2SqcJ+3mX5nEhu7J
 BdQGgh4v7moqWHSDOAgN1Dl+xJ9/Nmfu4WCc3xS2FOb/WzZ9iSSMya//g+rUM11XmbO9xA
 Nhb8Wma2opE2y1YcbuDEwrzrO4PqjkU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-8jxmt40EMO6t-65gCiUo9w-1; Tue, 17 Oct 2023 11:50:38 -0400
X-MC-Unique: 8jxmt40EMO6t-65gCiUo9w-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7740c3506b9so738861185a.0
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 08:50:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697557838; x=1698162638;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sLBtG9mKMGWD53qZ0hBk91p+ICFkgN+IHW/ozq7ipaU=;
 b=S65JpcTegbWQJlwj7E2Trynd6yVJMT9GEDvkOlUuw/+jdXWl3TxyanRKgKEnH5l/hW
 cFXqKPputBeY1BaNil3WkdE4AV0dujIjtk++A2GDkWIPpIkqkjvCijB/aZATbgHFWcjV
 Rwu0RJcE0Rr2f/SBwRzGqodqItw9lmkiegd5JZ0PNshNwwgpMp9bmTBK1iwIfHsz1nx9
 +66mv5M9aKBxooEUIPqjZbxfD8axssBiBcKIma6rYIqTI81HXJLyWBsBIEG/G4MQ17CS
 i/joEbP0Zms3fp+H9tjM3XBGn7/dfoM6t1PndIb+yimoTw/6+Eow+aa9jC9NXbzkw3+R
 6IOg==
X-Gm-Message-State: AOJu0YxN9b1E4Sf/sWPIvqgr2p7r9ek6fIBVQJcBPf8pHf7ORAaAf+z1
 Yw1gnz4pd20rR6FOZdm43ztsfcmZXFCNNFe3O/p/ApO5NBVAnkkBw5U+/v3KoXf4oxz/8GeKNO9
 VHlK0asSXOw03a/Q=
X-Received: by 2002:a05:620a:2983:b0:774:193c:94bd with SMTP id
 r3-20020a05620a298300b00774193c94bdmr3173144qkp.4.1697557837985; 
 Tue, 17 Oct 2023 08:50:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/mwS1xlgwDXmcpmlxkr1ekSEqp9jpkVP/aQ3bMoo66i5ZnbS+Z5NVSaxFfnsY+XLPBEGIdg==
X-Received: by 2002:a05:620a:2983:b0:774:193c:94bd with SMTP id
 r3-20020a05620a298300b00774193c94bdmr3173115qkp.4.1697557837578; 
 Tue, 17 Oct 2023 08:50:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 9-20020a05620a04c900b0077263636a95sm758843qks.93.2023.10.17.08.50.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Oct 2023 08:50:37 -0700 (PDT)
Message-ID: <1b073713-a154-4ca3-b1eb-4f1b1b21bc28@redhat.com>
Date: Tue, 17 Oct 2023 17:50:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/27] vfio: Rename VFIOContainer into
 VFIOLegacyContainer
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com, Yi Sun
 <yi.y.sun@linux.intel.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "open list:sPAPR (pseries)" <qemu-ppc@nongnu.org>
References: <20231016083223.1519410-1-zhenzhong.duan@intel.com>
 <20231016083223.1519410-2-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231016083223.1519410-2-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hello,

On 10/16/23 10:31, Zhenzhong Duan wrote:
> From: Eric Auger <eric.auger@redhat.com>
> 
> In the prospect to introduce a base object for the VFIOContainer
> and derive into the existing legacy container and the iommufd
> based container, let's rename the existing one into
> VFIOLegacyContainer. This is just an incremental step to ease
> the migration. Soon there won't be any reference to the legacy
> container in the common.c code. Only the container.c should
> handle the VFIOLegacyContainer object.

So I think I would have kept the current name as it is, named the
new abtract QOM object VFIOContainerBase and then, derived from
VFIOContainerBase, the current implementation VFIOContainer and
the new one VFIOContainerIOMMUFD.

I just starting the review, don't mind too much my comments until
PATCH 1-15 are covered.

Thanks,

C.


> 
> No functional change intended.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/hw/vfio/vfio-common.h | 46 ++++++++++++-------------
>   hw/vfio/common.c              | 63 ++++++++++++++++++++---------------
>   hw/vfio/container.c           | 45 +++++++++++++------------
>   hw/vfio/spapr.c               | 12 +++----
>   4 files changed, 89 insertions(+), 77 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 7780b9073a..34648e518e 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -74,13 +74,13 @@ typedef struct VFIOMigration {
>   
>   typedef struct VFIOAddressSpace {
>       AddressSpace *as;
> -    QLIST_HEAD(, VFIOContainer) containers;
> +    QLIST_HEAD(, VFIOLegacyContainer) containers;
>       QLIST_ENTRY(VFIOAddressSpace) list;
>   } VFIOAddressSpace;
>   
>   struct VFIOGroup;
>   
> -typedef struct VFIOContainer {
> +typedef struct VFIOLegacyContainer {
>       VFIOAddressSpace *space;
>       int fd; /* /dev/vfio/vfio, empowered by the attached groups */
>       MemoryListener listener;
> @@ -97,12 +97,12 @@ typedef struct VFIOContainer {
>       QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
>       QLIST_HEAD(, VFIOGroup) group_list;
>       QLIST_HEAD(, VFIORamDiscardListener) vrdl_list;
> -    QLIST_ENTRY(VFIOContainer) next;
> +    QLIST_ENTRY(VFIOLegacyContainer) next;
>       QLIST_HEAD(, VFIODevice) device_list;
> -} VFIOContainer;
> +} VFIOLegacyContainer;
>   
>   typedef struct VFIOGuestIOMMU {
> -    VFIOContainer *container;
> +    VFIOLegacyContainer *container;
>       IOMMUMemoryRegion *iommu_mr;
>       hwaddr iommu_offset;
>       IOMMUNotifier n;
> @@ -110,7 +110,7 @@ typedef struct VFIOGuestIOMMU {
>   } VFIOGuestIOMMU;
>   
>   typedef struct VFIORamDiscardListener {
> -    VFIOContainer *container;
> +    VFIOLegacyContainer *container;
>       MemoryRegion *mr;
>       hwaddr offset_within_address_space;
>       hwaddr size;
> @@ -133,7 +133,7 @@ typedef struct VFIODevice {
>       QLIST_ENTRY(VFIODevice) container_next;
>       QLIST_ENTRY(VFIODevice) global_next;
>       struct VFIOGroup *group;
> -    VFIOContainer *container;
> +    VFIOLegacyContainer *container;
>       char *sysfsdev;
>       char *name;
>       DeviceState *dev;
> @@ -167,7 +167,7 @@ struct VFIODeviceOps {
>   typedef struct VFIOGroup {
>       int fd;
>       int groupid;
> -    VFIOContainer *container;
> +    VFIOLegacyContainer *container;
>       QLIST_HEAD(, VFIODevice) device_list;
>       QLIST_ENTRY(VFIOGroup) next;
>       QLIST_ENTRY(VFIOGroup) container_next;
> @@ -206,28 +206,28 @@ typedef struct {
>       hwaddr pages;
>   } VFIOBitmap;
>   
> -void vfio_host_win_add(VFIOContainer *container,
> +void vfio_host_win_add(VFIOLegacyContainer *container,
>                          hwaddr min_iova, hwaddr max_iova,
>                          uint64_t iova_pgsizes);
> -int vfio_host_win_del(VFIOContainer *container, hwaddr min_iova,
> +int vfio_host_win_del(VFIOLegacyContainer *container, hwaddr min_iova,
>                         hwaddr max_iova);
>   VFIOAddressSpace *vfio_get_address_space(AddressSpace *as);
>   void vfio_put_address_space(VFIOAddressSpace *space);
> -bool vfio_devices_all_running_and_saving(VFIOContainer *container);
> +bool vfio_devices_all_running_and_saving(VFIOLegacyContainer *container);
>   
>   /* container->fd */
> -int vfio_dma_unmap(VFIOContainer *container, hwaddr iova,
> +int vfio_dma_unmap(VFIOLegacyContainer *container, hwaddr iova,
>                      ram_addr_t size, IOMMUTLBEntry *iotlb);
> -int vfio_dma_map(VFIOContainer *container, hwaddr iova,
> +int vfio_dma_map(VFIOLegacyContainer *container, hwaddr iova,
>                    ram_addr_t size, void *vaddr, bool readonly);
> -int vfio_set_dirty_page_tracking(VFIOContainer *container, bool start);
> -int vfio_query_dirty_bitmap(VFIOContainer *container, VFIOBitmap *vbmap,
> +int vfio_set_dirty_page_tracking(VFIOLegacyContainer *container, bool start);
> +int vfio_query_dirty_bitmap(VFIOLegacyContainer *container, VFIOBitmap *vbmap,
>                               hwaddr iova, hwaddr size);
>   
> -int vfio_container_add_section_window(VFIOContainer *container,
> +int vfio_container_add_section_window(VFIOLegacyContainer *container,
>                                         MemoryRegionSection *section,
>                                         Error **errp);
> -void vfio_container_del_section_window(VFIOContainer *container,
> +void vfio_container_del_section_window(VFIOLegacyContainer *container,
>                                          MemoryRegionSection *section);
>   
>   void vfio_disable_irqindex(VFIODevice *vbasedev, int index);
> @@ -290,21 +290,21 @@ vfio_get_cap(void *ptr, uint32_t cap_offset, uint16_t id);
>   #endif
>   extern const MemoryListener vfio_prereg_listener;
>   
> -int vfio_spapr_create_window(VFIOContainer *container,
> +int vfio_spapr_create_window(VFIOLegacyContainer *container,
>                                MemoryRegionSection *section,
>                                hwaddr *pgsize);
> -int vfio_spapr_remove_window(VFIOContainer *container,
> +int vfio_spapr_remove_window(VFIOLegacyContainer *container,
>                                hwaddr offset_within_address_space);
>   
>   bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
>   void vfio_migration_exit(VFIODevice *vbasedev);
>   
>   int vfio_bitmap_alloc(VFIOBitmap *vbmap, hwaddr size);
> -bool vfio_devices_all_running_and_mig_active(VFIOContainer *container);
> -bool vfio_devices_all_device_dirty_tracking(VFIOContainer *container);
> -int vfio_devices_query_dirty_bitmap(VFIOContainer *container,
> +bool vfio_devices_all_running_and_mig_active(VFIOLegacyContainer *container);
> +bool vfio_devices_all_device_dirty_tracking(VFIOLegacyContainer *container);
> +int vfio_devices_query_dirty_bitmap(VFIOLegacyContainer *container,
>                                       VFIOBitmap *vbmap, hwaddr iova,
>                                       hwaddr size);
> -int vfio_get_dirty_bitmap(VFIOContainer *container, uint64_t iova,
> +int vfio_get_dirty_bitmap(VFIOLegacyContainer *container, uint64_t iova,
>                                    uint64_t size, ram_addr_t ram_addr);
>   #endif /* HW_VFIO_VFIO_COMMON_H */
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 5ff5acf1d8..b51ef3a15a 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -184,7 +184,7 @@ bool vfio_device_state_is_precopy(VFIODevice *vbasedev)
>              migration->device_state == VFIO_DEVICE_STATE_PRE_COPY_P2P;
>   }
>   
> -static bool vfio_devices_all_dirty_tracking(VFIOContainer *container)
> +static bool vfio_devices_all_dirty_tracking(VFIOLegacyContainer *container)
>   {
>       VFIODevice *vbasedev;
>       MigrationState *ms = migrate_get_current();
> @@ -210,7 +210,7 @@ static bool vfio_devices_all_dirty_tracking(VFIOContainer *container)
>       return true;
>   }
>   
> -bool vfio_devices_all_device_dirty_tracking(VFIOContainer *container)
> +bool vfio_devices_all_device_dirty_tracking(VFIOLegacyContainer *container)
>   {
>       VFIODevice *vbasedev;
>   
> @@ -227,7 +227,7 @@ bool vfio_devices_all_device_dirty_tracking(VFIOContainer *container)
>    * Check if all VFIO devices are running and migration is active, which is
>    * essentially equivalent to the migration being in pre-copy phase.
>    */
> -bool vfio_devices_all_running_and_mig_active(VFIOContainer *container)
> +bool vfio_devices_all_running_and_mig_active(VFIOLegacyContainer *container)
>   {
>       VFIODevice *vbasedev;
>   
> @@ -252,7 +252,7 @@ bool vfio_devices_all_running_and_mig_active(VFIOContainer *container)
>       return true;
>   }
>   
> -void vfio_host_win_add(VFIOContainer *container, hwaddr min_iova,
> +void vfio_host_win_add(VFIOLegacyContainer *container, hwaddr min_iova,
>                          hwaddr max_iova, uint64_t iova_pgsizes)
>   {
>       VFIOHostDMAWindow *hostwin;
> @@ -274,7 +274,7 @@ void vfio_host_win_add(VFIOContainer *container, hwaddr min_iova,
>       QLIST_INSERT_HEAD(&container->hostwin_list, hostwin, hostwin_next);
>   }
>   
> -int vfio_host_win_del(VFIOContainer *container,
> +int vfio_host_win_del(VFIOLegacyContainer *container,
>                         hwaddr min_iova, hwaddr max_iova)
>   {
>       VFIOHostDMAWindow *hostwin;
> @@ -337,7 +337,7 @@ static bool vfio_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>   static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>   {
>       VFIOGuestIOMMU *giommu = container_of(n, VFIOGuestIOMMU, n);
> -    VFIOContainer *container = giommu->container;
> +    VFIOLegacyContainer *container = giommu->container;
>       hwaddr iova = iotlb->iova + giommu->iommu_offset;
>       void *vaddr;
>       int ret;
> @@ -441,7 +441,7 @@ static int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
>       return 0;
>   }
>   
> -static void vfio_register_ram_discard_listener(VFIOContainer *container,
> +static void vfio_register_ram_discard_listener(VFIOLegacyContainer *container,
>                                                  MemoryRegionSection *section)
>   {
>       RamDiscardManager *rdm = memory_region_get_ram_discard_manager(section->mr);
> @@ -515,7 +515,7 @@ static void vfio_register_ram_discard_listener(VFIOContainer *container,
>       }
>   }
>   
> -static void vfio_unregister_ram_discard_listener(VFIOContainer *container,
> +static void vfio_unregister_ram_discard_listener(VFIOLegacyContainer *container,
>                                                    MemoryRegionSection *section)
>   {
>       RamDiscardManager *rdm = memory_region_get_ram_discard_manager(section->mr);
> @@ -538,7 +538,7 @@ static void vfio_unregister_ram_discard_listener(VFIOContainer *container,
>       g_free(vrdl);
>   }
>   
> -static VFIOHostDMAWindow *vfio_find_hostwin(VFIOContainer *container,
> +static VFIOHostDMAWindow *vfio_find_hostwin(VFIOLegacyContainer *container,
>                                               hwaddr iova, hwaddr end)
>   {
>       VFIOHostDMAWindow *hostwin;
> @@ -599,7 +599,7 @@ static bool vfio_listener_valid_section(MemoryRegionSection *section,
>       return true;
>   }
>   
> -static bool vfio_get_section_iova_range(VFIOContainer *container,
> +static bool vfio_get_section_iova_range(VFIOLegacyContainer *container,
>                                           MemoryRegionSection *section,
>                                           hwaddr *out_iova, hwaddr *out_end,
>                                           Int128 *out_llend)
> @@ -627,7 +627,9 @@ static bool vfio_get_section_iova_range(VFIOContainer *container,
>   static void vfio_listener_region_add(MemoryListener *listener,
>                                        MemoryRegionSection *section)
>   {
> -    VFIOContainer *container = container_of(listener, VFIOContainer, listener);
> +    VFIOLegacyContainer *container = container_of(listener,
> +                                                  VFIOLegacyContainer,
> +                                                  listener);
>       hwaddr iova, end;
>       Int128 llend, llsize;
>       void *vaddr;
> @@ -788,7 +790,9 @@ fail:
>   static void vfio_listener_region_del(MemoryListener *listener,
>                                        MemoryRegionSection *section)
>   {
> -    VFIOContainer *container = container_of(listener, VFIOContainer, listener);
> +    VFIOLegacyContainer *container = container_of(listener,
> +                                                  VFIOLegacyContainer,
> +                                                  listener);
>       hwaddr iova, end;
>       Int128 llend, llsize;
>       int ret;
> @@ -881,13 +885,13 @@ typedef struct VFIODirtyRanges {
>   } VFIODirtyRanges;
>   
>   typedef struct VFIODirtyRangesListener {
> -    VFIOContainer *container;
> +    VFIOLegacyContainer *container;
>       VFIODirtyRanges ranges;
>       MemoryListener listener;
>   } VFIODirtyRangesListener;
>   
>   static bool vfio_section_is_vfio_pci(MemoryRegionSection *section,
> -                                     VFIOContainer *container)
> +                                     VFIOLegacyContainer *container)
>   {
>       VFIOPCIDevice *pcidev;
>       VFIODevice *vbasedev;
> @@ -966,7 +970,7 @@ static const MemoryListener vfio_dirty_tracking_listener = {
>       .region_add = vfio_dirty_tracking_update,
>   };
>   
> -static void vfio_dirty_tracking_init(VFIOContainer *container,
> +static void vfio_dirty_tracking_init(VFIOLegacyContainer *container,
>                                        VFIODirtyRanges *ranges)
>   {
>       VFIODirtyRangesListener dirty;
> @@ -991,7 +995,7 @@ static void vfio_dirty_tracking_init(VFIOContainer *container,
>       memory_listener_unregister(&dirty.listener);
>   }
>   
> -static void vfio_devices_dma_logging_stop(VFIOContainer *container)
> +static void vfio_devices_dma_logging_stop(VFIOLegacyContainer *container)
>   {
>       uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature),
>                                 sizeof(uint64_t))] = {};
> @@ -1016,7 +1020,7 @@ static void vfio_devices_dma_logging_stop(VFIOContainer *container)
>   }
>   
>   static struct vfio_device_feature *
> -vfio_device_feature_dma_logging_start_create(VFIOContainer *container,
> +vfio_device_feature_dma_logging_start_create(VFIOLegacyContainer *container,
>                                                VFIODirtyRanges *tracking)
>   {
>       struct vfio_device_feature *feature;
> @@ -1089,7 +1093,7 @@ static void vfio_device_feature_dma_logging_start_destroy(
>       g_free(feature);
>   }
>   
> -static int vfio_devices_dma_logging_start(VFIOContainer *container)
> +static int vfio_devices_dma_logging_start(VFIOLegacyContainer *container)
>   {
>       struct vfio_device_feature *feature;
>       VFIODirtyRanges ranges;
> @@ -1130,7 +1134,9 @@ out:
>   
>   static void vfio_listener_log_global_start(MemoryListener *listener)
>   {
> -    VFIOContainer *container = container_of(listener, VFIOContainer, listener);
> +    VFIOLegacyContainer *container = container_of(listener,
> +                                                  VFIOLegacyContainer,
> +                                                  listener);
>       int ret;
>   
>       if (vfio_devices_all_device_dirty_tracking(container)) {
> @@ -1148,7 +1154,9 @@ static void vfio_listener_log_global_start(MemoryListener *listener)
>   
>   static void vfio_listener_log_global_stop(MemoryListener *listener)
>   {
> -    VFIOContainer *container = container_of(listener, VFIOContainer, listener);
> +    VFIOLegacyContainer *container = container_of(listener,
> +                                                  VFIOLegacyContainer,
> +                                                  listener);
>       int ret = 0;
>   
>       if (vfio_devices_all_device_dirty_tracking(container)) {
> @@ -1190,7 +1198,7 @@ static int vfio_device_dma_logging_report(VFIODevice *vbasedev, hwaddr iova,
>       return 0;
>   }
>   
> -int vfio_devices_query_dirty_bitmap(VFIOContainer *container,
> +int vfio_devices_query_dirty_bitmap(VFIOLegacyContainer *container,
>                                       VFIOBitmap *vbmap, hwaddr iova,
>                                       hwaddr size)
>   {
> @@ -1213,7 +1221,7 @@ int vfio_devices_query_dirty_bitmap(VFIOContainer *container,
>       return 0;
>   }
>   
> -int vfio_get_dirty_bitmap(VFIOContainer *container, uint64_t iova,
> +int vfio_get_dirty_bitmap(VFIOLegacyContainer *container, uint64_t iova,
>                             uint64_t size, ram_addr_t ram_addr)
>   {
>       bool all_device_dirty_tracking =
> @@ -1265,7 +1273,7 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>       vfio_giommu_dirty_notifier *gdn = container_of(n,
>                                                   vfio_giommu_dirty_notifier, n);
>       VFIOGuestIOMMU *giommu = gdn->giommu;
> -    VFIOContainer *container = giommu->container;
> +    VFIOLegacyContainer *container = giommu->container;
>       hwaddr iova = iotlb->iova + giommu->iommu_offset;
>       ram_addr_t translated_addr;
>       int ret = -EINVAL;
> @@ -1313,7 +1321,8 @@ static int vfio_ram_discard_get_dirty_bitmap(MemoryRegionSection *section,
>       return vfio_get_dirty_bitmap(vrdl->container, iova, size, ram_addr);
>   }
>   
> -static int vfio_sync_ram_discard_listener_dirty_bitmap(VFIOContainer *container,
> +static int
> +vfio_sync_ram_discard_listener_dirty_bitmap(VFIOLegacyContainer *container,
>                                                      MemoryRegionSection *section)
>   {
>       RamDiscardManager *rdm = memory_region_get_ram_discard_manager(section->mr);
> @@ -1340,7 +1349,7 @@ static int vfio_sync_ram_discard_listener_dirty_bitmap(VFIOContainer *container,
>                                                   &vrdl);
>   }
>   
> -static int vfio_sync_dirty_bitmap(VFIOContainer *container,
> +static int vfio_sync_dirty_bitmap(VFIOLegacyContainer *container,
>                                     MemoryRegionSection *section)
>   {
>       ram_addr_t ram_addr;
> @@ -1386,7 +1395,9 @@ static int vfio_sync_dirty_bitmap(VFIOContainer *container,
>   static void vfio_listener_log_sync(MemoryListener *listener,
>           MemoryRegionSection *section)
>   {
> -    VFIOContainer *container = container_of(listener, VFIOContainer, listener);
> +    VFIOLegacyContainer *container = container_of(listener,
> +                                                  VFIOLegacyContainer,
> +                                                  listener);
>       int ret;
>   
>       if (vfio_listener_skipped_section(section)) {
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index adc467210f..8fde302ae9 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -42,7 +42,8 @@
>   VFIOGroupList vfio_group_list =
>       QLIST_HEAD_INITIALIZER(vfio_group_list);
>   
> -static int vfio_ram_block_discard_disable(VFIOContainer *container, bool state)
> +static int vfio_ram_block_discard_disable(VFIOLegacyContainer *container,
> +                                          bool state)
>   {
>       switch (container->iommu_type) {
>       case VFIO_TYPE1v2_IOMMU:
> @@ -65,7 +66,7 @@ static int vfio_ram_block_discard_disable(VFIOContainer *container, bool state)
>       }
>   }
>   
> -static int vfio_dma_unmap_bitmap(VFIOContainer *container,
> +static int vfio_dma_unmap_bitmap(VFIOLegacyContainer *container,
>                                    hwaddr iova, ram_addr_t size,
>                                    IOMMUTLBEntry *iotlb)
>   {
> @@ -120,7 +121,7 @@ unmap_exit:
>   /*
>    * DMA - Mapping and unmapping for the "type1" IOMMU interface used on x86
>    */
> -int vfio_dma_unmap(VFIOContainer *container, hwaddr iova,
> +int vfio_dma_unmap(VFIOLegacyContainer *container, hwaddr iova,
>                      ram_addr_t size, IOMMUTLBEntry *iotlb)
>   {
>       struct vfio_iommu_type1_dma_unmap unmap = {
> @@ -175,7 +176,7 @@ int vfio_dma_unmap(VFIOContainer *container, hwaddr iova,
>       return 0;
>   }
>   
> -int vfio_dma_map(VFIOContainer *container, hwaddr iova,
> +int vfio_dma_map(VFIOLegacyContainer *container, hwaddr iova,
>                    ram_addr_t size, void *vaddr, bool readonly)
>   {
>       struct vfio_iommu_type1_dma_map map = {
> @@ -205,7 +206,7 @@ int vfio_dma_map(VFIOContainer *container, hwaddr iova,
>       return -errno;
>   }
>   
> -int vfio_container_add_section_window(VFIOContainer *container,
> +int vfio_container_add_section_window(VFIOLegacyContainer *container,
>                                         MemoryRegionSection *section,
>                                         Error **errp)
>   {
> @@ -273,7 +274,7 @@ int vfio_container_add_section_window(VFIOContainer *container,
>       return 0;
>   }
>   
> -void vfio_container_del_section_window(VFIOContainer *container,
> +void vfio_container_del_section_window(VFIOLegacyContainer *container,
>                                          MemoryRegionSection *section)
>   {
>       if (container->iommu_type != VFIO_SPAPR_TCE_v2_IOMMU) {
> @@ -291,7 +292,7 @@ void vfio_container_del_section_window(VFIOContainer *container,
>       }
>   }
>   
> -int vfio_set_dirty_page_tracking(VFIOContainer *container, bool start)
> +int vfio_set_dirty_page_tracking(VFIOLegacyContainer *container, bool start)
>   {
>       int ret;
>       struct vfio_iommu_type1_dirty_bitmap dirty = {
> @@ -318,7 +319,7 @@ int vfio_set_dirty_page_tracking(VFIOContainer *container, bool start)
>       return ret;
>   }
>   
> -int vfio_query_dirty_bitmap(VFIOContainer *container, VFIOBitmap *vbmap,
> +int vfio_query_dirty_bitmap(VFIOLegacyContainer *container, VFIOBitmap *vbmap,
>                               hwaddr iova, hwaddr size)
>   {
>       struct vfio_iommu_type1_dirty_bitmap *dbitmap;
> @@ -355,7 +356,7 @@ int vfio_query_dirty_bitmap(VFIOContainer *container, VFIOBitmap *vbmap,
>       return ret;
>   }
>   
> -static void vfio_listener_release(VFIOContainer *container)
> +static void vfio_listener_release(VFIOLegacyContainer *container)
>   {
>       memory_listener_unregister(&container->listener);
>       if (container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU) {
> @@ -415,7 +416,7 @@ static void vfio_kvm_device_del_group(VFIOGroup *group)
>   /*
>    * vfio_get_iommu_type - selects the richest iommu_type (v2 first)
>    */
> -static int vfio_get_iommu_type(VFIOContainer *container,
> +static int vfio_get_iommu_type(VFIOLegacyContainer *container,
>                                  Error **errp)
>   {
>       int iommu_types[] = { VFIO_TYPE1v2_IOMMU, VFIO_TYPE1_IOMMU,
> @@ -431,7 +432,7 @@ static int vfio_get_iommu_type(VFIOContainer *container,
>       return -EINVAL;
>   }
>   
> -static int vfio_init_container(VFIOContainer *container, int group_fd,
> +static int vfio_init_container(VFIOLegacyContainer *container, int group_fd,
>                                  Error **errp)
>   {
>       int iommu_type, ret;
> @@ -466,7 +467,7 @@ static int vfio_init_container(VFIOContainer *container, int group_fd,
>       return 0;
>   }
>   
> -static int vfio_get_iommu_info(VFIOContainer *container,
> +static int vfio_get_iommu_info(VFIOLegacyContainer *container,
>                                  struct vfio_iommu_type1_info **info)
>   {
>   
> @@ -510,7 +511,7 @@ vfio_get_iommu_info_cap(struct vfio_iommu_type1_info *info, uint16_t id)
>       return NULL;
>   }
>   
> -static void vfio_get_iommu_info_migration(VFIOContainer *container,
> +static void vfio_get_iommu_info_migration(VFIOLegacyContainer *container,
>                                             struct vfio_iommu_type1_info *info)
>   {
>       struct vfio_info_cap_header *hdr;
> @@ -538,7 +539,7 @@ static void vfio_get_iommu_info_migration(VFIOContainer *container,
>   static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>                                     Error **errp)
>   {
> -    VFIOContainer *container;
> +    VFIOLegacyContainer *container;
>       int ret, fd;
>       VFIOAddressSpace *space;
>   
> @@ -778,7 +779,7 @@ put_space_exit:
>   
>   static void vfio_disconnect_container(VFIOGroup *group)
>   {
> -    VFIOContainer *container = group->container;
> +    VFIOLegacyContainer *container = group->container;
>   
>       QLIST_REMOVE(group, container_next);
>       group->container = NULL;
> @@ -978,7 +979,7 @@ static void vfio_put_base_device(VFIODevice *vbasedev)
>   /*
>    * Interfaces for IBM EEH (Enhanced Error Handling)
>    */
> -static bool vfio_eeh_container_ok(VFIOContainer *container)
> +static bool vfio_eeh_container_ok(VFIOLegacyContainer *container)
>   {
>       /*
>        * As of 2016-03-04 (linux-4.5) the host kernel EEH/VFIO
> @@ -1006,7 +1007,7 @@ static bool vfio_eeh_container_ok(VFIOContainer *container)
>       return true;
>   }
>   
> -static int vfio_eeh_container_op(VFIOContainer *container, uint32_t op)
> +static int vfio_eeh_container_op(VFIOLegacyContainer *container, uint32_t op)
>   {
>       struct vfio_eeh_pe_op pe_op = {
>           .argsz = sizeof(pe_op),
> @@ -1029,10 +1030,10 @@ static int vfio_eeh_container_op(VFIOContainer *container, uint32_t op)
>       return ret;
>   }
>   
> -static VFIOContainer *vfio_eeh_as_container(AddressSpace *as)
> +static VFIOLegacyContainer *vfio_eeh_as_container(AddressSpace *as)
>   {
>       VFIOAddressSpace *space = vfio_get_address_space(as);
> -    VFIOContainer *container = NULL;
> +    VFIOLegacyContainer *container = NULL;
>   
>       if (QLIST_EMPTY(&space->containers)) {
>           /* No containers to act on */
> @@ -1057,14 +1058,14 @@ out:
>   
>   bool vfio_eeh_as_ok(AddressSpace *as)
>   {
> -    VFIOContainer *container = vfio_eeh_as_container(as);
> +    VFIOLegacyContainer *container = vfio_eeh_as_container(as);
>   
>       return (container != NULL) && vfio_eeh_container_ok(container);
>   }
>   
>   int vfio_eeh_as_op(AddressSpace *as, uint32_t op)
>   {
> -    VFIOContainer *container = vfio_eeh_as_container(as);
> +    VFIOLegacyContainer *container = vfio_eeh_as_container(as);
>   
>       if (!container) {
>           return -ENODEV;
> @@ -1109,7 +1110,7 @@ int vfio_attach_device(char *name, VFIODevice *vbasedev,
>       int groupid = vfio_device_groupid(vbasedev, errp);
>       VFIODevice *vbasedev_iter;
>       VFIOGroup *group;
> -    VFIOContainer *container;
> +    VFIOLegacyContainer *container;
>       int ret;
>   
>       if (groupid < 0) {
> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> index 9ec1e95f6d..683252c506 100644
> --- a/hw/vfio/spapr.c
> +++ b/hw/vfio/spapr.c
> @@ -39,8 +39,8 @@ static void *vfio_prereg_gpa_to_vaddr(MemoryRegionSection *section, hwaddr gpa)
>   static void vfio_prereg_listener_region_add(MemoryListener *listener,
>                                               MemoryRegionSection *section)
>   {
> -    VFIOContainer *container = container_of(listener, VFIOContainer,
> -                                            prereg_listener);
> +    VFIOLegacyContainer *container = container_of(listener, VFIOLegacyContainer,
> +                                                  prereg_listener);
>       const hwaddr gpa = section->offset_within_address_space;
>       hwaddr end;
>       int ret;
> @@ -97,8 +97,8 @@ static void vfio_prereg_listener_region_add(MemoryListener *listener,
>   static void vfio_prereg_listener_region_del(MemoryListener *listener,
>                                               MemoryRegionSection *section)
>   {
> -    VFIOContainer *container = container_of(listener, VFIOContainer,
> -                                            prereg_listener);
> +    VFIOLegacyContainer *container = container_of(listener, VFIOLegacyContainer,
> +                                                  prereg_listener);
>       const hwaddr gpa = section->offset_within_address_space;
>       hwaddr end;
>       int ret;
> @@ -141,7 +141,7 @@ const MemoryListener vfio_prereg_listener = {
>       .region_del = vfio_prereg_listener_region_del,
>   };
>   
> -int vfio_spapr_create_window(VFIOContainer *container,
> +int vfio_spapr_create_window(VFIOLegacyContainer *container,
>                                MemoryRegionSection *section,
>                                hwaddr *pgsize)
>   {
> @@ -233,7 +233,7 @@ int vfio_spapr_create_window(VFIOContainer *container,
>       return 0;
>   }
>   
> -int vfio_spapr_remove_window(VFIOContainer *container,
> +int vfio_spapr_remove_window(VFIOLegacyContainer *container,
>                                hwaddr offset_within_address_space)
>   {
>       struct vfio_iommu_spapr_tce_remove remove = {


