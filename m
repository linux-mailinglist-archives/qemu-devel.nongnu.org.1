Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11069A995FC
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Apr 2025 19:03:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7dTh-0000xh-Hu; Wed, 23 Apr 2025 13:01:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7dTa-0000wS-IC
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 13:01:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7dTY-0007AL-JX
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 13:01:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745427690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mu3HptekOhWiVNDp0Cso9QaBLEWByzK3MwBqQkQ9lfg=;
 b=CULvjTuf1XSaaIC1sQS33GqXqkfrTgfZpzUSPfxH52AdpH2SIkVFN9Do0X0k8fwfL0aVNP
 h2ZWh7j2XPNWDfpb++2jph+EZZeDvzYMhXvwpQ6N9wyViRCiOgRUQKYFqkwhScFeabjETb
 wSLT9cs7SDJi1gnCjs6V/UfnuRPZH0M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-PTkU2gEQNKmW0jI0jPBe8A-1; Wed, 23 Apr 2025 13:01:29 -0400
X-MC-Unique: PTkU2gEQNKmW0jI0jPBe8A-1
X-Mimecast-MFC-AGG-ID: PTkU2gEQNKmW0jI0jPBe8A_1745427688
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43eea5a5d80so277965e9.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 10:01:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745427688; x=1746032488;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mu3HptekOhWiVNDp0Cso9QaBLEWByzK3MwBqQkQ9lfg=;
 b=EgARnaUGFY1q987OvDSX+RFpJ7weyfLb+n1NWnaC87imv3mKSQ4WGN27dPzfNW0Diw
 YpE5dplhAheCevtKPMiyvZgPNZuxsxuTpu4WYxJb/fDmSio8ecpIyZrG146Nxw8WVkOY
 Kh9cT9aKjg3pB1iXiesP4SWa7RDose49eRUP5lFuX49q5O3xN9XZfiGsCM0CSiFZoL/8
 UpgyyYHcN0lXcS9Mp4JUrxwsKw57h0OaMvC9XXhb/qpsYjsu6GZooBuPtrjUVQZ0EKXi
 ZiI4Oma63I1rhCZIs69fGJI5v0k8uOEgJix0w312tmck8qMwQ1pfnm2QRvfEyEUd66QA
 8eag==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSXAAPFK4KCay3ZmelBzh6gZ+dR+Y5AywIf9riKxpsGzDYANqb7CBjWPSwBrCH0IILftS3BYSFdQn8@nongnu.org
X-Gm-Message-State: AOJu0YwAhP8BZRgxB/DEuOFJLcA5QFuezKJQu04HdXBISxnMyXFyM7p7
 DPPrnOzTc83qggTUE9rZAlhcdim4VRFI7d7JWpF4PmA4RZAyFgaGdfKaTGhoerwgwrIMjNnPqtv
 Y5enCJriqTX3Ct47w7PDwzzFzBotsmQGebbNQYIzvl1DOrxo8MHhL
X-Gm-Gg: ASbGncvllU7lwqK31SPgDx6o3/PvMPICHvCdSbjiFK8Xo5eErTXrXvyUFyG18JRtD6/
 bHi1b5v7mFVCS8RNlAGubb2wrTb4+EHBtYXpAJA7G6fDN2FLqhLrhjoPP/wQhAVN1Qgp/AYaYVB
 wJ9A+c/H7RxLP4bL0gicZ6kATQNpFyHpqwT+DFVHmv05N/rET5nHJhj8cd2gHb2VQYIqH90NvIZ
 DQ56lGG7mEIQs9utA+l7cXtpGI3etI3F8eZ4IWkdWBkuDEXtLNh5erslxDDc68JqXM0EIUaBqeU
 Y/FLHrVbH2HYPkJYToPyVo+//NmfHhD9I1ypRz0gvIpf6Oo=
X-Received: by 2002:a05:600c:1c07:b0:43c:e7a7:1e76 with SMTP id
 5b1f17b1804b1-4406ab81962mr177892915e9.1.1745427686785; 
 Wed, 23 Apr 2025 10:01:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXUM+GOewUbr0jDQMflkLM9H+e1BMK8JhxZRaIq3nzxY1KFrmRUgTEx+M2ez3YQJjVpUx7QQ==
X-Received: by 2002:a05:600c:1c07:b0:43c:e7a7:1e76 with SMTP id
 5b1f17b1804b1-4406ab81962mr177892315e9.1.1745427686290; 
 Wed, 23 Apr 2025 10:01:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:38c8:6df5:c9ca:a366?
 ([2a01:e0a:165:d60:38c8:6df5:c9ca:a366])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-44092dbf7b0sm32780715e9.36.2025.04.23.10.01.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 10:01:24 -0700 (PDT)
Message-ID: <3cc6ed06-7ee4-42f4-a09e-03d8fe922537@redhat.com>
Date: Wed, 23 Apr 2025 19:01:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/14] vfio: specify VFIO_DMA_UNMAP_FLAG_ALL to callback
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Tony Krowiak <akrowiak@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-s390x@nongnu.org,
 Tomita Moeko <tomitamoeko@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Farman <farman@linux.ibm.com>
References: <20250409134814.478903-1-john.levon@nutanix.com>
 <20250409134814.478903-8-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250409134814.478903-8-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
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

On 4/9/25 15:48, John Levon wrote:
> Use the new flags parameter to indicate when we want to unmap
> everything; no functional change is intended.

I find these changes confusing. Most likely there are not well presented
or I am missing something. Some more below.

> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   hw/vfio/container.c | 49 ++++++++++++++++++++++++++++++++++++---------
>   hw/vfio/iommufd.c   | 19 +++++++++++++++++-
>   hw/vfio/listener.c  | 19 ++++++------------
>   3 files changed, 63 insertions(+), 24 deletions(-)
> 
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 625bbe82a7..37b1217fd8 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -119,12 +119,9 @@ unmap_exit:
>       return ret;
>   }
>   
> -/*
> - * DMA - Mapping and unmapping for the "type1" IOMMU interface used on x86
> - */
> -static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
> -                                 hwaddr iova, ram_addr_t size,
> -                                 IOMMUTLBEntry *iotlb, int flags)
> +static int vfio_legacy_dma_unmap_one(const VFIOContainerBase *bcontainer,
> +                                     hwaddr iova, ram_addr_t size,
> +                                     IOMMUTLBEntry *iotlb)
>   {
>       const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
>                                                     bcontainer);
> @@ -138,10 +135,6 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
>       int ret;
>       Error *local_err = NULL;
>   
> -    if (flags != 0) {
> -        return -ENOTSUP;
> -    }
> -
>       if (iotlb && vfio_container_dirty_tracking_is_started(bcontainer)) {
>           if (!vfio_container_devices_dirty_tracking_is_supported(bcontainer) &&
>               bcontainer->dirty_pages_supported) {
> @@ -185,6 +178,42 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
>       return 0;
>   }
>   
> +/*
> + * DMA - Mapping and unmapping for the "type1" IOMMU interface used on x86
> + */
> +static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
> +                                 hwaddr iova, ram_addr_t size,
> +                                 IOMMUTLBEntry *iotlb, int flags)
> +{
> +    int ret;
> +
> +    if ((flags & ~(VFIO_DMA_UNMAP_FLAG_ALL)) != 0) {

VFIO_DMA_UNMAP_FLAG_ALL is a kernel uapi flag. It should be used only with
the corresponding ioctl(VFIO_IOMMU_UNMAP_DMA) and not internally between
QEMU routines.

I think adding a 'bool unmap_all' paremeter to vfio_legacy_dma_unmap() would
make more sense.


> +        return -ENOTSUP;
> +    }
> +
> +    if (flags & VFIO_DMA_UNMAP_FLAG_ALL) {
> +        /* The unmap ioctl doesn't accept a full 64-bit span. */
> +        Int128 llsize = int128_rshift(int128_2_64(), 1);
> +
> +        ret = vfio_legacy_dma_unmap_one(bcontainer, 0, int128_get64(llsize),
> +                                        iotlb);
> +
> +        if (ret == 0) {
> +            ret = vfio_legacy_dma_unmap_one(bcontainer, int128_get64(llsize),
> +                                            int128_get64(llsize), iotlb);
> +        }
> +
> +    } else {
> +        ret = vfio_legacy_dma_unmap_one(bcontainer, iova, size, iotlb);
> +    }
> +
> +    if (ret != 0) {
> +        return -errno;
> +    }
> +
> +    return 0;
> +}
> +
>   static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>                                  ram_addr_t size, void *vaddr, bool readonly)
>   {
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 07334e65b5..22e5b16967 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -51,10 +51,27 @@ static int iommufd_cdev_unmap(const VFIOContainerBase *bcontainer,
>       const VFIOIOMMUFDContainer *container =
>           container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
>   
> -    if (flags != 0) {
> +    if ((flags & ~(VFIO_DMA_UNMAP_FLAG_ALL)) != 0) {
>           return -ENOTSUP;
>       }
>   
> +    /* unmap in halves */
> +    if (flags & VFIO_DMA_UNMAP_FLAG_ALL) {
> +        Int128 llsize = int128_rshift(int128_2_64(), 1);
> +        int ret;
> +
> +        ret = iommufd_backend_unmap_dma(container->be, container->ioas_id,
> +                                        0, int128_get64(llsize));
> +
> +        if (ret == 0) {
> +            ret = iommufd_backend_unmap_dma(container->be, container->ioas_id,
> +                                            int128_get64(llsize),
> +                                            int128_get64(llsize));
> +        }
> +
> +        return ret;
> +    }
> +
>       /* TODO: Handle dma_unmap_bitmap with iotlb args (migration) */
>       return iommufd_backend_unmap_dma(container->be,
>                                        container->ioas_id, iova, size);
> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
> index c52d4a52ef..bcf2b98e79 100644
> --- a/hw/vfio/listener.c
> +++ b/hw/vfio/listener.c
> @@ -661,21 +661,14 @@ static void vfio_listener_region_del(MemoryListener *listener,
>       }
>   
>       if (try_unmap) {
> +        int flags = 0;
> +
>           if (int128_eq(llsize, int128_2_64())) {
> -            /* The unmap ioctl doesn't accept a full 64-bit span. */
> -            llsize = int128_rshift(llsize, 1);
> -            ret = vfio_container_dma_unmap(bcontainer, iova,
> -                                           int128_get64(llsize), NULL, 0);
> -            if (ret) {
> -                error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
> -                             "0x%"HWADDR_PRIx") = %d (%s)",
> -                             bcontainer, iova, int128_get64(llsize), ret,
> -                             strerror(-ret));
> -            }
> -            iova += int128_get64(llsize);
> +            flags = VFIO_DMA_UNMAP_FLAG_ALL;
> +            llsize = 0;

please change this initialization to :

             llsize = int128_zero();

>           }
> -        ret = vfio_container_dma_unmap(bcontainer, iova,
> -                                       int128_get64(llsize), NULL, 0);
> +        ret = vfio_container_dma_unmap(bcontainer, iova, int128_get64(llsize),
> +                                       NULL, flags);

Why not unmap the halves here instead of in the backends ?


Thanks,

C.



>           if (ret) {
>               error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
>                            "0x%"HWADDR_PRIx") = %d (%s)",


