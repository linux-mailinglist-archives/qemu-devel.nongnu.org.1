Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4903A7D936A
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 11:20:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwJ08-0000SE-LA; Fri, 27 Oct 2023 05:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qwJ02-0000QT-Ol
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 05:19:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qwIzz-0005Iv-OR
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 05:19:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698398363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G5ONxUJaHR217Ji7Jx9MulwpoZRfQPfQsuSS/UfYkyc=;
 b=WXVfti5LMw1YY21pLT6HXC8AaNh6HLal28JDd8s8Wce3SU7xHnHBPSAdBKGszilUGz+PGa
 FNvPf9woNvT4odB9KaCZzQuvvzb5TX4NlCr3DpkF9fxGfEFL6NLh3tpc3qkImVlAlxeGO1
 KfHvC1+R/Pv3KhlICbcms7F0vU1tT10=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-GPK1eYfLOVa7TT31-Luu5w-1; Fri, 27 Oct 2023 05:19:11 -0400
X-MC-Unique: GPK1eYfLOVa7TT31-Luu5w-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-66d03b02d16so44213716d6.0
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 02:19:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698398351; x=1699003151;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G5ONxUJaHR217Ji7Jx9MulwpoZRfQPfQsuSS/UfYkyc=;
 b=BGiGS6uff9zjQmugor8Vdh+byBQhPBAAsSjRP6Y2omQVYveQxBnBOwIYfUZMinw9WY
 rkOZLU/tiRGgfroh2cuIL6QTKU3wz9TzJUlTGJjNNijmHwgSkKDVHHHKhFCkH0F90tYG
 7aOWHxAVSlvJxwsxBw6iimljiByqxynLzqWtxK+cwxdInBndyEUN2mPcm3r4dT+Obvl1
 0ARQxJPbwk9FOyb4Q2tIC+HbieU+uOaY/bBLigON/3rzJ7T4v5w9bDSUCm1mOP6nJFo4
 b6osfbKBOFTVZYyJCGOfJnn9YJTL/G2q2CXTjC7FDLhvZA07cj8Fs1Bt6BK9rtm9SLU9
 83hg==
X-Gm-Message-State: AOJu0Ywc/abKsjH/NyXmX6msUviJ5JBf9dFYhPC2DQvuUqJbO8bJnpBK
 ltMovBbjjgLRh5H6QCHhzpx1JZXR/QdK7CSlL9eL1xGESkVyudVB4gJA9f1clXYH50pcvkBFD7X
 hD0Nh4ryTWOuZPtg=
X-Received: by 2002:a05:6214:18ec:b0:66d:593e:7722 with SMTP id
 ep12-20020a05621418ec00b0066d593e7722mr5572820qvb.3.1698398350949; 
 Fri, 27 Oct 2023 02:19:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdDqQdwYat2wwZvBYG0WBZenTwh8RQ/ZbtK457fDHfl2CF6rg5r2lCLpKKd9mnWJ2fiiCAVw==
X-Received: by 2002:a05:6214:18ec:b0:66d:593e:7722 with SMTP id
 ep12-20020a05621418ec00b0066d593e7722mr5572808qvb.3.1698398350647; 
 Fri, 27 Oct 2023 02:19:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:b215:e40:e078:4b27?
 ([2a01:e0a:9e2:9000:b215:e40:e078:4b27])
 by smtp.gmail.com with ESMTPSA id
 r13-20020a0cf60d000000b0065b12c7a48dsm450176qvm.133.2023.10.27.02.19.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Oct 2023 02:19:10 -0700 (PDT)
Message-ID: <cf65a814-b152-4c68-a35e-3840d688c6a4@redhat.com>
Date: Fri, 27 Oct 2023 11:19:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/37] vfio/container: Move IBM EEH related functions
 into spapr_pci_vfio.c
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 "open list:sPAPR (pseries)" <qemu-ppc@nongnu.org>,
 "open list:S390 general arch..." <qemu-s390x@nongnu.org>
References: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
 <20231026103104.1686921-2-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231026103104.1686921-2-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> With vfio_eeh_as_ok/vfio_eeh_as_op moved and made static,
> vfio.h becomes empty and is deleted.
> 
> No functional changes intended.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>


Thanks,

C.


> ---
>   include/hw/vfio/vfio.h  |   7 ---
>   hw/ppc/spapr_pci_vfio.c | 100 +++++++++++++++++++++++++++++++++++++++-
>   hw/vfio/ap.c            |   1 -
>   hw/vfio/ccw.c           |   1 -
>   hw/vfio/common.c        |   1 -
>   hw/vfio/container.c     |  98 ---------------------------------------
>   hw/vfio/helpers.c       |   1 -
>   7 files changed, 99 insertions(+), 110 deletions(-)
>   delete mode 100644 include/hw/vfio/vfio.h
> 
> diff --git a/include/hw/vfio/vfio.h b/include/hw/vfio/vfio.h
> deleted file mode 100644
> index 86248f5436..0000000000
> --- a/include/hw/vfio/vfio.h
> +++ /dev/null
> @@ -1,7 +0,0 @@
> -#ifndef HW_VFIO_H
> -#define HW_VFIO_H
> -
> -bool vfio_eeh_as_ok(AddressSpace *as);
> -int vfio_eeh_as_op(AddressSpace *as, uint32_t op);
> -
> -#endif
> diff --git a/hw/ppc/spapr_pci_vfio.c b/hw/ppc/spapr_pci_vfio.c
> index 9016720547..f283f7e38d 100644
> --- a/hw/ppc/spapr_pci_vfio.c
> +++ b/hw/ppc/spapr_pci_vfio.c
> @@ -18,14 +18,112 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include <sys/ioctl.h>
>   #include <linux/vfio.h>
>   #include "hw/ppc/spapr.h"
>   #include "hw/pci-host/spapr.h"
>   #include "hw/pci/msix.h"
>   #include "hw/pci/pci_device.h"
> -#include "hw/vfio/vfio.h"
> +#include "hw/vfio/vfio-common.h"
>   #include "qemu/error-report.h"
>   
> +/*
> + * Interfaces for IBM EEH (Enhanced Error Handling)
> + */
> +static bool vfio_eeh_container_ok(VFIOContainer *container)
> +{
> +    /*
> +     * As of 2016-03-04 (linux-4.5) the host kernel EEH/VFIO
> +     * implementation is broken if there are multiple groups in a
> +     * container.  The hardware works in units of Partitionable
> +     * Endpoints (== IOMMU groups) and the EEH operations naively
> +     * iterate across all groups in the container, without any logic
> +     * to make sure the groups have their state synchronized.  For
> +     * certain operations (ENABLE) that might be ok, until an error
> +     * occurs, but for others (GET_STATE) it's clearly broken.
> +     */
> +
> +    /*
> +     * XXX Once fixed kernels exist, test for them here
> +     */
> +
> +    if (QLIST_EMPTY(&container->group_list)) {
> +        return false;
> +    }
> +
> +    if (QLIST_NEXT(QLIST_FIRST(&container->group_list), container_next)) {
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
> +static int vfio_eeh_container_op(VFIOContainer *container, uint32_t op)
> +{
> +    struct vfio_eeh_pe_op pe_op = {
> +        .argsz = sizeof(pe_op),
> +        .op = op,
> +    };
> +    int ret;
> +
> +    if (!vfio_eeh_container_ok(container)) {
> +        error_report("vfio/eeh: EEH_PE_OP 0x%x: "
> +                     "kernel requires a container with exactly one group", op);
> +        return -EPERM;
> +    }
> +
> +    ret = ioctl(container->fd, VFIO_EEH_PE_OP, &pe_op);
> +    if (ret < 0) {
> +        error_report("vfio/eeh: EEH_PE_OP 0x%x failed: %m", op);
> +        return -errno;
> +    }
> +
> +    return ret;
> +}
> +
> +static VFIOContainer *vfio_eeh_as_container(AddressSpace *as)
> +{
> +    VFIOAddressSpace *space = vfio_get_address_space(as);
> +    VFIOContainer *container = NULL;
> +
> +    if (QLIST_EMPTY(&space->containers)) {
> +        /* No containers to act on */
> +        goto out;
> +    }
> +
> +    container = QLIST_FIRST(&space->containers);
> +
> +    if (QLIST_NEXT(container, next)) {
> +        /*
> +         * We don't yet have logic to synchronize EEH state across
> +         * multiple containers
> +         */
> +        container = NULL;
> +        goto out;
> +    }
> +
> +out:
> +    vfio_put_address_space(space);
> +    return container;
> +}
> +
> +static bool vfio_eeh_as_ok(AddressSpace *as)
> +{
> +    VFIOContainer *container = vfio_eeh_as_container(as);
> +
> +    return (container != NULL) && vfio_eeh_container_ok(container);
> +}
> +
> +static int vfio_eeh_as_op(AddressSpace *as, uint32_t op)
> +{
> +    VFIOContainer *container = vfio_eeh_as_container(as);
> +
> +    if (!container) {
> +        return -ENODEV;
> +    }
> +    return vfio_eeh_container_op(container, op);
> +}
> +
>   bool spapr_phb_eeh_available(SpaprPhbState *sphb)
>   {
>       return vfio_eeh_as_ok(&sphb->iommu_as);
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index 5f257bffb9..bbf69ff55a 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -14,7 +14,6 @@
>   #include <linux/vfio.h>
>   #include <sys/ioctl.h>
>   #include "qapi/error.h"
> -#include "hw/vfio/vfio.h"
>   #include "hw/vfio/vfio-common.h"
>   #include "hw/s390x/ap-device.h"
>   #include "qemu/error-report.h"
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 6623ae237b..d857bb8d0f 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -20,7 +20,6 @@
>   #include <sys/ioctl.h>
>   
>   #include "qapi/error.h"
> -#include "hw/vfio/vfio.h"
>   #include "hw/vfio/vfio-common.h"
>   #include "hw/s390x/s390-ccw.h"
>   #include "hw/s390x/vfio-ccw.h"
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 9c5c6433f2..e72055e752 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -26,7 +26,6 @@
>   #include <linux/vfio.h>
>   
>   #include "hw/vfio/vfio-common.h"
> -#include "hw/vfio/vfio.h"
>   #include "hw/vfio/pci.h"
>   #include "exec/address-spaces.h"
>   #include "exec/memory.h"
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index fc88222377..83c0f05bba 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -26,7 +26,6 @@
>   #include <linux/vfio.h>
>   
>   #include "hw/vfio/vfio-common.h"
> -#include "hw/vfio/vfio.h"
>   #include "exec/address-spaces.h"
>   #include "exec/memory.h"
>   #include "exec/ram_addr.h"
> @@ -1011,103 +1010,6 @@ static void vfio_put_base_device(VFIODevice *vbasedev)
>       close(vbasedev->fd);
>   }
>   
> -/*
> - * Interfaces for IBM EEH (Enhanced Error Handling)
> - */
> -static bool vfio_eeh_container_ok(VFIOContainer *container)
> -{
> -    /*
> -     * As of 2016-03-04 (linux-4.5) the host kernel EEH/VFIO
> -     * implementation is broken if there are multiple groups in a
> -     * container.  The hardware works in units of Partitionable
> -     * Endpoints (== IOMMU groups) and the EEH operations naively
> -     * iterate across all groups in the container, without any logic
> -     * to make sure the groups have their state synchronized.  For
> -     * certain operations (ENABLE) that might be ok, until an error
> -     * occurs, but for others (GET_STATE) it's clearly broken.
> -     */
> -
> -    /*
> -     * XXX Once fixed kernels exist, test for them here
> -     */
> -
> -    if (QLIST_EMPTY(&container->group_list)) {
> -        return false;
> -    }
> -
> -    if (QLIST_NEXT(QLIST_FIRST(&container->group_list), container_next)) {
> -        return false;
> -    }
> -
> -    return true;
> -}
> -
> -static int vfio_eeh_container_op(VFIOContainer *container, uint32_t op)
> -{
> -    struct vfio_eeh_pe_op pe_op = {
> -        .argsz = sizeof(pe_op),
> -        .op = op,
> -    };
> -    int ret;
> -
> -    if (!vfio_eeh_container_ok(container)) {
> -        error_report("vfio/eeh: EEH_PE_OP 0x%x: "
> -                     "kernel requires a container with exactly one group", op);
> -        return -EPERM;
> -    }
> -
> -    ret = ioctl(container->fd, VFIO_EEH_PE_OP, &pe_op);
> -    if (ret < 0) {
> -        error_report("vfio/eeh: EEH_PE_OP 0x%x failed: %m", op);
> -        return -errno;
> -    }
> -
> -    return ret;
> -}
> -
> -static VFIOContainer *vfio_eeh_as_container(AddressSpace *as)
> -{
> -    VFIOAddressSpace *space = vfio_get_address_space(as);
> -    VFIOContainer *container = NULL;
> -
> -    if (QLIST_EMPTY(&space->containers)) {
> -        /* No containers to act on */
> -        goto out;
> -    }
> -
> -    container = QLIST_FIRST(&space->containers);
> -
> -    if (QLIST_NEXT(container, next)) {
> -        /*
> -         * We don't yet have logic to synchronize EEH state across
> -         * multiple containers
> -         */
> -        container = NULL;
> -        goto out;
> -    }
> -
> -out:
> -    vfio_put_address_space(space);
> -    return container;
> -}
> -
> -bool vfio_eeh_as_ok(AddressSpace *as)
> -{
> -    VFIOContainer *container = vfio_eeh_as_container(as);
> -
> -    return (container != NULL) && vfio_eeh_container_ok(container);
> -}
> -
> -int vfio_eeh_as_op(AddressSpace *as, uint32_t op)
> -{
> -    VFIOContainer *container = vfio_eeh_as_container(as);
> -
> -    if (!container) {
> -        return -ENODEV;
> -    }
> -    return vfio_eeh_container_op(container, op);
> -}
> -
>   static int vfio_device_groupid(VFIODevice *vbasedev, Error **errp)
>   {
>       char *tmp, group_path[PATH_MAX], *group_name;
> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
> index 7e5da21b31..168847e7c5 100644
> --- a/hw/vfio/helpers.c
> +++ b/hw/vfio/helpers.c
> @@ -23,7 +23,6 @@
>   #include <sys/ioctl.h>
>   
>   #include "hw/vfio/vfio-common.h"
> -#include "hw/vfio/vfio.h"
>   #include "hw/hw.h"
>   #include "trace.h"
>   #include "qapi/error.h"


