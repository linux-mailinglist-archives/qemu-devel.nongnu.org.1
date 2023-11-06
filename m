Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D17A7E2A62
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 17:51:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r02oQ-00079W-9V; Mon, 06 Nov 2023 11:50:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r02oI-00076w-IB
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 11:50:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r02oG-0002dY-EN
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 11:50:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699289441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hWMERKBCa1udvYehiGhN/Ho16ImWBYfvZUvndrMPqtE=;
 b=DMilFv2tLZPRhqXy+Y+yYPE+Zc3OGDG1AsY+cydXXujQ0Wn8p2awD8R5mdnmBJ0g1qoyjp
 aEEtIEPoN5hsLHwbD7sQKPCm0U1pCBLHbc7aTJa9mck630LlGY0zD6CBoMhAdf8nHDxbMN
 AubFGI3Eq2D7GtMBCBEh106EoA/KNWY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-taVMuAIOMgeEKVqNJ9x7Tg-1; Mon, 06 Nov 2023 11:50:40 -0500
X-MC-Unique: taVMuAIOMgeEKVqNJ9x7Tg-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6707401e1aeso55338306d6.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 08:50:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699289440; x=1699894240;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hWMERKBCa1udvYehiGhN/Ho16ImWBYfvZUvndrMPqtE=;
 b=c4NIqqQAzwnDMRxocnO1DQzTl3GdFqZ9uz+MTcu5MCD1SVCmpQ1knr6Mp+EORmlOMz
 rKSySxp6nqYvWfI4lnxXTUEFYcyQwAKrgILcqofUCHM8gq9rCeAvmh6JhoR6YF0ZDf7V
 XjXjBV/bGwZ64nDbu2jwvvFw85cn9fMErNUtpbM3hlO8QbPOYpbwYFKB1ud16raU8IWj
 nwNCbtD5GFFNZUD612WGhzz5Lpumwk6cfieM6f+wYVl2MGYZE0rfUoyMYZOgMc3E8ocC
 k14GMyijHs/lIM3HX8WbofPk1BBrM1RMI0mTbqfPZ3UU8Zr186zcMJ+EiNXQLmCHg2f8
 keTw==
X-Gm-Message-State: AOJu0YyMZ9xNlL9/YNQ/N6K2XHF3w+w5xpSsuUWKOiPGM8APYVItufYO
 Io1Q716TD1/Hzqj3kmJiO5yu2RQFXhDV0RfsUbate9+gnNiPySPjzTWR/llD3QCHNnRtsTmaSd4
 eTjvRGenHOeKY99c=
X-Received: by 2002:a05:6214:1316:b0:65b:259f:d6a9 with SMTP id
 pn22-20020a056214131600b0065b259fd6a9mr32468836qvb.7.1699289439865; 
 Mon, 06 Nov 2023 08:50:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZOdYIpc13SoAJLSeTbFGHxOxdBugGA9BmHAwVCRdUh/JItL97R5ptPkm2w2CEr/DPT2pXAQ==
X-Received: by 2002:a05:6214:1316:b0:65b:259f:d6a9 with SMTP id
 pn22-20020a056214131600b0065b259fd6a9mr32468803qvb.7.1699289439517; 
 Mon, 06 Nov 2023 08:50:39 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 mz20-20020a0562142d1400b006713142482fsm3576258qvb.74.2023.11.06.08.50.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 08:50:38 -0800 (PST)
Message-ID: <311ca9c5-b84e-48bd-9212-38c3b9f9608e@redhat.com>
Date: Mon, 6 Nov 2023 17:50:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/41] vfio/container: Move space field to base
 container
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com, Yi Sun
 <yi.y.sun@linux.intel.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "open list:sPAPR (pseries)" <qemu-ppc@nongnu.org>
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
 <20231102071302.1818071-12-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231102071302.1818071-12-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 11/2/23 08:12, Zhenzhong Duan wrote:
> From: Eric Auger <eric.auger@redhat.com>
> 
> Move the space field to the base object. Also the VFIOAddressSpace
> now contains a list of base containers.
> 
> No fucntional change intended.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
> v4: use bcontainer->space->as instead of container->bcontainer.space->as
> 
>   include/hw/vfio/vfio-common.h         |  8 --------
>   include/hw/vfio/vfio-container-base.h |  9 +++++++++
>   hw/ppc/spapr_pci_vfio.c               | 10 +++++-----
>   hw/vfio/common.c                      |  4 ++--
>   hw/vfio/container-base.c              |  6 +++++-
>   hw/vfio/container.c                   | 18 ++++++++----------
>   6 files changed, 29 insertions(+), 26 deletions(-)


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 6be082b8f2..bd4de6cb3a 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -73,17 +73,10 @@ typedef struct VFIOMigration {
>       bool initial_data_sent;
>   } VFIOMigration;
>   
> -typedef struct VFIOAddressSpace {
> -    AddressSpace *as;
> -    QLIST_HEAD(, VFIOContainer) containers;
> -    QLIST_ENTRY(VFIOAddressSpace) list;
> -} VFIOAddressSpace;
> -
>   struct VFIOGroup;
>   
>   typedef struct VFIOContainer {
>       VFIOContainerBase bcontainer;
> -    VFIOAddressSpace *space;
>       int fd; /* /dev/vfio/vfio, empowered by the attached groups */
>       MemoryListener listener;
>       MemoryListener prereg_listener;
> @@ -98,7 +91,6 @@ typedef struct VFIOContainer {
>       QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
>       QLIST_HEAD(, VFIOGroup) group_list;
>       QLIST_HEAD(, VFIORamDiscardListener) vrdl_list;
> -    QLIST_ENTRY(VFIOContainer) next;
>       QLIST_HEAD(, VFIODevice) device_list;
>       GList *iova_ranges;
>   } VFIOContainer;
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index a11aec5755..c7cc6ec9c5 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -24,12 +24,20 @@ typedef struct {
>       hwaddr pages;
>   } VFIOBitmap;
>   
> +typedef struct VFIOAddressSpace {
> +    AddressSpace *as;
> +    QLIST_HEAD(, VFIOContainerBase) containers;
> +    QLIST_ENTRY(VFIOAddressSpace) list;
> +} VFIOAddressSpace;
> +
>   /*
>    * This is the base object for vfio container backends
>    */
>   typedef struct VFIOContainerBase {
>       const VFIOIOMMUOps *ops;
> +    VFIOAddressSpace *space;
>       QLIST_HEAD(, VFIOGuestIOMMU) giommu_list;
> +    QLIST_ENTRY(VFIOContainerBase) next;
>   } VFIOContainerBase;
>   
>   typedef struct VFIOGuestIOMMU {
> @@ -48,6 +56,7 @@ int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
>                                IOMMUTLBEntry *iotlb);
>   
>   void vfio_container_init(VFIOContainerBase *bcontainer,
> +                         VFIOAddressSpace *space,
>                            const VFIOIOMMUOps *ops);
>   void vfio_container_destroy(VFIOContainerBase *bcontainer);
>   
> diff --git a/hw/ppc/spapr_pci_vfio.c b/hw/ppc/spapr_pci_vfio.c
> index f283f7e38d..d1d07bec46 100644
> --- a/hw/ppc/spapr_pci_vfio.c
> +++ b/hw/ppc/spapr_pci_vfio.c
> @@ -84,27 +84,27 @@ static int vfio_eeh_container_op(VFIOContainer *container, uint32_t op)
>   static VFIOContainer *vfio_eeh_as_container(AddressSpace *as)
>   {
>       VFIOAddressSpace *space = vfio_get_address_space(as);
> -    VFIOContainer *container = NULL;
> +    VFIOContainerBase *bcontainer = NULL;
>   
>       if (QLIST_EMPTY(&space->containers)) {
>           /* No containers to act on */
>           goto out;
>       }
>   
> -    container = QLIST_FIRST(&space->containers);
> +    bcontainer = QLIST_FIRST(&space->containers);
>   
> -    if (QLIST_NEXT(container, next)) {
> +    if (QLIST_NEXT(bcontainer, next)) {
>           /*
>            * We don't yet have logic to synchronize EEH state across
>            * multiple containers
>            */
> -        container = NULL;
> +        bcontainer = NULL;
>           goto out;
>       }
>   
>   out:
>       vfio_put_address_space(space);
> -    return container;
> +    return container_of(bcontainer, VFIOContainer, bcontainer);
>   }
>   
>   static bool vfio_eeh_as_ok(AddressSpace *as)
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 43580bcc43..1d8202537e 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -145,7 +145,7 @@ void vfio_unblock_multiple_devices_migration(void)
>   
>   bool vfio_viommu_preset(VFIODevice *vbasedev)
>   {
> -    return vbasedev->container->space->as != &address_space_memory;
> +    return vbasedev->container->bcontainer.space->as != &address_space_memory;
>   }
>   
>   static void vfio_set_migration_error(int err)
> @@ -922,7 +922,7 @@ static void vfio_dirty_tracking_init(VFIOContainer *container,
>       dirty.container = container;
>   
>       memory_listener_register(&dirty.listener,
> -                             container->space->as);
> +                             container->bcontainer.space->as);
>   
>       *ranges = dirty.ranges;
>   
> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
> index 20bcb9669a..3933391e0d 100644
> --- a/hw/vfio/container-base.c
> +++ b/hw/vfio/container-base.c
> @@ -31,9 +31,11 @@ int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
>       return bcontainer->ops->dma_unmap(bcontainer, iova, size, iotlb);
>   }
>   
> -void vfio_container_init(VFIOContainerBase *bcontainer, const VFIOIOMMUOps *ops)
> +void vfio_container_init(VFIOContainerBase *bcontainer, VFIOAddressSpace *space,
> +                         const VFIOIOMMUOps *ops)
>   {
>       bcontainer->ops = ops;
> +    bcontainer->space = space;
>       QLIST_INIT(&bcontainer->giommu_list);
>   }
>   
> @@ -41,6 +43,8 @@ void vfio_container_destroy(VFIOContainerBase *bcontainer)
>   {
>       VFIOGuestIOMMU *giommu, *tmp;
>   
> +    QLIST_REMOVE(bcontainer, next);
> +
>       QLIST_FOREACH_SAFE(giommu, &bcontainer->giommu_list, giommu_next, tmp) {
>           memory_region_unregister_iommu_notifier(
>                   MEMORY_REGION(giommu->iommu_mr), &giommu->n);
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 133d3c8f5c..f12fcb6fe1 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -514,7 +514,8 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>        * details once we know which type of IOMMU we are using.
>        */
>   
> -    QLIST_FOREACH(container, &space->containers, next) {
> +    QLIST_FOREACH(bcontainer, &space->containers, next) {
> +        container = container_of(bcontainer, VFIOContainer, bcontainer);
>           if (!ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &container->fd)) {
>               ret = vfio_ram_block_discard_disable(container, true);
>               if (ret) {
> @@ -550,7 +551,6 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>       }
>   
>       container = g_malloc0(sizeof(*container));
> -    container->space = space;
>       container->fd = fd;
>       container->error = NULL;
>       container->dirty_pages_supported = false;
> @@ -558,7 +558,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>       container->iova_ranges = NULL;
>       QLIST_INIT(&container->vrdl_list);
>       bcontainer = &container->bcontainer;
> -    vfio_container_init(bcontainer, &vfio_legacy_ops);
> +    vfio_container_init(bcontainer, space, &vfio_legacy_ops);
>   
>       ret = vfio_init_container(container, group->fd, errp);
>       if (ret) {
> @@ -613,14 +613,14 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>       vfio_kvm_device_add_group(group);
>   
>       QLIST_INIT(&container->group_list);
> -    QLIST_INSERT_HEAD(&space->containers, container, next);
> +    QLIST_INSERT_HEAD(&space->containers, bcontainer, next);
>   
>       group->container = container;
>       QLIST_INSERT_HEAD(&container->group_list, group, container_next);
>   
>       container->listener = vfio_memory_listener;
>   
> -    memory_listener_register(&container->listener, container->space->as);
> +    memory_listener_register(&container->listener, bcontainer->space->as);
>   
>       if (container->error) {
>           ret = -1;
> @@ -634,7 +634,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>       return 0;
>   listener_release_exit:
>       QLIST_REMOVE(group, container_next);
> -    QLIST_REMOVE(container, next);
> +    QLIST_REMOVE(bcontainer, next);
>       vfio_kvm_device_del_group(group);
>       memory_listener_unregister(&container->listener);
>       if (container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU ||
> @@ -684,9 +684,7 @@ static void vfio_disconnect_container(VFIOGroup *group)
>       }
>   
>       if (QLIST_EMPTY(&container->group_list)) {
> -        VFIOAddressSpace *space = container->space;
> -
> -        QLIST_REMOVE(container, next);
> +        VFIOAddressSpace *space = bcontainer->space;
>   
>           vfio_container_destroy(bcontainer);
>   
> @@ -707,7 +705,7 @@ static VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
>       QLIST_FOREACH(group, &vfio_group_list, next) {
>           if (group->groupid == groupid) {
>               /* Found it.  Now is it already in the right context? */
> -            if (group->container->space->as == as) {
> +            if (group->container->bcontainer.space->as == as) {
>                   return group;
>               } else {
>                   error_setg(errp, "group %d used in multiple address spaces",


