Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F05F6BEFFE8
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Oct 2025 10:39:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAlQF-0007yW-O8; Mon, 20 Oct 2025 04:39:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vAlQC-0007y1-Ub
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 04:39:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vAlQ5-0000bG-Hy
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 04:39:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760949545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dBQrsLNVS9YVCxdzpk+v0Ay5S1S/5HQo0KlEN+ttWWU=;
 b=a2xpY6CRueDegCUhlGKerGCSiuOJYs51QGkVnZgsbp2nEZxnXDNxbeuWgbizgDchMPdtEh
 IDllOm0WFvi+dK4hxdbWTuV0tna/UHunFnrCiggakgATBOpAJqIz34yfKMo6cxMGW2B8e4
 woqwd6WOS/S8/VgzWGgrOC8BXQe0Grk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-b_RKznHaPPWJ1b006pMb3A-1; Mon, 20 Oct 2025 04:39:04 -0400
X-MC-Unique: b_RKznHaPPWJ1b006pMb3A-1
X-Mimecast-MFC-AGG-ID: b_RKznHaPPWJ1b006pMb3A_1760949543
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-42700160169so2158613f8f.1
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 01:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760949543; x=1761554343;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dBQrsLNVS9YVCxdzpk+v0Ay5S1S/5HQo0KlEN+ttWWU=;
 b=LFovFsW3vzbLl06ILKWxrrj+KJYjWvg3v2DlE+is3VSWgN3qBybxyLeFlr2EDLKf5U
 ROWfaRVkqG0dgQebhi4K8mYZ8+gqERAg4rQDRfvgn3/gckIoBoluHs99EAHxZgpNh9Vp
 FZDCEcNRKnqFT54EfTluPSZgrwAIbn4tSXfsueWttLKazquY58CUg/hifrEM05y4me9t
 e6Kmp6wUyDxgXuddNE4ZzjFSos8+x5vvudkzmxJFn8w6wgTarvDnJpjHZh7pZrL/w7Q9
 X2DZsbpDcIVkw7vvlh+Ur0ke6DYA9U/Gao6i5z3GQYyAo/facnRIDi0dt1j5gDPywyqq
 VelQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVx7FKYjHAP8Zlj6RL4yNu4OIEqbChzvUYsHmJlAjoT3ZM/36muklbZE6h1JIZECFKYjSWXytDu01Jk@nongnu.org
X-Gm-Message-State: AOJu0YyR84cWC6iVoCDYOTriJaU64rkG7GFxnUuvBwo94ulWvcp5PPHe
 wibSDPbtNu+zWbjXCXOeCH2X8x9kU6bCgAIRh8EsDcx+bJM65PwGDT5RRiWPEsrsVs0IaY+c4YZ
 Fl8cOkdvOd/zTGy40/GF1HktWjB7ftQ1ZUAvdZdjCZ83mVNZrTHhy4SiW
X-Gm-Gg: ASbGnctOKvWNHPAkcpiNu0tdfmxoLQt/gYUjn9Vad/tzH105r+jtru4l7nqv//NfH5G
 1iuQABxGtpDrEJuIgj2ilRwHPDucoxHgAWPe7UpFs7wP7n2jcAEKBSHQ3phl+ppardB6YyQZR4d
 ir1QAVQ3OVBwZaJ1xCEaoYUt0+m6lkgy4ZeBWcn8ZIbzFr1uHJzsfIMD4xAVYPgNF7H4/tvpmN+
 MNgthoRsXktvh0YDxzj5GSmhjvqjtoWqTQQWe7zjz+p4JbHieWqa3v0U2K2e0pdSQuh4PO0F3gB
 l+UYbfhHzOulHpjQQ0EwO2if+YsBTcwK7cG5fiwaLNDem0YX0MTJxF5s3SmekBNjkFboH6JVvr1
 iNKwtSFvnF3zHLkrFwrL60sAAM6ZH4XFoHcS1UQ==
X-Received: by 2002:a05:6000:4013:b0:427:6c6:4982 with SMTP id
 ffacd0b85a97d-42706c64a96mr7973714f8f.44.1760949543121; 
 Mon, 20 Oct 2025 01:39:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSG6Uw5Mavy5WETng2DuMRCBK8IDIvssOU4+rxwkW8feQ/Ovy9GJd968kEbQ8d68FLma06Ig==
X-Received: by 2002:a05:6000:4013:b0:427:6c6:4982 with SMTP id
 ffacd0b85a97d-42706c64a96mr7973684f8f.44.1760949542679; 
 Mon, 20 Oct 2025 01:39:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f00b988dsm14476517f8f.35.2025.10.20.01.39.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 01:39:02 -0700 (PDT)
Message-ID: <46047169-739f-4045-a7c0-91d377dfff6e@redhat.com>
Date: Mon, 20 Oct 2025 10:39:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] vfio/migration: Add migration blocker if VM memory
 is too large to cause unmap_bitmap failure
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, mst@redhat.com, jasowang@redhat.com,
 yi.l.liu@intel.com, clement.mathieu--drif@eviden.com, eric.auger@redhat.com,
 joao.m.martins@oracle.com, avihaih@nvidia.com, xudong.hao@intel.com,
 giovanni.cabiddu@intel.com, mark.gross@intel.com, arjan.van.de.ven@intel.com
References: <20251017082234.517827-1-zhenzhong.duan@intel.com>
 <20251017082234.517827-8-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251017082234.517827-8-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/17/25 10:22, Zhenzhong Duan wrote:
> With default config, kernel VFIO type1 driver limits dirty bitmap to 256MB


... VFIO IOMMU Type1 ...

> for unmap_bitmap ioctl so the maximum guest memory region is no more than
> 8TB size for the ioctl to succeed.
> 
> Be conservative here to limit total guest memory to 8TB or else add a
> migration blocker. IOMMUFD backend doesn't have such limit, one can use
> IOMMUFD backed device if there is a need to migration such large VM.
> 
> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/vfio/migration.c | 37 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 37 insertions(+)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 4c06e3db93..1106ca7857 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -16,6 +16,7 @@
>   #include <sys/ioctl.h>
>   
>   #include "system/runstate.h"
> +#include "hw/boards.h"
>   #include "hw/vfio/vfio-device.h"
>   #include "hw/vfio/vfio-migration.h"
>   #include "migration/misc.h"
> @@ -1152,6 +1153,35 @@ static bool vfio_viommu_preset(VFIODevice *vbasedev)
>       return vbasedev->bcontainer->space->as != &address_space_memory;
>   }
>   
> +static bool vfio_dirty_tracking_exceed_limit(VFIODevice *vbasedev)
> +{
> +    VFIOContainer *bcontainer = vbasedev->bcontainer;
> +    uint64_t max_size, page_size;
> +
> +    if (!object_dynamic_cast(OBJECT(bcontainer), TYPE_VFIO_IOMMU_LEGACY)) {
> +        return false;
> +    }


Could we set in the IOMMUFD backend 'dirty_pgsizes' and
'max_dirty_bitmap_size'to avoid the object_dynamic_cast() ?


Thanks,

C.


> +    if (!bcontainer->dirty_pages_supported) {
> +        return true;
> +    }
> +    /*
> +     * VFIO type1 driver has a limitation of bitmap size on unmap_bitmap
> +     * ioctl(), calculate the limit and compare with guest memory size to
> +     * catch dirty tracking failure early.
> +     *
> +     * This limit is 8TB with default kernel and QEMU config, we are a bit
> +     * conservative here as VM memory layout may be nonconsecutive or VM
> +     * can run with vIOMMU enabled so the limitation could be relaxed. One
> +     * can also switch to use IOMMUFD backend if there is a need to migrate
> +     * large VM.
> +     */
> +    page_size = 1 << ctz64(bcontainer->dirty_pgsizes);
> +    max_size = bcontainer->max_dirty_bitmap_size * BITS_PER_BYTE * page_size;
> +
> +    return current_machine->ram_size > max_size;
> +}
> +
>   /*
>    * Return true when either migration initialized or blocker registered.
>    * Currently only return false when adding blocker fails which will
> @@ -1208,6 +1238,13 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>           goto add_blocker;
>       }
>   
> +    if (vfio_dirty_tracking_exceed_limit(vbasedev)) {
> +        error_setg(&err, "%s: Migration is currently not supported with "
> +                   "large memory VM due to dirty tracking limitation in "
> +                   "VFIO type1 driver", vbasedev->name);
> +        goto add_blocker;
> +    }
> +
>       trace_vfio_migration_realize(vbasedev->name);
>       return true;
>   


