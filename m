Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0C47D9C13
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 16:48:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwO7C-0000rD-AQ; Fri, 27 Oct 2023 10:47:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qwO6S-0000WV-49
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:46:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qwO6P-0002Aw-S2
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:46:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698417980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KpmCIgSFfBS15z8i36mGuTMbGeWja+UG06CH63Thmew=;
 b=ZlFsE6xALxH8JA/V8O63k4+Tbdsdqn+36ap23cYqJ0mSkx3Rch0yCt63nYRWTk4KFJBFYE
 Wl0+JaMKBRRzt1C0a5ukvIZtOdc+G5bSEsW/ZEqveIAaEqAjxYTrj0o4lKbAeYyIAxk5qC
 Wv2S0rB0NC0JBorCD9vIcaHlYWd8qFY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-cSpXxTHgPOehmAWcfJlX0g-1; Fri, 27 Oct 2023 10:46:19 -0400
X-MC-Unique: cSpXxTHgPOehmAWcfJlX0g-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-778a2e847f4so285599585a.0
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 07:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698417979; x=1699022779;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KpmCIgSFfBS15z8i36mGuTMbGeWja+UG06CH63Thmew=;
 b=GTbq556Bnco0nTuWo3d2qTQWnEFd+H+CclnTC0iW54/sjbyXBFWVk9zs2SJs9g7vZi
 ZLFFib8/uwRJCnyIgxUshjIl4VbhqpHW4zbHv40VSiITLP8fm7eU79uvUGzBljg+tMTD
 B5Qr9gEYsrUQoii5YeDVa10Jmnd8+dtWUuBYv2lZMa3EZcY33T9yD5UrPAMjsSkYVKGT
 TK/phzersT/MAjGounxtRohJ3rH+ri4BA9Ty1IEWVGTkpBrNSPtlv0AzUlgOd520l458
 aH60iYrvq3oOTlZ2U9nSAL9pZwlPu+g/fVmeGqHTtzdlRU/jYBrXyijJFnS98RIWDr4t
 QT0Q==
X-Gm-Message-State: AOJu0YxN2VuHzUhz9VWVKAZOqM34Oz5pBoUoNmCJCP3BWBFJp9HvWqld
 o/5gBkzNTPZHquyePYApkt3KDnvBT5UM+qYFtz7UNRVw0mLC4nghtOcVvOL3M10EmMmUArxKxNJ
 me3qR5LyvweKIJ8E=
X-Received: by 2002:a05:620a:d8a:b0:778:9ac2:5a9f with SMTP id
 q10-20020a05620a0d8a00b007789ac25a9fmr2969755qkl.11.1698417979044; 
 Fri, 27 Oct 2023 07:46:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0obVKS3uCsvhJb6h8DKbfjkG21lMo0seeqgGE5mamHNA5PJaUO9uDQr+6oVzk9tdjeahkbQ==
X-Received: by 2002:a05:620a:d8a:b0:778:9ac2:5a9f with SMTP id
 q10-20020a05620a0d8a00b007789ac25a9fmr2969718qkl.11.1698417978736; 
 Fri, 27 Oct 2023 07:46:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:b215:e40:e078:4b27?
 ([2a01:e0a:9e2:9000:b215:e40:e078:4b27])
 by smtp.gmail.com with ESMTPSA id
 c5-20020ae9e205000000b0076f35d17d06sm600784qkc.69.2023.10.27.07.46.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Oct 2023 07:46:18 -0700 (PDT)
Message-ID: <a8c2f432-71ba-4c20-9506-e404e7b1d35e@redhat.com>
Date: Fri, 27 Oct 2023 16:46:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/37] vfio/container: Move space field to base
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
References: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
 <20231026103104.1686921-11-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231026103104.1686921-11-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 10/26/23 12:30, Zhenzhong Duan wrote:
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
> [ clg: context changes ]
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   include/hw/vfio/vfio-common.h         |  8 --------
>   include/hw/vfio/vfio-container-base.h |  9 +++++++++
>   hw/ppc/spapr_pci_vfio.c               | 10 +++++-----
>   hw/vfio/common.c                      |  4 ++--
>   hw/vfio/container-base.c              |  6 +++++-
>   hw/vfio/container.c                   | 18 +++++++++---------
>   6 files changed, 30 insertions(+), 25 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index fcb4003a21..857d2b8076 100644
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
> index 71e1e4324e..a5fef3e6a8 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -38,12 +38,20 @@ typedef struct {
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
> @@ -62,6 +70,7 @@ int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
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
> index 4f130ad87c..f87a0dcec3 100644
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
> @@ -924,7 +924,7 @@ static void vfio_dirty_tracking_init(VFIOContainer *container,
>       dirty.container = container;
>   
>       memory_listener_register(&dirty.listener,
> -                             container->space->as);
> +                             container->bcontainer.space->as);

Could we introduce an helper returning :

   container->bcontainer.space->as

The rest looks OK.

Thanks,

C.

>   
>       *ranges = dirty.ranges;
>   
> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
> index 6be7ce65ad..99b2957d7b 100644
> --- a/hw/vfio/container-base.c
> +++ b/hw/vfio/container-base.c
> @@ -48,9 +48,11 @@ int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
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
> @@ -58,6 +60,8 @@ void vfio_container_destroy(VFIOContainerBase *bcontainer)
>   {
>       VFIOGuestIOMMU *giommu, *tmp;
>   
> +    QLIST_REMOVE(bcontainer, next);
> +
>       QLIST_FOREACH_SAFE(giommu, &bcontainer->giommu_list, giommu_next, tmp) {
>           memory_region_unregister_iommu_notifier(
>                   MEMORY_REGION(giommu->iommu_mr), &giommu->n);
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index b2b6e05287..761310fa51 100644
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
> @@ -613,14 +613,15 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
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
> +    memory_listener_register(&container->listener,
> +                             container->bcontainer.space->as);
>   
>       if (container->error) {
>           ret = -1;
> @@ -634,7 +635,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>       return 0;
>   listener_release_exit:
>       QLIST_REMOVE(group, container_next);
> -    QLIST_REMOVE(container, next);
> +    QLIST_REMOVE(bcontainer, next);
>       vfio_kvm_device_del_group(group);
>       memory_listener_unregister(&container->listener);
>       if (container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU ||
> @@ -684,9 +685,8 @@ static void vfio_disconnect_container(VFIOGroup *group)
>       }
>   
>       if (QLIST_EMPTY(&container->group_list)) {
> -        VFIOAddressSpace *space = container->space;
> +        VFIOAddressSpace *space = container->bcontainer.space;
>   
> -        QLIST_REMOVE(container, next);
>           vfio_container_destroy(bcontainer);
>   
>           trace_vfio_disconnect_container(container->fd);
> @@ -706,7 +706,7 @@ static VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
>       QLIST_FOREACH(group, &vfio_group_list, next) {
>           if (group->groupid == groupid) {
>               /* Found it.  Now is it already in the right context? */
> -            if (group->container->space->as == as) {
> +            if (group->container->bcontainer.space->as == as) {
>                   return group;
>               } else {
>                   error_setg(errp, "group %d used in multiple address spaces",


