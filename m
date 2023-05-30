Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EED7715831
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 10:18:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3uXr-0006a8-Pc; Tue, 30 May 2023 04:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1q3uXn-0006Zf-Mh
 for qemu-devel@nongnu.org; Tue, 30 May 2023 04:17:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1q3uXk-0001Et-SO
 for qemu-devel@nongnu.org; Tue, 30 May 2023 04:17:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685434643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4NG0efD2OUSaqogSuIVbE0tOXonEvTUyP5lIfJd4VjM=;
 b=W5RHpUtaIpdUIydxhUXvXCbpzN4T1Ge9sJPVS1+75w64t9T+XKuv6wA2v1nVjQpwD/9vUi
 fwMQUhhm+ITauOxS7/hnc0bOIJS8NcNJKBzu9omVeAyTNX8qj5VHs3lwjlmNxZqVcIrfH+
 f37XXURN+Z21Zgt80YixCDrEDA14Yso=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-7J6SsdaWNC-xh1yuXFicjg-1; Tue, 30 May 2023 04:17:22 -0400
X-MC-Unique: 7J6SsdaWNC-xh1yuXFicjg-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6260d4a9802so21966006d6.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 01:17:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685434641; x=1688026641;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4NG0efD2OUSaqogSuIVbE0tOXonEvTUyP5lIfJd4VjM=;
 b=YCOQCmkr10/2rVLMUFcCbOLj7SmXOQtFTW0JM2duKrXZ2z880hKcYDOafoHyrvWLMf
 JJqolvj7Cs0JWuJGb/Hm6eknBplM9O7f8xUgV2pahYyerPvSG6Kq+djeRn4C8Hx1chxb
 3I9a6dClnAp4DPP/Zz9q5z0fDGhDosF0rRofml455T1b7B13yQwCfY5Y0iQXMwQcUh1e
 ST+XBO0H8kUhhCLZ1MNo6BP9Zgk39o96msZv+6AA7LwUEByGBnEc5fWVRLA7TErErGez
 4iPi6BI2sNamQuWq+e4QYEnLHN0iyom0p8Rc8EN2zzjILCUmHGRJgiPJUNCrCmFPg+3o
 YIlg==
X-Gm-Message-State: AC+VfDw0PkH2yVXurnCPPaqRJ7sr/DGVkG01BUs+2i//9fav2XLCfSt6
 Lpky61Ci2x/46kqchKrfhaIctjqQl6sJswqAgdGJZMFlqm7meQQ/qahTNhkTCd8SajwZYR0j1JJ
 r2UViV6Klkf9cZhg=
X-Received: by 2002:a05:6214:c4a:b0:623:9218:58e5 with SMTP id
 r10-20020a0562140c4a00b00623921858e5mr1418958qvj.39.1685434641558; 
 Tue, 30 May 2023 01:17:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5FmxydCLYdHYNFN7Dn42tudcsIQ3tSjGqm+v/o3d8C83ptBbfN9r7BVEQqrm91wQ3N3X4xgA==
X-Received: by 2002:a05:6214:c4a:b0:623:9218:58e5 with SMTP id
 r10-20020a0562140c4a00b00623921858e5mr1418944qvj.39.1685434641137; 
 Tue, 30 May 2023 01:17:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:eb4a:c9d8:c8bb:c0b0?
 ([2a01:e0a:280:24f0:eb4a:c9d8:c8bb:c0b0])
 by smtp.gmail.com with ESMTPSA id
 m12-20020a0cf18c000000b0062612555850sm2820952qvl.70.2023.05.30.01.17.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 01:17:20 -0700 (PDT)
Message-ID: <e50227ec-0d10-0d02-0760-c1ef1fd6749e@redhat.com>
Date: Tue, 30 May 2023 10:17:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 2/2] hw/vfio: Add nr of dirty pages to
 vfio_get_dirty_bitmap tracepoint
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>, Avihai Horon <avihaih@nvidia.com>
References: <20230529121114.5038-1-joao.m.martins@oracle.com>
 <20230529121114.5038-3-joao.m.martins@oracle.com>
Content-Language: en-US
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230529121114.5038-3-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 5/29/23 14:11, Joao Martins wrote:
> Include the number of dirty pages on the vfio_get_dirty_bitmap tracepoint.
> These are fetched from the newly added return value in
> cpu_physical_memory_set_lebitmap().
> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/common.c     | 7 ++++---
>   hw/vfio/trace-events | 2 +-
>   2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 78358ede2764..fa8fd949b1cf 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1747,6 +1747,7 @@ static int vfio_get_dirty_bitmap(VFIOContainer *container, uint64_t iova,
>   {
>       bool all_device_dirty_tracking =
>           vfio_devices_all_device_dirty_tracking(container);
> +    uint64_t dirty_pages;
>       VFIOBitmap vbmap;
>       int ret;
>   
> @@ -1772,11 +1773,11 @@ static int vfio_get_dirty_bitmap(VFIOContainer *container, uint64_t iova,
>           goto out;
>       }
>   
> -    cpu_physical_memory_set_dirty_lebitmap(vbmap.bitmap, ram_addr,
> -                                           vbmap.pages);
> +    dirty_pages = cpu_physical_memory_set_dirty_lebitmap(vbmap.bitmap, ram_addr,
> +                                                         vbmap.pages);
>   
>       trace_vfio_get_dirty_bitmap(container->fd, iova, size, vbmap.size,
> -                                ram_addr);
> +                                ram_addr, dirty_pages);
>   out:
>       g_free(vbmap.bitmap);
>   
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 646e42fd27f9..cfb60c354de3 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -120,7 +120,7 @@ vfio_region_sparse_mmap_header(const char *name, int index, int nr_areas) "Devic
>   vfio_region_sparse_mmap_entry(int i, unsigned long start, unsigned long end) "sparse entry %d [0x%lx - 0x%lx]"
>   vfio_get_dev_region(const char *name, int index, uint32_t type, uint32_t subtype) "%s index %d, %08x/%08x"
>   vfio_dma_unmap_overflow_workaround(void) ""
> -vfio_get_dirty_bitmap(int fd, uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t start) "container fd=%d, iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64
> +vfio_get_dirty_bitmap(int fd, uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t start, uint64_t dirty_pages) "container fd=%d, iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64" dirty_pages=%"PRIu64
>   vfio_iommu_map_dirty_notify(uint64_t iova_start, uint64_t iova_end) "iommu dirty @ 0x%"PRIx64" - 0x%"PRIx64
>   
>   # platform.c


