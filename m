Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D827D9AAF
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 16:03:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwNQQ-0002yS-4T; Fri, 27 Oct 2023 10:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qwNQH-0002y8-2j
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:02:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qwNQD-00062H-MJ
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:02:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698415364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oP4YzODHqDCdTthV8F36N42zNW5IWyEUqtxm5JrlG7w=;
 b=A11qf6yK+KaDkRY6iypopUSusdu+Di65TcUGc0Yl2pMf1w1Gu1yxN4tYc55QdpslaD00Gh
 pAyOfOO6Q5sOfC6IXpqes+BbiPdDsmtjqp6IHIATsP+cDv+n6I5A9Ves3nz6/6URBAX8yw
 EOy0b5WnOTLsvVIRa5t76U2k8ITTjGQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-KRATgKSqOZubpGPCO1gz_Q-1; Fri, 27 Oct 2023 10:02:41 -0400
X-MC-Unique: KRATgKSqOZubpGPCO1gz_Q-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7788ce62d50so280369085a.3
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 07:02:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698415360; x=1699020160;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oP4YzODHqDCdTthV8F36N42zNW5IWyEUqtxm5JrlG7w=;
 b=Q5dPrfZh0oKYJUweQ/C+7WZDTydW/gI/+8MwRRdgD6JARSKyXdvIQvfs/TreaEv+Kt
 7um4R5wAq89lIWC8XfW3hlG3u7TRl9hMYz0TGzhE17B91QuBuIY8GhkjClfoUB9nu69n
 +5J3eqNM0VW9Fk9hBWUz9L8BrmJ8nPCjSORL4CVqGrezzL5kRm7vyTuyiK3UxJyLrtyn
 LmVYg+D/4+Ci93lpWDXJ4O+xNiGno0ZKYsPA0lrMSO8FEAi/uPvp+XFXpVkujyE5p943
 wCJoG4Lqqsyr3h0o2crLQncLl3rnj8KM+mPisXVX5W5288zs4pfqSgp9rkKfKIkogldM
 kh9A==
X-Gm-Message-State: AOJu0Yzlxn7finJnZYZTQQSKb1Lw6mXNsuGNtAAv8FsdO9uv2ZzCT5I7
 7bI+9BU0foyARJg1jL9aRNETpi4/BJvnw6WT+xwzoDsLqBLBYb38YOPV/HXdqIjLP4MxaAYau7V
 ormSvBInhfJpdwPU=
X-Received: by 2002:a05:620a:2a14:b0:778:9a18:68f6 with SMTP id
 o20-20020a05620a2a1400b007789a1868f6mr2568975qkp.58.1698415360537; 
 Fri, 27 Oct 2023 07:02:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLoSGY6/yi+IfkOU/tofeeqxeOKruxION6PXaTv09wFhypopPLd8bfv05vTGq4ozd5qDtI/A==
X-Received: by 2002:a05:620a:2a14:b0:778:9a18:68f6 with SMTP id
 o20-20020a05620a2a1400b007789a1868f6mr2568952qkp.58.1698415360282; 
 Fri, 27 Oct 2023 07:02:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:b215:e40:e078:4b27?
 ([2a01:e0a:9e2:9000:b215:e40:e078:4b27])
 by smtp.gmail.com with ESMTPSA id
 m12-20020ae9e70c000000b007770673e757sm558961qka.94.2023.10.27.07.02.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Oct 2023 07:02:39 -0700 (PDT)
Message-ID: <77cb4375-beb8-4d6e-ba9f-304d357e7e67@redhat.com>
Date: Fri, 27 Oct 2023 16:02:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/37] vfio: Introduce base object for VFIOContainer
 and targetted interface
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com, Yi Sun <yi.y.sun@linux.intel.com>
References: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
 <20231026103104.1686921-7-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231026103104.1686921-7-zhenzhong.duan@intel.com>
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

On 10/26/23 12:30, Zhenzhong Duan wrote:
> Introduce a dumb VFIOContainer base object and its targetted interface.

targeted


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
>   include/hw/vfio/vfio-common.h         |  8 +---
>   include/hw/vfio/vfio-container-base.h | 64 +++++++++++++++++++++++++++
>   2 files changed, 66 insertions(+), 6 deletions(-)
>   create mode 100644 include/hw/vfio/vfio-container-base.h
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index b9c7a7e588..d8f293cb57 100644
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
> index 0000000000..5becbd51a7
> --- /dev/null
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -0,0 +1,64 @@
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

This should be enough :

   SPDX-License-Identifier: GPL-2.0-or-later

> + */
> +
> +#ifndef HW_VFIO_VFIO_BASE_CONTAINER_H
> +#define HW_VFIO_VFIO_BASE_CONTAINER_H

HW_VFIO_VFIO_CONTAINER_BASE_H

> +
> +#include "exec/memory.h"
> +#ifndef CONFIG_USER_ONLY
> +#include "exec/hwaddr.h"
> +#endif

including "exec/memory.h" should be enough.


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

Could the VFIOContainerBase *parameter be const ?

> +    int (*attach_device)(char *name, VFIODevice *vbasedev,

cont char *name  ?

The rest looks good to me.

Thanks

C.


> +                         AddressSpace *as, Error **errp);
> +    void (*detach_device)(VFIODevice *vbasedev);
> +    /* migration feature */
> +    int (*set_dirty_page_tracking)(VFIOContainerBase *bcontainer, bool start);
> +    int (*query_dirty_bitmap)(VFIOContainerBase *bcontainer, VFIOBitmap *vbmap,
> +                              hwaddr iova, hwaddr size);
> +};
> +#endif /* HW_VFIO_VFIO_BASE_CONTAINER_H */


