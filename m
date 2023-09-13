Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C840A79E840
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 14:44:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgPDd-0001u7-1M; Wed, 13 Sep 2023 08:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qgPDX-0001tY-2X
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 08:43:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qgPDS-0008Fw-Hq
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 08:43:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694609012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YvKIKk0ky3N1Enqzc7pT50BpAjuxneCzRPnDEwm0LGo=;
 b=eTmttCsntG79JvH0ZFsw0NWqE2ObBvcm8vB1MJPNPC+uGCu0CZ0IxDOfGiXT55uVeF7enu
 j4jh4e8TGU6auY3dJmY/0W2qlGXPXGPOhLhJ+B5Ge3I3K96/CrKrODjkzldkNvG6jgLvap
 EUCsqDJjiEo8fg1sHOxOuFnlyiTQA+U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-UQkM8g9vMtSMtoBYLrmf4g-1; Wed, 13 Sep 2023 08:43:31 -0400
X-MC-Unique: UQkM8g9vMtSMtoBYLrmf4g-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-401c19fc097so52879945e9.1
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 05:43:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694609010; x=1695213810;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YvKIKk0ky3N1Enqzc7pT50BpAjuxneCzRPnDEwm0LGo=;
 b=R2iFNeClSLiMdTXlhKCbjYvOk2rJYlbClWioq+TCqy8WPzzIK1FPvTzYvsL4SYhJHV
 b8Cy9e/OTxUFVfTw1i/QJQQGv8uW8/AXqJkSCnLqeczOq09b4tobP9iE16+qTEEyiggI
 g6kwRDLA+ZNM5aKvkR4LbgWOOxrgCdEkRy93MJ+ka9R22O6wGQXu4uvT5RXSBwUGpIb7
 xrhIYSc2xvJdTWRmthWBZVpJsuY/LhHmYJKFFXsOuBdtOYZLYgHttM3WgzHA8PVMCds8
 Pk3xL4ONkpfRvVOiMpz2Z+NpH5NosTIfjBdxeXe8gsgaZMQt2BVJyCLys2ESJy+2IInX
 9l0g==
X-Gm-Message-State: AOJu0Yxo4PKTJtQS0B3GXxztlZ3FG5mNcBs0jFJ0NR65GlztOzrL0egW
 Ft6xKSmlJ7vVH9a6G7l9DF5eiKgMCFQOl7PU5OL9CljVVER7p8WzEF4/e+qG82AOlZjnG9+++U6
 LAHHV0YsehoJm9hE=
X-Received: by 2002:a5d:4bc9:0:b0:31f:918a:b097 with SMTP id
 l9-20020a5d4bc9000000b0031f918ab097mr1879599wrt.63.1694609010390; 
 Wed, 13 Sep 2023 05:43:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGU9x1W0/w1zrkAO7p2LAjaOMEb27g12/GRQmoInQSR0+qaAxc60j95kzCtB5iOs+5INIHU+g==
X-Received: by 2002:a5d:4bc9:0:b0:31f:918a:b097 with SMTP id
 l9-20020a5d4bc9000000b0031f918ab097mr1879574wrt.63.1694609010061; 
 Wed, 13 Sep 2023 05:43:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 v17-20020a5d6791000000b00318147fd2d3sm15419098wru.41.2023.09.13.05.43.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Sep 2023 05:43:29 -0700 (PDT)
Message-ID: <edb0bda2-2f90-c8f1-4324-44f70357ddf6@redhat.com>
Date: Wed, 13 Sep 2023 14:43:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 01/12] memory: Let ReservedRegion use Range
Content-Language: en-US
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, alex.williamson@redhat.com,
 jean-philippe@linaro.org, mst@redhat.com, pbonzini@redhat.com
Cc: peter.maydell@linaro.org, peterx@redhat.com, david@redhat.com,
 philmd@linaro.org
References: <20230913080423.523953-1-eric.auger@redhat.com>
 <20230913080423.523953-2-eric.auger@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230913080423.523953-2-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 9/13/23 10:01, Eric Auger wrote:
> A reserved region is a range tagged with a type. Let's directly use
> the Range type in the prospect to reuse some of the library helpers
> shipped with the Range type.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> 
> ---
> 
> v1 -> v2:
> - Added Philippe and David's R-b
> ---
>   include/exec/memory.h            | 4 ++--
>   hw/core/qdev-properties-system.c | 9 ++++++---
>   hw/virtio/virtio-iommu.c         | 6 +++---
>   3 files changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 68284428f8..184cb3a01b 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -24,6 +24,7 @@
>   #include "qemu/bswap.h"
>   #include "qemu/queue.h"
>   #include "qemu/int128.h"
> +#include "qemu/range.h"
>   #include "qemu/notify.h"
>   #include "qom/object.h"
>   #include "qemu/rcu.h"
> @@ -79,8 +80,7 @@ extern unsigned int global_dirty_tracking;
>   typedef struct MemoryRegionOps MemoryRegionOps;
>   
>   struct ReservedRegion {
> -    hwaddr low;
> -    hwaddr high;
> +    Range range;
>       unsigned type;
>   };
>   
> diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
> index 6d5d43eda2..8d486eeefd 100644
> --- a/hw/core/qdev-properties-system.c
> +++ b/hw/core/qdev-properties-system.c
> @@ -699,7 +699,7 @@ static void get_reserved_region(Object *obj, Visitor *v, const char *name,
>       int rc;
>   
>       rc = snprintf(buffer, sizeof(buffer), "0x%"PRIx64":0x%"PRIx64":%u",
> -                  rr->low, rr->high, rr->type);
> +                  range_lob(&rr->range), range_upb(&rr->range), rr->type);
>       assert(rc < sizeof(buffer));
>   
>       visit_type_str(v, name, &p, errp);
> @@ -711,6 +711,7 @@ static void set_reserved_region(Object *obj, Visitor *v, const char *name,
>       Property *prop = opaque;
>       ReservedRegion *rr = object_field_prop_ptr(obj, prop);
>       const char *endptr;
> +    uint64_t lob, upb;
>       char *str;
>       int ret;
>   
> @@ -718,7 +719,7 @@ static void set_reserved_region(Object *obj, Visitor *v, const char *name,
>           return;
>       }
>   
> -    ret = qemu_strtou64(str, &endptr, 16, &rr->low);
> +    ret = qemu_strtou64(str, &endptr, 16, &lob);
>       if (ret) {
>           error_setg(errp, "start address of '%s'"
>                      " must be a hexadecimal integer", name);
> @@ -728,7 +729,7 @@ static void set_reserved_region(Object *obj, Visitor *v, const char *name,
>           goto separator_error;
>       }
>   
> -    ret = qemu_strtou64(endptr + 1, &endptr, 16, &rr->high);
> +    ret = qemu_strtou64(endptr + 1, &endptr, 16, &upb);
>       if (ret) {
>           error_setg(errp, "end address of '%s'"
>                      " must be a hexadecimal integer", name);
> @@ -738,6 +739,8 @@ static void set_reserved_region(Object *obj, Visitor *v, const char *name,
>           goto separator_error;
>       }
>   
> +    range_set_bounds(&rr->range, lob, upb);
> +
>       ret = qemu_strtoui(endptr + 1, &endptr, 10, &rr->type);
>       if (ret) {
>           error_setg(errp, "type of '%s'"
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index be51635895..e5e46e1b55 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -645,8 +645,8 @@ static ssize_t virtio_iommu_fill_resv_mem_prop(VirtIOIOMMU *s, uint32_t ep,
>           prop.head.type = cpu_to_le16(VIRTIO_IOMMU_PROBE_T_RESV_MEM);
>           prop.head.length = cpu_to_le16(length);
>           prop.subtype = subtype;
> -        prop.start = cpu_to_le64(s->reserved_regions[i].low);
> -        prop.end = cpu_to_le64(s->reserved_regions[i].high);
> +        prop.start = cpu_to_le64(range_lob(&s->reserved_regions[i].range));
> +        prop.end = cpu_to_le64(range_upb(&s->reserved_regions[i].range));
>   
>           memcpy(buf, &prop, size);
>   
> @@ -897,7 +897,7 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>       for (i = 0; i < s->nb_reserved_regions; i++) {
>           ReservedRegion *reg = &s->reserved_regions[i];
>   
> -        if (addr >= reg->low && addr <= reg->high) {
> +        if (range_contains(&reg->range, addr)) {
>               switch (reg->type) {
>               case VIRTIO_IOMMU_RESV_MEM_T_MSI:
>                   entry.perm = flag;


