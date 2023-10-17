Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 442CF7CC806
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 17:51:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsmLy-0005bt-Ul; Tue, 17 Oct 2023 11:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qsmLo-0005Nw-FN
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 11:51:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qsmLm-0003n4-Ex
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 11:51:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697557877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KrAhKxImTdbxILb0hXRGhulVMmaX++ygsqjWH70VXxM=;
 b=RW4dLIn4rWiQIfjrXx0pdOHfskF0MzxMr7KyJ2zH2M6uO3pWG5MXgm9AVIrpFntKxATAJE
 TnCcjFDwc5ZxU5HWYmtNrZWUAt7aD/9IGfu1xM1DFE13eMGkVFLnnPnXE4y9OfEzz4fgbE
 JVnk4J8BcMH1vGmhv9Ka9oeksonoIwQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284--EMWkaGZNNaStinG_9AGRQ-1; Tue, 17 Oct 2023 11:51:14 -0400
X-MC-Unique: -EMWkaGZNNaStinG_9AGRQ-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7740cf4136aso686034085a.2
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 08:51:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697557874; x=1698162674;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KrAhKxImTdbxILb0hXRGhulVMmaX++ygsqjWH70VXxM=;
 b=DhGPET07XtfAuljM/chcrB2m0Ma5bGrh3SbV7sWP+PK7LXQTNIJ5FgLAaSLI8AGsAL
 yBI8bNb4rugNN6AZnOuvzta+OSHV2WPviTeITjaG5kKnPr8fWPfAYn5o9vFkNBXCICU9
 FaEouJG7yYZVJQsenoFhpKXUvVhRAPYQ6Kmr1++H/X3/DfgYX/oFBVd8r6+PaUtkzkW6
 CE03RJZR2kqdES/hiTYZG5PgxB98LNTGXuxFy35/FkTGoTivg2sXa0jlPGNcTAk1N53a
 2L1ARCMBb724lir5opELrl6dL8aHaHtyxW1vfmXFakffsB3LXTraK7n1su1XGEk18/hT
 FYzw==
X-Gm-Message-State: AOJu0YzHsHWhsT+o7GzNzK7wBcqd1epzbMDNnr26QNXno6QnqPA+jwfu
 q2dDxZ+1mJv76xgmR+vLJxF8iXNkLoaAPABSlLoMmvKzxTrrFm9qpynLVwkWCjZBxkXanusfsmx
 PA2cw+18rRYgjx64=
X-Received: by 2002:a05:620a:4511:b0:774:26bf:efa2 with SMTP id
 t17-20020a05620a451100b0077426bfefa2mr2880454qkp.58.1697557874248; 
 Tue, 17 Oct 2023 08:51:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGU4Pyl78lWia+Tz9715N6YQIPsqvIy/3xtn8UFc0Y0MMTvu1VgAHQLrDqI0i+n6R5uiJIXJg==
X-Received: by 2002:a05:620a:4511:b0:774:26bf:efa2 with SMTP id
 t17-20020a05620a451100b0077426bfefa2mr2880439qkp.58.1697557873949; 
 Tue, 17 Oct 2023 08:51:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 9-20020a05620a04c900b0077263636a95sm758843qks.93.2023.10.17.08.51.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Oct 2023 08:51:13 -0700 (PDT)
Message-ID: <f8089865-20cf-4f11-981a-e593a103a387@redhat.com>
Date: Tue, 17 Oct 2023 17:51:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/27] vfio: Introduce base object for VFIOContainer
 and targetted interface
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com, Yi Sun <yi.y.sun@linux.intel.com>
References: <20231016083223.1519410-1-zhenzhong.duan@intel.com>
 <20231016083223.1519410-3-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231016083223.1519410-3-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

On 10/16/23 10:31, Zhenzhong Duan wrote:
> From: Eric Auger <eric.auger@redhat.com>
> 
> Introduce a dumb VFIOContainer base object and its targetted interface.
> This is willingly not a QOM object because we don't want it to be
> visible from the user interface.  The VFIOContainer will be smoothly
> populated in subsequent patches as well as interfaces.
> 
> No fucntional change intended.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/hw/vfio/vfio-common.h         |  8 +--
>   include/hw/vfio/vfio-container-base.h | 82 +++++++++++++++++++++++++++
>   2 files changed, 84 insertions(+), 6 deletions(-)
>   create mode 100644 include/hw/vfio/vfio-container-base.h
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 34648e518e..9651cf921c 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -30,6 +30,7 @@
>   #include <linux/vfio.h>
>   #endif
>   #include "sysemu/sysemu.h"
> +#include "hw/vfio/vfio-container-base.h"
>   
>   #define VFIO_MSG_PREFIX "vfio %s: "
>   
> @@ -81,6 +82,7 @@ typedef struct VFIOAddressSpace {
>   struct VFIOGroup;
>   
>   typedef struct VFIOLegacyContainer {
> +    VFIOContainer bcontainer;

That's the parent class, right ?

>       VFIOAddressSpace *space;
>       int fd; /* /dev/vfio/vfio, empowered by the attached groups */
>       MemoryListener listener;
> @@ -200,12 +202,6 @@ typedef struct VFIODisplay {
>       } dmabuf;
>   } VFIODisplay;
>   
> -typedef struct {
> -    unsigned long *bitmap;
> -    hwaddr size;
> -    hwaddr pages;
> -} VFIOBitmap;
> -
>   void vfio_host_win_add(VFIOLegacyContainer *container,
>                          hwaddr min_iova, hwaddr max_iova,
>                          uint64_t iova_pgsizes);
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> new file mode 100644
> index 0000000000..afc8543d22
> --- /dev/null
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -0,0 +1,82 @@
> +/*
> + * VFIO BASE CONTAINER
> + *
> + * Copyright (C) 2023 Intel Corporation.
> + * Copyright Red Hat, Inc. 2023
> + *
> + * Authors: Yi Liu <yi.l.liu@intel.com>
> + *          Eric Auger <eric.auger@redhat.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> +
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> +
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef HW_VFIO_VFIO_BASE_CONTAINER_H
> +#define HW_VFIO_VFIO_BASE_CONTAINER_H
> +
> +#include "exec/memory.h"
> +#ifndef CONFIG_USER_ONLY
> +#include "exec/hwaddr.h"
> +#endif
> +
> +typedef struct VFIOContainer VFIOContainer;
> +typedef struct VFIODevice VFIODevice;
> +typedef struct VFIOIOMMUBackendOpsClass VFIOIOMMUBackendOpsClass;
> +
> +typedef struct {
> +    unsigned long *bitmap;
> +    hwaddr size;
> +    hwaddr pages;
> +} VFIOBitmap;
> +
> +/*
> + * This is the base object for vfio container backends
> + */
> +struct VFIOContainer {
> +    VFIOIOMMUBackendOpsClass *ops;

This is unexpected.

I thought that an abstract QOM model for VFIOContainer was going
to be introduced with a VFIOContainerClass with the ops below
(VFIOIOMMUBackendOpsClass).

Then, we would call :

    VFIOContainerClass *vcc = VFIO_CONTAINER_GET_CLASS(container);

to get the specific implementation for the current container.

I don't understand the VFIOIOMMUBackendOpsClass pointer and
TYPE_VFIO_IOMMU_BACKEND_OPS. It seems redundant.

Thanks,

C.

> +};
> +
> +#define TYPE_VFIO_IOMMU_BACKEND_OPS "vfio-iommu-backend-ops"
> +
> +DECLARE_CLASS_CHECKERS(VFIOIOMMUBackendOpsClass,
> +                       VFIO_IOMMU_BACKEND_OPS, TYPE_VFIO_IOMMU_BACKEND_OPS)
> +
> +struct VFIOIOMMUBackendOpsClass {
> +    /*< private >*/
> +    ObjectClass parent_class;
> +
> +    /*< public >*/
> +    /* required */
> +    int (*dma_map)(VFIOContainer *bcontainer,
> +                   hwaddr iova, ram_addr_t size,
> +                   void *vaddr, bool readonly);
> +    int (*dma_unmap)(VFIOContainer *bcontainer,
> +                     hwaddr iova, ram_addr_t size,
> +                     IOMMUTLBEntry *iotlb);
> +    int (*attach_device)(char *name, VFIODevice *vbasedev,
> +                         AddressSpace *as, Error **errp);
> +    void (*detach_device)(VFIODevice *vbasedev);
> +    /* migration feature */
> +    int (*set_dirty_page_tracking)(VFIOContainer *bcontainer, bool start);
> +    int (*query_dirty_bitmap)(VFIOContainer *bcontainer, VFIOBitmap *vbmap,
> +                              hwaddr iova, hwaddr size);
> +
> +    /* SPAPR specific */
> +    int (*add_window)(VFIOContainer *bcontainer,
> +                      MemoryRegionSection *section,
> +                      Error **errp);
> +    void (*del_window)(VFIOContainer *bcontainer,
> +                       MemoryRegionSection *section);
> +};
> +
> +#endif /* HW_VFIO_VFIO_BASE_CONTAINER_H */

  


