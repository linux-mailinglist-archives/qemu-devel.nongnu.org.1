Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D544C7E4819
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:19:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0QfD-0007wu-TM; Tue, 07 Nov 2023 13:18:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r0QfA-0007wV-Uq
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:18:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r0Qf8-0004fE-Jf
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:18:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699381133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+kQR7mvSV4WiG27S4G5uUiwW7A487dg3ux1TTyoQ/w0=;
 b=Nkmxdxhn9/k9uHfRSS2ZJ4Fzy5RgGP40gAXcl0n7A1UaGC8deV7WLgJd5n67pjuJgsWe2+
 K1zzsyUmRgFG6ZX8xFhOFpWqNxoV7PIyq4ZhpGaVLf9cmBnO/1N/WTdaOIlogzHOYuB25W
 kix5nYpnkFXdjSO4xfVJNrpNOXN8cF8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682--bHunwLfO9WqZB-MXsK75Q-1; Tue, 07 Nov 2023 13:18:52 -0500
X-MC-Unique: -bHunwLfO9WqZB-MXsK75Q-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-66d7b90c8ecso71202226d6.3
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 10:18:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699381131; x=1699985931;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+kQR7mvSV4WiG27S4G5uUiwW7A487dg3ux1TTyoQ/w0=;
 b=SlbEGGSQIiXwjTflEI/YOq3laDsQu1LXNdnJga5wP+iGQCZPay3AFiSxhij1W4gQcI
 uln29zLZyYljocmdXPBpXKoYMYQoWMLzUSoGPGOyChVzL8MHfhbFCAiVZi99JLEXb5Up
 r73L0exCXYUItz8Tl/wC/pr+baNJ/DU+W7Cl3ai2mOrJh6qAHDUEx3/ni1iR38L1D498
 7k+LRNL8WQiDeVlACd/Xgdxc8iV1HWbL7trYhmk193/P9DJE4yvuPElPbXYpMfitXNM2
 KJuARPgK2tJBYwH/fn3CajNNs798uCHunZVCAUiqQY1vo/Wd4nCV/4nYuywxPBykXank
 2gaQ==
X-Gm-Message-State: AOJu0YzB4PR5uQ8fsrK9FA6F1jd26WAwj3AafgEgR7grHEU1XQAdsOas
 nel/3L7K7ovas8y2rQLLLKMdqfxN6x2P2hXkxoDOE8ndi0YJNfVJZyhDhkl7r6YPsRNrFqLULGD
 wvI7lvIHgh3lWr/Y=
X-Received: by 2002:a05:6214:1c0c:b0:66d:3f56:ec3f with SMTP id
 u12-20020a0562141c0c00b0066d3f56ec3fmr48009042qvc.13.1699381131635; 
 Tue, 07 Nov 2023 10:18:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3NVAtR0iyMywlzqFGzZUxBogeiBPbPZn1TjFH/LnTQPI4G3pCaP2hWWuyeWbr5u3o/kAjPA==
X-Received: by 2002:a05:6214:1c0c:b0:66d:3f56:ec3f with SMTP id
 u12-20020a0562141c0c00b0066d3f56ec3fmr48009021qvc.13.1699381131343; 
 Tue, 07 Nov 2023 10:18:51 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 n3-20020a0cfbc3000000b0065b13180892sm144217qvp.16.2023.11.07.10.18.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 10:18:50 -0800 (PST)
Message-ID: <66a114d9-f575-4ed8-8e7e-606dfbb0b1c7@redhat.com>
Date: Tue, 7 Nov 2023 19:18:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 36/41] vfio: Allow the selection of a given iommu
 backend for platform ap and ccw
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com, Thomas Huth <thuth@redhat.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 "open list:S390 general arch..." <qemu-s390x@nongnu.org>
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
 <20231102071302.1818071-37-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231102071302.1818071-37-zhenzhong.duan@intel.com>
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
> Previously we added support to select iommu backend for vfio pci
> device. Now we added others, E.g: platform, ap and ccw.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

We would need an Ack from the Z team for this change.

Thanks,

C.


> ---
>   include/hw/vfio/vfio-platform.h | 1 +
>   hw/vfio/ap.c                    | 5 +++++
>   hw/vfio/ccw.c                   | 5 +++++
>   hw/vfio/platform.c              | 4 ++++
>   4 files changed, 15 insertions(+)
> 
> diff --git a/include/hw/vfio/vfio-platform.h b/include/hw/vfio/vfio-platform.h
> index c414c3dffc..f57f4276f2 100644
> --- a/include/hw/vfio/vfio-platform.h
> +++ b/include/hw/vfio/vfio-platform.h
> @@ -18,6 +18,7 @@
>   
>   #include "hw/sysbus.h"
>   #include "hw/vfio/vfio-common.h"
> +#include "sysemu/iommufd.h"
>   #include "qemu/event_notifier.h"
>   #include "qemu/queue.h"
>   #include "qom/object.h"
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index bbf69ff55a..6a4186ccd3 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -15,6 +15,7 @@
>   #include <sys/ioctl.h>
>   #include "qapi/error.h"
>   #include "hw/vfio/vfio-common.h"
> +#include "sysemu/iommufd.h"
>   #include "hw/s390x/ap-device.h"
>   #include "qemu/error-report.h"
>   #include "qemu/event_notifier.h"
> @@ -204,6 +205,10 @@ static void vfio_ap_unrealize(DeviceState *dev)
>   
>   static Property vfio_ap_properties[] = {
>       DEFINE_PROP_STRING("sysfsdev", VFIOAPDevice, vdev.sysfsdev),
> +#ifdef CONFIG_IOMMUFD
> +    DEFINE_PROP_LINK("iommufd", VFIOAPDevice, vdev.iommufd,
> +                     TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
> +#endif
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index d857bb8d0f..7695ede0fc 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -21,6 +21,7 @@
>   
>   #include "qapi/error.h"
>   #include "hw/vfio/vfio-common.h"
> +#include "sysemu/iommufd.h"
>   #include "hw/s390x/s390-ccw.h"
>   #include "hw/s390x/vfio-ccw.h"
>   #include "hw/qdev-properties.h"
> @@ -677,6 +678,10 @@ static void vfio_ccw_unrealize(DeviceState *dev)
>   static Property vfio_ccw_properties[] = {
>       DEFINE_PROP_STRING("sysfsdev", VFIOCCWDevice, vdev.sysfsdev),
>       DEFINE_PROP_BOOL("force-orb-pfch", VFIOCCWDevice, force_orb_pfch, false),
> +#ifdef CONFIG_IOMMUFD
> +    DEFINE_PROP_LINK("iommufd", VFIOCCWDevice, vdev.iommufd,
> +                     TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
> +#endif
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   
> diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
> index 8e3d4ac458..a1c25e0337 100644
> --- a/hw/vfio/platform.c
> +++ b/hw/vfio/platform.c
> @@ -649,6 +649,10 @@ static Property vfio_platform_dev_properties[] = {
>       DEFINE_PROP_UINT32("mmap-timeout-ms", VFIOPlatformDevice,
>                          mmap_timeout, 1100),
>       DEFINE_PROP_BOOL("x-irqfd", VFIOPlatformDevice, irqfd_allowed, true),
> +#ifdef CONFIG_IOMMUFD
> +    DEFINE_PROP_LINK("iommufd", VFIOPlatformDevice, vbasedev.iommufd,
> +                     TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
> +#endif
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   


