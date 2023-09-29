Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A646C7B37B3
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 18:17:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmG9m-0002Jo-Ib; Fri, 29 Sep 2023 12:15:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1qmG9h-0002Dg-CW
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 12:15:55 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1qmG9c-00068K-S4
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 12:15:51 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-405361bb94eso146396735e9.0
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 09:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696004143; x=1696608943; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XmjgxynS7T2huqwYRCz4Z4N+aHQaM/GLyfynKvGw/lc=;
 b=uWWaYnTbLA3yZNej1pqHX66LR0BH5Ty42UPqHXrogjS5qc4XxS6BXm/whlsizx6RMf
 IVzWbyBtligB/tDuG/KEQIatV28dPr8RnS0FEmLCnqptfMsXwSQleL8Xjic6jXNwc74h
 9FSh6Qbaa4Cxpz5yzFxcPpdV2SFzSn8NcJHmytfPAOOy/sZj4IUtfEyDZRsGg+Vq/UNu
 YRbuDhqXCDvixvyz2yiL5PHWBPC4eq+j364z2CvEJJwfc6iu1gIXITq7e4WcYEGhdJgw
 M7ZbQKdR/G7zrp3jLYpbTY1a8022PgM/ewaejvcSipkBTUFZ+hmIohnlunpcrH29kJMD
 QE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696004143; x=1696608943;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XmjgxynS7T2huqwYRCz4Z4N+aHQaM/GLyfynKvGw/lc=;
 b=sOVxrG+KRcQK3mjOoRnEdSzAgicE9iIJkv+2AtktCYPlsns8h66x50VWta7qs8DdKl
 sdOTVoK7/WrZAUR+r1e6jWDkkFKKQalajp+Of4wKvwuRpyPvVMY0OJqjN1ZiQ9kI0DO+
 X/RCVK22gwo46E+kywdZlmd9o2nY8E7RbCspnEqelTZXZOcNzv+OT4Qos1ic5kE5Up9D
 tkoGCOYN1bPJxWcwtfTLMDczV+FaKq6JP1nq0IfiJcmy6zFiFAJZJ77+zBhxd0+uNamO
 k0W+l53LQWzqaaLyoF1LMT9ZjWnXbPl0cz4F/zKa7VgeeOvpakhu+PSvEuO86U8pZ0iz
 Pu0A==
X-Gm-Message-State: AOJu0Yw7eeZn1e/9HBGUwhJN4E/RLHKXyGJYx60Lw30zYUHJygWVRhP1
 pTshOQsNufISOKpUaBiIseH/8g==
X-Google-Smtp-Source: AGHT+IF0D6ea0U+u0fw3SNMJ9KOavgZ7Y0OyrRegCWedGwQHTdmD5cE5F+fZtHp/JYx6H5itLsQ3jg==
X-Received: by 2002:a05:600c:3b0e:b0:406:53ab:a9af with SMTP id
 m14-20020a05600c3b0e00b0040653aba9afmr4128189wms.10.1696004143361; 
 Fri, 29 Sep 2023 09:15:43 -0700 (PDT)
Received: from myrica ([2a02:c7c:7290:b00:fd32:2b31:6755:400c])
 by smtp.gmail.com with ESMTPSA id
 o14-20020a05600c4fce00b004065d67c3c9sm1666582wmq.8.2023.09.29.09.15.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Sep 2023 09:15:42 -0700 (PDT)
Date: Fri, 29 Sep 2023 17:15:47 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, peterx@redhat.com,
 david@redhat.com, philmd@linaro.org
Subject: Re: [PATCH v2 07/12] virtio-iommu: Implement set_iova_ranges()
 callback
Message-ID: <20230929161547.GB2957297@myrica>
References: <20230913080423.523953-1-eric.auger@redhat.com>
 <20230913080423.523953-8-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913080423.523953-8-eric.auger@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Sep 13, 2023 at 10:01:42AM +0200, Eric Auger wrote:
> The implementation populates the array of per IOMMUDevice
> host reserved regions.
> 
> It is forbidden to have conflicting sets of host IOVA ranges
> to be applied onto the same IOMMU MR (implied by different
> host devices).
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> v1 -> v2:
> - Forbid conflicting sets of host resv regions
> ---
>  include/hw/virtio/virtio-iommu.h |  2 ++
>  hw/virtio/virtio-iommu.c         | 48 ++++++++++++++++++++++++++++++++
>  2 files changed, 50 insertions(+)
> 
> diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
> index 70b8ace34d..31b69c8261 100644
> --- a/include/hw/virtio/virtio-iommu.h
> +++ b/include/hw/virtio/virtio-iommu.h
> @@ -40,6 +40,8 @@ typedef struct IOMMUDevice {
>      MemoryRegion root;          /* The root container of the device */
>      MemoryRegion bypass_mr;     /* The alias of shared memory MR */
>      GList *resv_regions;
> +    Range *host_resv_regions;
> +    uint32_t nr_host_resv_regions;
>  } IOMMUDevice;
>  
>  typedef struct IOMMUPciBus {
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index ea359b586a..ed2df5116f 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -20,6 +20,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu/log.h"
>  #include "qemu/iov.h"
> +#include "qemu/range.h"
>  #include "exec/target_page.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/virtio/virtio.h"
> @@ -1158,6 +1159,52 @@ static int virtio_iommu_set_page_size_mask(IOMMUMemoryRegion *mr,
>      return 0;
>  }
>  
> +static int virtio_iommu_set_iova_ranges(IOMMUMemoryRegion *mr,
> +                                        uint32_t nr_ranges,
> +                                        struct Range *iova_ranges,
> +                                        Error **errp)
> +{
> +    IOMMUDevice *sdev = container_of(mr, IOMMUDevice, iommu_mr);
> +    uint32_t nr_host_resv_regions;
> +    Range *host_resv_regions;
> +    int ret = -EINVAL;
> +
> +    if (!nr_ranges) {
> +        return 0;
> +    }
> +
> +    if (sdev->host_resv_regions) {
> +        range_inverse_array(nr_ranges, iova_ranges,
> +                            &nr_host_resv_regions, &host_resv_regions,
> +                            0, UINT64_MAX);
> +        if (nr_host_resv_regions != sdev->nr_host_resv_regions) {
> +            goto error;
> +        }
> +        for (int i = 0; i < nr_host_resv_regions; i++) {
> +            Range *new = &host_resv_regions[i];
> +            Range *existing = &sdev->host_resv_regions[i];
> +
> +            if (!range_contains_range(existing, new)) {
> +                goto error;
> +            }
> +        }
> +        ret = 0;
> +        goto out;
> +    }
> +
> +    range_inverse_array(nr_ranges, iova_ranges,
> +                        &sdev->nr_host_resv_regions, &sdev->host_resv_regions,
> +                        0, UINT64_MAX);

Can set_iova_ranges() only be called for the first time before the guest
has had a chance to issue a probe request?  Maybe we could add a
sanity-check that the guest hasn't issued a probe request yet, since we
can't notify about updated reserved regions.

I'm probably misremembering because I thought Linux set up IOMMU contexts
(including probe requests) before enabling DMA master in PCI which cause
QEMU VFIO to issue these calls. I'll double check.

Thanks,
Jean

> +
> +    return 0;
> +error:
> +    error_setg(errp, "IOMMU mr=%s Conflicting host reserved regions set!",
> +               mr->parent_obj.name);
> +out:
> +    g_free(host_resv_regions);
> +    return ret;
> +}
> +
>  static void virtio_iommu_system_reset(void *opaque)
>  {
>      VirtIOIOMMU *s = opaque;
> @@ -1453,6 +1500,7 @@ static void virtio_iommu_memory_region_class_init(ObjectClass *klass,
>      imrc->replay = virtio_iommu_replay;
>      imrc->notify_flag_changed = virtio_iommu_notify_flag_changed;
>      imrc->iommu_set_page_size_mask = virtio_iommu_set_page_size_mask;
> +    imrc->iommu_set_iova_ranges = virtio_iommu_set_iova_ranges;
>  }
>  
>  static const TypeInfo virtio_iommu_info = {
> -- 
> 2.41.0
> 

