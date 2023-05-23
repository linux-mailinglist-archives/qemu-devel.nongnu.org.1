Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0597270E174
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 18:07:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1UXm-000464-0T; Tue, 23 May 2023 12:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1q1UXj-00045i-N5
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:07:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1q1UXV-0002vj-M9
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:07:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684858028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3mfdeOQeWnaYMAwkJ9izXAnyGe2WtiIGHjjDRRZiaXc=;
 b=h48vaWZ+PP/9ZQywhGYc0HFMbjJl3uY87gRqCFEzrZEwqjzY7YgzLUnX/EY4eUuY7T6eKo
 NU6G7F6AMMVRCq+7HPaefv0CTN3YV8vBHy4tolaxLCuSmyuobz67WhUhM9lXSba7BEYXul
 O1nHuNJ0nx9vbnJwghZGDwcnrSP06q0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-SJfBPfJyOTu2kdpb3IP2zg-1; Tue, 23 May 2023 12:07:07 -0400
X-MC-Unique: SJfBPfJyOTu2kdpb3IP2zg-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-62394519189so40693486d6.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 09:07:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684858026; x=1687450026;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3mfdeOQeWnaYMAwkJ9izXAnyGe2WtiIGHjjDRRZiaXc=;
 b=VAc4gNV8HN1A2pyJW+BbQVymnIAhUlIcviZWWUkRmvS7jDiBldGPbdc5O6MSjcxc1w
 hDVz1YbS78p5zko/sj2YYPzY6IAGX1SFQ1S4N506FUJ/oXyHJkl4zD/+ohYaRYDtJEq/
 4Pr+cvA50Vv/MWK3uexQ8Z8GJu3kyZQNNVOieNgIBnE63RK0Nri8M6wu+zYsSDOoZHLW
 DypckHLE63WzDjlprd7fCZiShWkMavcKsB8hpIqyBxP28ZANBxBdMudOj97F1hq5p1Mj
 hpCIQwU2ZpEzgTG3ROrjiyr8+2Hmw3ip4m6ZYiem8i2bNoZTkbmvWHh421Zp2HXdfigl
 HksA==
X-Gm-Message-State: AC+VfDyZgFnlX9L7zYAgPqJdcrAUC0SOHgDbI4m4w1n4TAlMHyD8n6M3
 c1du4wMulN/lzNF2K5mSUrs45MNkKheK9GJbtkonlOAxAEYF3yMwDW3oTFBy1HV1j3XAOoQNzkp
 chaqvKxGJechS0Jc=
X-Received: by 2002:a05:6214:2526:b0:621:1c72:af3 with SMTP id
 gg6-20020a056214252600b006211c720af3mr26965493qvb.0.1684858026633; 
 Tue, 23 May 2023 09:07:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4KcwJO4aeog28NHPlAkIImyI8P8opjVQtwtiwVTU92is0pc1y0haeqxKnq5ua1mu+aPXsTwQ==
X-Received: by 2002:a05:6214:2526:b0:621:1c72:af3 with SMTP id
 gg6-20020a056214252600b006211c720af3mr26965463qvb.0.1684858026351; 
 Tue, 23 May 2023 09:07:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 c17-20020a0cd611000000b00623839cba8csm2893055qvj.44.2023.05.23.09.07.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 09:07:05 -0700 (PDT)
Message-ID: <d5cce13f-3e90-6699-90da-b2befdc7e1d5@redhat.com>
Date: Tue, 23 May 2023 18:07:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 1/2] exec/ram_addr: add dirty arg to
 cpu_physical_memory_set_dirty_lebitmap()
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>, Avihai Horon <avihaih@nvidia.com>
References: <20230523151217.46427-1-joao.m.martins@oracle.com>
 <20230523151217.46427-2-joao.m.martins@oracle.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230523151217.46427-2-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 5/23/23 17:12, Joao Martins wrote:
> In preparation to including the number of dirty pages in the
> vfio_get_dirty_bitmap() tracepoint, return the number of dirty pages in the
> range passed by @dirty argument in cpu_physical_memory_set_dirty_lebitmap().
> 
> For now just set the callers to NULL, no functional change intended.

Why not return the number of dirty pages to be consistent with
cpu_physical_memory_sync_dirty_bitmap () ?

bitmap_count_one() would also give the same result but at the cost
of extra loops.

Thanks,

C.

> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>   accel/kvm/kvm-all.c     |  2 +-
>   hw/vfio/common.c        |  4 ++--
>   include/exec/ram_addr.h | 10 +++++++++-
>   3 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index cf3a88d90e92..1524a34f1786 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -559,7 +559,7 @@ static void kvm_slot_sync_dirty_pages(KVMSlot *slot)
>       ram_addr_t start = slot->ram_start_offset;
>       ram_addr_t pages = slot->memory_size / qemu_real_host_page_size();
>   
> -    cpu_physical_memory_set_dirty_lebitmap(slot->dirty_bmap, start, pages);
> +    cpu_physical_memory_set_dirty_lebitmap(slot->dirty_bmap, start, pages, NULL);
>   }
>   
>   static void kvm_slot_reset_dirty_pages(KVMSlot *slot)
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 78358ede2764..dcbf7c574d85 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -587,7 +587,7 @@ static int vfio_dma_unmap_bitmap(VFIOContainer *container,
>       ret = ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, unmap);
>       if (!ret) {
>           cpu_physical_memory_set_dirty_lebitmap(vbmap.bitmap,
> -                iotlb->translated_addr, vbmap.pages);
> +                iotlb->translated_addr, vbmap.pages, NULL);
>       } else {
>           error_report("VFIO_UNMAP_DMA with DIRTY_BITMAP : %m");
>       }
> @@ -1773,7 +1773,7 @@ static int vfio_get_dirty_bitmap(VFIOContainer *container, uint64_t iova,
>       }
>   
>       cpu_physical_memory_set_dirty_lebitmap(vbmap.bitmap, ram_addr,
> -                                           vbmap.pages);
> +                                           vbmap.pages, NULL);
>   
>       trace_vfio_get_dirty_bitmap(container->fd, iova, size, vbmap.size,
>                                   ram_addr);
> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> index f4fb6a211175..07bf9e1502b6 100644
> --- a/include/exec/ram_addr.h
> +++ b/include/exec/ram_addr.h
> @@ -335,7 +335,8 @@ static inline void cpu_physical_memory_set_dirty_range(ram_addr_t start,
>   #if !defined(_WIN32)
>   static inline void cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
>                                                             ram_addr_t start,
> -                                                          ram_addr_t pages)
> +                                                          ram_addr_t pages,
> +                                                          unsigned long *dirty)
>   {
>       unsigned long i, j;
>       unsigned long page_number, c;
> @@ -380,6 +381,10 @@ static inline void cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
>                           }
>                       }
>   
> +                    if (dirty) {
> +                        *dirty += ctpopl(temp);
> +                    }
> +
>                       if (tcg_enabled()) {
>                           qatomic_or(&blocks[DIRTY_MEMORY_CODE][idx][offset],
>                                      temp);
> @@ -411,6 +416,9 @@ static inline void cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
>                   if (unlikely(global_dirty_tracking & GLOBAL_DIRTY_DIRTY_RATE)) {
>                       total_dirty_pages += ctpopl(c);
>                   }
> +                if (dirty) {
> +                    *dirty += ctpopl(c);
> +                }
>                   do {
>                       j = ctzl(c);
>                       c &= ~(1ul << j);


