Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DE3AA9210
	for <lists+qemu-devel@lfdr.de>; Mon,  5 May 2025 13:29:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBtzi-00058f-8o; Mon, 05 May 2025 07:28:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uBtzX-00056e-Va
 for qemu-devel@nongnu.org; Mon, 05 May 2025 07:28:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uBtzU-00017p-Et
 for qemu-devel@nongnu.org; Mon, 05 May 2025 07:28:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746444486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MLaF1gHNRxWgsFDIHvDyb1AM8MxC5hSKUmwplA7jgOg=;
 b=hFdwDPd+d5pmNQEeaRd+JGGFpBvO1MX6fHoNSZ1tOrjySjLlY1tD1e5AfO5Qv0M36Zdhdl
 yYog6wzoBOfCLSoo/0ZZuXnmYsLl7s9EOUaF+rJ13vWSqp0sFNElPWcky5fMt296E3tgaP
 csVJaWW8xjYYNQzO5H4Pau7qPYoSVL0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-5wcx_SQCPIuhllkKpoJ5og-1; Mon, 05 May 2025 07:28:05 -0400
X-MC-Unique: 5wcx_SQCPIuhllkKpoJ5og-1
X-Mimecast-MFC-AGG-ID: 5wcx_SQCPIuhllkKpoJ5og_1746444484
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a064c45f03so1753261f8f.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 04:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746444484; x=1747049284;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MLaF1gHNRxWgsFDIHvDyb1AM8MxC5hSKUmwplA7jgOg=;
 b=URQtnA0fXXAx0jaqcfTnawThvOxp9psO5Z42FL/soKe/JHX0hiNCEYD0v4OO3DDEci
 SiCvPu1jW0LWZpzPg3/tV6lgYnZdf9uCdP/KbwizaBOAmlm/IGw6J81kjWOdEYnfKIhP
 7w8nQmZEM1Gb5Qu0M+ARYZHiCyXq/pqtn7kJEfuNJDF2T8Q8R65qkgbyOArf5iHkR9ge
 tFX0LGfYhXHPUGukJqZXuCsZORCmLBzfNc9ZnySHMByN8M+FmQUqoVnOVoIDE/t+zvsa
 ab0/MdtWlDXbX3jPht3P36HHCdpwJ4tlUeFRJXalLgqsWru0LyAYJuUdqcZnUme0Iw3I
 4ZJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxNL0bYUYYv/AbFyp7WoUwLjCfLKdzHOi9dATI0S7UD9rU12wUPvcCdr3I5GPCxRChp9YaHWHwXklV@nongnu.org
X-Gm-Message-State: AOJu0Yx6jUSYAw5N5MxugN9a9uz0c5+DHyedshDsXUzdDFtpNiwfHFID
 W/UUXfxRaoD6aP47t0eGLt3qeHdcMWI5xke1qSe+xYfe9gmjYDkMY15TgTql/sSUckhm2JLIRE2
 WDAuTb4gtGW/X2YqKVbM4yucubeBehkHwIEJvu7hnsub6j5nL1Nrz
X-Gm-Gg: ASbGncsPwrEWnNZeWL/OYiOzJLGJ9Uu3bOqe6tlB9BNrjXlIAutKY6MfIi7JS8EjrCC
 +QRsCj40Ubq74z9IPGVKiEqHhlRe4LdMXf0nmFHgU7GLZptOvkYaR0rb4cDVa2vrjuTm3UEe+pG
 cHvh/7MrbXcZDRotAfCN12StynhTgrV4wuECqdrcp+oCu7Wo3FO+IQo0kWFE6BgRQSY99xVx/rT
 3cwLbCvXVxkLtKuu2FROjdFaGC5k9YKvwUurJXP0+bYT4+CY5f87UAcEHphRqpjKDkWuns9uef3
 NfE3C4c6O9yFrqTQomJ65DZrXkD+m5mY/hL50TvITOdKZNRPZg==
X-Received: by 2002:a05:6000:3101:b0:3a0:92d9:dae with SMTP id
 ffacd0b85a97d-3a09402ca45mr11694904f8f.5.1746444484312; 
 Mon, 05 May 2025 04:28:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUrLl5C++0iKf1MKcbvJMgQf4oV6i9wu7Uo6AbPidkDnzCTK8lEIiFCnnDIzfIE+NL2ihk7A==
X-Received: by 2002:a05:6000:3101:b0:3a0:92d9:dae with SMTP id
 ffacd0b85a97d-3a09402ca45mr11694883f8f.5.1746444483904; 
 Mon, 05 May 2025 04:28:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae0cc9sm9998887f8f.9.2025.05.05.04.28.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 04:28:03 -0700 (PDT)
Message-ID: <3d5e7ab7-bd1b-4dca-aba7-3b82a8ee8763@redhat.com>
Date: Mon, 5 May 2025 13:28:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/15] vfio: implement unmap all for DMA unmap callbacks
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, qemu-s390x@nongnu.org,
 Jason Herne <jjherne@linux.ibm.com>, Tomita Moeko <tomitamoeko@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Tony Krowiak
 <akrowiak@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
References: <20250430194003.2793823-1-john.levon@nutanix.com>
 <20250430194003.2793823-10-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250430194003.2793823-10-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

On 4/30/25 21:39, John Levon wrote:
> Handle unmap_all in the DMA unmap handlers rather than in the caller.
> 
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   hw/vfio/container.c | 45 +++++++++++++++++++++++++++++++++++----------
>   hw/vfio/iommufd.c   | 15 ++++++++++++++-
>   hw/vfio/listener.c  | 19 ++++++-------------
>   3 files changed, 55 insertions(+), 24 deletions(-)
> 
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 766ba5a275..1000f3c241 100644
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
> -                                 IOMMUTLBEntry *iotlb, bool unmap_all)
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
> -    if (unmap_all) {
> -        return -ENOTSUP;
> -    }
> -
>       if (iotlb && vfio_container_dirty_tracking_is_started(bcontainer)) {
>           if (!vfio_container_devices_dirty_tracking_is_supported(bcontainer) &&
>               bcontainer->dirty_pages_supported) {
> @@ -185,6 +178,38 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
>       return 0;
>   }
>   
> +/*
> + * DMA - Mapping and unmapping for the "type1" IOMMU interface used on x86
> + */
> +static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
> +                                 hwaddr iova, ram_addr_t size,
> +                                 IOMMUTLBEntry *iotlb, bool unmap_all)
> +{
> +    int ret;
> +
> +    if (unmap_all) {
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

the ret value should already be an errno. Shouldn't it ?


Thanks,

C.



> +    return 0;
> +}
> +
>   static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>                                  ram_addr_t size, void *vaddr, bool readonly)
>   {
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 6b2764c044..af1c7ab10a 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -51,8 +51,21 @@ static int iommufd_cdev_unmap(const VFIOContainerBase *bcontainer,
>       const VFIOIOMMUFDContainer *container =
>           container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
>   
> +    /* unmap in halves */
>       if (unmap_all) {
> -        return -ENOTSUP;
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
>       }
>   
>       /* TODO: Handle dma_unmap_bitmap with iotlb args (migration) */
> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
> index c5183700db..e7ade7d62e 100644
> --- a/hw/vfio/listener.c
> +++ b/hw/vfio/listener.c
> @@ -634,21 +634,14 @@ static void vfio_listener_region_del(MemoryListener *listener,
>       }
>   
>       if (try_unmap) {
> +        bool unmap_all = false;
> +
>           if (int128_eq(llsize, int128_2_64())) {
> -            /* The unmap ioctl doesn't accept a full 64-bit span. */
> -            llsize = int128_rshift(llsize, 1);
> -            ret = vfio_container_dma_unmap(bcontainer, iova,
> -                                           int128_get64(llsize), NULL, false);
> -            if (ret) {
> -                error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
> -                             "0x%"HWADDR_PRIx") = %d (%s)",
> -                             bcontainer, iova, int128_get64(llsize), ret,
> -                             strerror(-ret));
> -            }
> -            iova += int128_get64(llsize);
> +            unmap_all = true;
> +            llsize = int128_zero();
>           }
> -        ret = vfio_container_dma_unmap(bcontainer, iova,
> -                                       int128_get64(llsize), NULL, false);
> +        ret = vfio_container_dma_unmap(bcontainer, iova, int128_get64(llsize),
> +                                       NULL, unmap_all);
>           if (ret) {
>               error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
>                            "0x%"HWADDR_PRIx") = %d (%s)",


