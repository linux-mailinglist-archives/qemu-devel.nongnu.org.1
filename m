Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB0BABD834
	for <lists+qemu-devel@lfdr.de>; Tue, 20 May 2025 14:29:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHM4O-0001oP-Mb; Tue, 20 May 2025 08:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uHM4L-0001nf-Qy
 for qemu-devel@nongnu.org; Tue, 20 May 2025 08:27:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uHM4H-0003qs-5O
 for qemu-devel@nongnu.org; Tue, 20 May 2025 08:27:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747744052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Q0uBJKtqFG9aeHfU7/cQsmz2LcB1zU9PRX24VkaEuyU=;
 b=Y+M/fY/l+1RvlzSR6vVwXauaNl0ljS7ZLng+XNjInqqT1GcH9HFqORs+HQyUErKKMJyx+6
 hDOksjAWsoxzWah0mvP+28R9hVwWOIBeg1oYjfeZi9ou0to39BgzqB0G7WuyvhXJTunC4M
 NUW9TMITUxssAtPTW+oYwFOk20wPql4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-9Lw8lASsMWOwLH27p39L4g-1; Tue, 20 May 2025 08:27:31 -0400
X-MC-Unique: 9Lw8lASsMWOwLH27p39L4g-1
X-Mimecast-MFC-AGG-ID: 9Lw8lASsMWOwLH27p39L4g_1747744050
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43d4d15058dso12016845e9.0
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 05:27:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747744049; x=1748348849;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q0uBJKtqFG9aeHfU7/cQsmz2LcB1zU9PRX24VkaEuyU=;
 b=H4MMXLp0xUW6XoMWBUW8Q9A7trrTl4zXNPx3WZjoQ1F24TG1D/EWzZ2V/CdpoNuuvb
 BhboS0WHOA+OHMx4r5FPiFdd02dAyW12GkqTSSmcDgArkNUL2KmclHFPdXMqYZuqYkd+
 j+4pYHfkIh2AeFwBv68ndGwaxKjnCBeuE2qaBrM16vgcAVGStjYCsDsM9fUxA8S54JRE
 uimyIHPa2a0nbFIht/xbqhpkgWfUrHz26uZ03cENwbC0H9orUe0NT9BMEue6QHyfSBbB
 jgfV2FTNYXg0Qk6kxEiifEhqzLAI6syCyrww+xcuPUaOTMaS/+v5pAC887pM4OxsIbJO
 PySw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUY+CqfTZvrpPmW+QMaOChqv7bYdFg7td82oP59GIJICTh0bHtGw1plBph1SsDPRAS1JNfLWrSFs9dL@nongnu.org
X-Gm-Message-State: AOJu0YzZJgX/OmaX16WRjY0r12Z5A5MQGYpM4Ibdly6sFoyVHi9f86/m
 /Xcwas6lr0qEkTl7Ze0+/NvDJ1WWq65HRmqE7hQvaeekd9dbKs3o1lX70BM0GF0lfC+s0CgBhvL
 xtPN3UB4gzAgZ0N1ExeW9zLUu3EwYKAbnekDOPcRoseDX60cd1Nv9ujt53iK2mgZm1TM=
X-Gm-Gg: ASbGncu7O5vxk4GBVVVS//0BvxdWs95mzxIRNtqdyjLjaLXKDh6RWQ2oTW0xJXSHVw6
 0rMtakVB6lGQ6/kphBblrE1/jwEhr8/XwMS/giTg3P+stu9gQGsvrc2ojst5A6Pl+jCme+WDk+y
 LB9LhzAMcK+zCLxdvJj2cPsTwLaJSUgRgxGwgD8jcYjPt9kWEr/gl001gvE5av0kHnt85kZzRwF
 NANTpHuf3YTPK/onbaE/Gj4cTv06vt3NxlTEO/fsdhqpbbYgNoO2D6fatgfVHxr8tUpgupwWgAp
 WNetjr1s5VcVEYjpZMHJ1SBYnmKqzARYcyTypmunbQdkIowQ/w==
X-Received: by 2002:a05:600c:64ca:b0:43d:47b7:b32d with SMTP id
 5b1f17b1804b1-442fd664a1emr122290155e9.25.1747744049578; 
 Tue, 20 May 2025 05:27:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4XQdNFIo1gLFzm1v4r/fI5vpQsXc2dPZdMdng5IXeMlGPS2pDIO2MHEr9uARBvpvUhRFJEQ==
X-Received: by 2002:a05:600c:64ca:b0:43d:47b7:b32d with SMTP id
 5b1f17b1804b1-442fd664a1emr122290035e9.25.1747744049242; 
 Tue, 20 May 2025 05:27:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f7d975f4sm28601675e9.39.2025.05.20.05.27.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 May 2025 05:27:28 -0700 (PDT)
Message-ID: <cac28777-c881-4ec5-b49a-8293019b1d33@redhat.com>
Date: Tue, 20 May 2025 14:27:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 31/42] vfio/iommufd: use IOMMU_IOAS_MAP_FILE
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-32-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1747063973-124548-32-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 5/12/25 17:32, Steve Sistare wrote:
> Use IOMMU_IOAS_MAP_FILE when the mapped region is backed by a file.
> Such a mapping can be preserved without modification during CPR,
> because it depends on the file's address space, which does not change,
> rather than on the process's address space, which does change.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   hw/vfio/container-base.c              |  9 +++++++++
>   hw/vfio/iommufd.c                     | 13 +++++++++++++
>   include/hw/vfio/vfio-container-base.h |  3 +++
>   3 files changed, 25 insertions(+)
> 
> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
> index 8f43bc8..72a51a6 100644
> --- a/hw/vfio/container-base.c
> +++ b/hw/vfio/container-base.c
> @@ -79,7 +79,16 @@ int vfio_container_dma_map(VFIOContainerBase *bcontainer,
>                              RAMBlock *rb)
>   {
>       VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
> +    int mfd = rb ? qemu_ram_get_fd(rb) : -1;
>   
> +    if (mfd >= 0 && vioc->dma_map_file) {
> +        unsigned long start = vaddr - qemu_ram_get_host_addr(rb);
> +        unsigned long offset = qemu_ram_get_fd_offset(rb);
> +
> +        vioc->dma_map_file(bcontainer, iova, size, mfd, start + offset,
> +                           readonly);
> +        return 0;
> +    }
>       g_assert(vioc->dma_map);
>       return vioc->dma_map(bcontainer, iova, size, vaddr, readonly);
>   }
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 167bda4..6eb417a 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -44,6 +44,18 @@ static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>                                      iova, size, vaddr, readonly);
>   }
>   
> +static int iommufd_cdev_map_file(const VFIOContainerBase *bcontainer,
> +                                 hwaddr iova, ram_addr_t size,
> +                                 int fd, unsigned long start, bool readonly)
> +{
> +    const VFIOIOMMUFDContainer *container =
> +        container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
> +
> +    return iommufd_backend_map_file_dma(container->be,
> +                                        container->ioas_id,
> +                                        iova, size, fd, start, readonly);
> +}
> +
>   static int iommufd_cdev_unmap(const VFIOContainerBase *bcontainer,
>                                 hwaddr iova, ram_addr_t size,
>                                 IOMMUTLBEntry *iotlb, bool unmap_all)
> @@ -802,6 +814,7 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, const void *data)
>       VFIOIOMMUClass *vioc = VFIO_IOMMU_CLASS(klass);
>   
>       vioc->dma_map = iommufd_cdev_map;
> +    vioc->dma_map_file = iommufd_cdev_map_file;
>       vioc->dma_unmap = iommufd_cdev_unmap;
>       vioc->attach_device = iommufd_cdev_attach;
>       vioc->detach_device = iommufd_cdev_detach;
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index 03b3f9c..f30f828 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -123,6 +123,9 @@ struct VFIOIOMMUClass {
>       int (*dma_map)(const VFIOContainerBase *bcontainer,
>                      hwaddr iova, ram_addr_t size,
>                      void *vaddr, bool readonly);
> +    int (*dma_map_file)(const VFIOContainerBase *bcontainer,
> +                        hwaddr iova, ram_addr_t size,
> +                        int fd, unsigned long start, bool readonly);

Please add documentation.

Thanks,

C.



>       /**
>        * @dma_unmap
>        *


