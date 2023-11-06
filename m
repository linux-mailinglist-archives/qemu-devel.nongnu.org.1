Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3320D7E29F0
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 17:37:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r02aT-0001Km-3F; Mon, 06 Nov 2023 11:36:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r02aL-0001KJ-3Y
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 11:36:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r02aI-0008LV-F0
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 11:36:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699288577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QUSTeqmLn9AP4PZ9gUEj9Loi+HoOve+rZj68o2zb2AA=;
 b=duttoHHxRe5OvjOGWtGw//lXi3R8I3gputd++LCGYC9f/M7FOHCqFoKGo0LJY7UfofVD2O
 zOJQmuoO5x6pQyFJiviVweCAlxPjwveiFEek416ctiN8v4gOhpchhnzpRxnF67z+9NZ9O9
 KPStlmCagnaBr+xB3W8vNOE6ycmrQG0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-CmpCyLa0NLyVw06S99_I1g-1; Mon, 06 Nov 2023 11:36:16 -0500
X-MC-Unique: CmpCyLa0NLyVw06S99_I1g-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-778b5354c7bso595011885a.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 08:36:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699288575; x=1699893375;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QUSTeqmLn9AP4PZ9gUEj9Loi+HoOve+rZj68o2zb2AA=;
 b=crq2VUheaUqzQlWNOLmESO58o9fP+kLnO373vNsO1NnPx1zoygiBe9hO+zDDy8LrYm
 nCkI9J5ADXzyO2sdN91swFKNkscJXVo4WctG9q0rim+4ZczS+fld58Ql1FgBfXl3xVTn
 NdzRyNtbiQHAPFsR+ejJS9IgPw/44rV/SybIw+Ia4iTwHTld++LnS21IAjwSUQ+i4yPg
 pWDU1ZhQWVZrmzCS0RzjZynKMkZb2dpeTQN5bTESyvjJrhB2SJyLvQzH4hWZEO6Ko8Hi
 BXxSfMr4t3XUNt5pCetmpTJicjUcPHtHvs9EZYxI5Y32isSWNj5MJKZjSQPG6DpDjPZG
 hF+A==
X-Gm-Message-State: AOJu0YxqSTGLanlA/O1c4ATYZIZnZq+UJIpJIaHS8m9wWOAhc04ZvE80
 ltwBPaVNLgR29KUKP0TZnu5a2yV2PEroZuIo/TyIyEDCs6+PZxrxnsENJqIZRGXxpng7B9q1PSn
 CnJHpMJwWePLQO5g=
X-Received: by 2002:a05:620a:e99:b0:77a:1d58:85bc with SMTP id
 w25-20020a05620a0e9900b0077a1d5885bcmr27046563qkm.47.1699288575685; 
 Mon, 06 Nov 2023 08:36:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJngsRw9h5RlYYZIyXJ9ZxzpuSz9YBmYLGcAihUsJnh4lA4JHk8ONeuzRHtDLJ/jKHz66eVA==
X-Received: by 2002:a05:620a:e99:b0:77a:1d58:85bc with SMTP id
 w25-20020a05620a0e9900b0077a1d5885bcmr27046537qkm.47.1699288575388; 
 Mon, 06 Nov 2023 08:36:15 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 l3-20020a05620a28c300b0076c96e571f3sm3426450qkp.26.2023.11.06.08.36.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 08:36:15 -0800 (PST)
Message-ID: <cd3f3391-ebc8-4ca6-9856-91c6d482cd14@redhat.com>
Date: Mon, 6 Nov 2023 17:36:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/41] vfio: Introduce base object for VFIOContainer
 and targeted interface
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com, Yi Sun <yi.y.sun@linux.intel.com>
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
 <20231102071302.1818071-7-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231102071302.1818071-7-zhenzhong.duan@intel.com>
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
> Introduce a dumb VFIOContainerBase object and its targeted interface.
> This is willingly not a QOM object because we don't want it to be
> visible from the user interface. The VFIOContainerBase will be
> smoothly populated in subsequent patches as well as interfaces.
> 
> No fucntional change intended.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
> v4: use SPDX identifier, use const char *name parameter, HW_VFIO_VFIO_CONTAINER_BASE_H



Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


>   include/hw/vfio/vfio-common.h         |  8 ++---
>   include/hw/vfio/vfio-container-base.h | 50 +++++++++++++++++++++++++++
>   2 files changed, 52 insertions(+), 6 deletions(-)
>   create mode 100644 include/hw/vfio/vfio-container-base.h
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index a4a22accb9..586d153c12 100644
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
>   typedef struct VFIOContainer {
> +    VFIOContainerBase bcontainer;
>       VFIOAddressSpace *space;
>       int fd; /* /dev/vfio/vfio, empowered by the attached groups */
>       MemoryListener listener;
> @@ -201,12 +203,6 @@ typedef struct VFIODisplay {
>       } dmabuf;
>   } VFIODisplay;
>   
> -typedef struct {
> -    unsigned long *bitmap;
> -    hwaddr size;
> -    hwaddr pages;
> -} VFIOBitmap;
> -
>   VFIOAddressSpace *vfio_get_address_space(AddressSpace *as);
>   void vfio_put_address_space(VFIOAddressSpace *space);
>   bool vfio_devices_all_running_and_saving(VFIOContainer *container);
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> new file mode 100644
> index 0000000000..1d6daaea5d
> --- /dev/null
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -0,0 +1,50 @@
> +/*
> + * VFIO BASE CONTAINER
> + *
> + * Copyright (C) 2023 Intel Corporation.
> + * Copyright Red Hat, Inc. 2023
> + *
> + * Authors: Yi Liu <yi.l.liu@intel.com>
> + *          Eric Auger <eric.auger@redhat.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_VFIO_VFIO_CONTAINER_BASE_H
> +#define HW_VFIO_VFIO_CONTAINER_BASE_H
> +
> +#include "exec/memory.h"
> +
> +typedef struct VFIODevice VFIODevice;
> +typedef struct VFIOIOMMUOps VFIOIOMMUOps;
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
> +typedef struct VFIOContainerBase {
> +    const VFIOIOMMUOps *ops;
> +} VFIOContainerBase;
> +
> +struct VFIOIOMMUOps {
> +    /* basic feature */
> +    int (*dma_map)(VFIOContainerBase *bcontainer,
> +                   hwaddr iova, ram_addr_t size,
> +                   void *vaddr, bool readonly);
> +    int (*dma_unmap)(VFIOContainerBase *bcontainer,
> +                     hwaddr iova, ram_addr_t size,
> +                     IOMMUTLBEntry *iotlb);
> +    int (*attach_device)(const char *name, VFIODevice *vbasedev,
> +                         AddressSpace *as, Error **errp);
> +    void (*detach_device)(VFIODevice *vbasedev);
> +    /* migration feature */
> +    int (*set_dirty_page_tracking)(VFIOContainerBase *bcontainer, bool start);
> +    int (*query_dirty_bitmap)(VFIOContainerBase *bcontainer, VFIOBitmap *vbmap,
> +                              hwaddr iova, hwaddr size);
> +};
> +#endif /* HW_VFIO_VFIO_CONTAINER_BASE_H */


