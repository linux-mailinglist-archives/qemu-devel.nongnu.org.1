Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CE3AE6D0E
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Jun 2025 18:56:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU6uz-0005aC-47; Tue, 24 Jun 2025 12:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uU6uw-0005Zz-Rw
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 12:54:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uU6uu-0002Kj-Ur
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 12:54:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750784076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Cfd0IOO2lmRirvCv4jaQ6IkBX99pWPSXixaI5CXUgC8=;
 b=e6kAlpJfyBv5NxwaqzdJ3a25sdwDCRBJCaYnfBVrdOWEk1HT8pDNT03WE+MPJjqQrhEL3I
 CjH04uOrG29l3XcX4k+QHPj9Ou38x87p1G1FbbzrulJV8lOQglYEXue+jtc5o6dEnEW7Xy
 +MkJCl/BV7HhSg3bjbHouQKKKhm3Vzs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-VHSNffBMMRmd2tiQ-A43Qw-1; Tue, 24 Jun 2025 12:54:35 -0400
X-MC-Unique: VHSNffBMMRmd2tiQ-A43Qw-1
X-Mimecast-MFC-AGG-ID: VHSNffBMMRmd2tiQ-A43Qw_1750784074
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4536962204aso14214205e9.3
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 09:54:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750784074; x=1751388874;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cfd0IOO2lmRirvCv4jaQ6IkBX99pWPSXixaI5CXUgC8=;
 b=V+96cfDu/QXLQ+wS4lfG1mWsaeT43TP4GrMj9YC9DQdhQLRHOvn1fKjz8lMr3VMpJr
 88smg50TcFHLzhzQXZuRlQ4x6C0Fekcstw4I/gnZClK0giY7HWcspNIXcEumxI4mXBtC
 5acmeQ1EiuWu1ThYryytPbHSTojvPgkuvq2Woq1D+ukTSw49rWS1kSNqZS8h6JtZIQWj
 R4V9HGluU070kLox8a9SRy1nmPViQYjXoTGM3WDo1HAa4Of7zjAQUNlMg1qu/fQYbt72
 zc+9V0qBinsvjt58obbsH5q5nT7yrGImylVAUVtAFJEXOTnotxYN82MBNFNljN2Ms1L2
 ZJwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVe/giA1SnDyydQiPxu1y+QHKqaYPiaxaggCIzg1NLcPqGU7eNZt/e55IsudJbVbPdeD1kymJL7tpZt@nongnu.org
X-Gm-Message-State: AOJu0YzLgUbwi0FcclX2eXxSAQOJ4lFjPMAWNVKvGNQ4YY82ZvrPBUMN
 hl1vZMegr9pG8A1GeDnDwr0svOMve/gksVqDW4GVAs0YkkW7+I5Oh7qdEw6nxxm0YF2DwUdUv+M
 v1RsJj+Dz9ONRlmYLwDppI1ENU24Zj1Fe8nUIxe9046grOdKbh9lC/9WY
X-Gm-Gg: ASbGncvAdQkCO3mPuY18ghPAvHrXVATOfqA9rlXuLSH9/rmVTdCmvtmb9YbeYYg80H6
 FopuEQ21MfaIuDRDnYM0aLBJ0Zh8IiXrNPLxOIWsK1KAjDKcNxYMEe5fL4oNw5mUVfpAfZvDCbb
 8MbCXoApeQdQ2Ebcftoxd9YX0VEpz/NIYsCdFB9h8ugt5MfHZxL/O9aGwsNz1z8veuTPCATJtff
 RXOh83FuMk2sNINpYDmDke0wD5vL81A0GxQO+PcQDVdDsCDC4gCWeR+SkF8xEV35zBrFA1D9C36
 /uoP1QOqhwErrd0bMQVDa5mrIjsno94pm3m+uWAEJkY/ziYqGG1lrM4aozp5
X-Received: by 2002:a05:600c:34c4:b0:450:d30e:ff96 with SMTP id
 5b1f17b1804b1-453647921f8mr197826185e9.0.1750784074196; 
 Tue, 24 Jun 2025 09:54:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmh3Bb+L1ytY8CJnrkST2Gy4OKKXOQ9jeqeCJ5YcWFZTp89Ne898jk1UEENoEbhbpwcTgp9g==
X-Received: by 2002:a05:600c:34c4:b0:450:d30e:ff96 with SMTP id
 5b1f17b1804b1-453647921f8mr197825845e9.0.1750784073761; 
 Tue, 24 Jun 2025 09:54:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4536470826fsm145416475e9.36.2025.06.24.09.54.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Jun 2025 09:54:33 -0700 (PDT)
Message-ID: <9479b426-c725-4b8c-baa9-246d0d7d1fa1@redhat.com>
Date: Tue, 24 Jun 2025 18:54:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] vfio/container: Fix potential SIGSEGV when recover
 from unmap-all-vaddr failure
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com,
 steven.sistare@oracle.com, chao.p.peng@intel.com
References: <20250623102235.94877-1-zhenzhong.duan@intel.com>
 <20250623102235.94877-4-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250623102235.94877-4-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 6/23/25 12:22, Zhenzhong Duan wrote:
> cpr.saved_dma_map isn't initialized in source qemu which lead to vioc->dma_map
> assigned a NULL value, this will trigger SIGSEGV.

I don't understand the scenario. Could you please explain more ?


> Fix it by save and restore vioc->dma_map locally.

Steve, this is cpr territory. Is it still an issue with the rest
of the patches applied ?


Thanks,

C.



> 
> Fixes: eba1f657cbb1 ("vfio/container: recover from unmap-all-vaddr failure")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/hw/vfio/vfio-cpr.h | 8 +++++---
>   hw/vfio/cpr-legacy.c       | 3 ++-
>   2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
> index 8bf85b9f4e..aef542e93c 100644
> --- a/include/hw/vfio/vfio-cpr.h
> +++ b/include/hw/vfio/vfio-cpr.h
> @@ -16,14 +16,16 @@ struct VFIOContainer;
>   struct VFIOContainerBase;
>   struct VFIOGroup;
>   
> +typedef int (*DMA_MAP_FUNC)(const struct VFIOContainerBase *bcontainer,
> +                            hwaddr iova, ram_addr_t size, void *vaddr,
> +                            bool readonly, MemoryRegion *mr);
> +
>   typedef struct VFIOContainerCPR {
>       Error *blocker;
>       bool vaddr_unmapped;
>       NotifierWithReturn transfer_notifier;
>       MemoryListener remap_listener;
> -    int (*saved_dma_map)(const struct VFIOContainerBase *bcontainer,
> -                         hwaddr iova, ram_addr_t size,
> -                         void *vaddr, bool readonly, MemoryRegion *mr);
> +    DMA_MAP_FUNC saved_dma_map;
>   } VFIOContainerCPR;
>   
>   typedef struct VFIODeviceCPR {
> diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
> index a84c3247b7..100a8db74d 100644
> --- a/hw/vfio/cpr-legacy.c
> +++ b/hw/vfio/cpr-legacy.c
> @@ -148,6 +148,7 @@ static int vfio_cpr_fail_notifier(NotifierWithReturn *notifier,
>            */
>   
>           VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
> +        DMA_MAP_FUNC saved_dma_map = vioc->dma_map;
>           vioc->dma_map = vfio_legacy_cpr_dma_map;
>   
>           container->cpr.remap_listener = (MemoryListener) {
> @@ -158,7 +159,7 @@ static int vfio_cpr_fail_notifier(NotifierWithReturn *notifier,
>                                    bcontainer->space->as);
>           memory_listener_unregister(&container->cpr.remap_listener);
>           container->cpr.vaddr_unmapped = false;
> -        vioc->dma_map = container->cpr.saved_dma_map;
> +        vioc->dma_map = saved_dma_map;
>       }
>       return 0;
>   }


