Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D313F7E29FE
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 17:37:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r02bd-0002rJ-J3; Mon, 06 Nov 2023 11:37:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r02bb-0002p2-AQ
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 11:37:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r02bZ-0008Uo-Ll
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 11:37:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699288657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mQEA6L/bn0GpzmIwIjTB2kzEJN6rDEBI4GebaUSoBVk=;
 b=dznjbD974nTqXv7DVpyOkSV1qV3RhL5lpt4a4fcls1EI7/r5lc+evW/H8uDT2+9UcgJuvw
 QxV/t6v+J1rTo3kAwcKEJ6VBt5ghL2DTvxHGPD2fpg3LPa1xEFkbj9wQ/7ZPbHTh4h5z+O
 JYZKqd8grMlndt2DbiGKhoY5/rl9MiY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-ra1JI4BFMOG9dJhfi-aIsw-1; Mon, 06 Nov 2023 11:37:31 -0500
X-MC-Unique: ra1JI4BFMOG9dJhfi-aIsw-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-77a12fbe7eeso563976385a.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 08:37:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699288650; x=1699893450;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mQEA6L/bn0GpzmIwIjTB2kzEJN6rDEBI4GebaUSoBVk=;
 b=AvLwpK3BtuEpDT9PvmlVAkMeSeGBzPLZ1GNDlll1jUuUWRJ7FettP2lQx8AV01pUxV
 ZXUF0HSQxQWAM5rVnyzZkzEAMv6+bMsUXA1fCEm+E/kXc7Le/VZRCHMMFAdW7kikfYog
 LpI70byrwykaSrfhlSeZL4IAZLG6JTDt3IOmfzVKVcy/nMjNW4IhGHQ47YAPSKFkbM6/
 w00puLV8eBk+1qwqJEcZltpHJLA4cllpC2DF5n7e+8XFdhxxF0MzHRnzOt2keT5B0NN8
 D7NTaRsbBPZw0rpapCx6TxGGn3qRg3IKeVt3WmqcPXU50iJpYIg0dZByG8MeyAUkj/er
 6ovg==
X-Gm-Message-State: AOJu0YyzVCcl+xBqA4KVjIZQgUBbeZT3aOh7k5sPxs+ULEFgUDa27Nyp
 NEr3454C/hIFDyUfyhUZDvxghd4mQXZXTkwfvbr3u7d27muvJcvr+60SxR0QWBJWSCSi0ipJ2mx
 C3BN0PwFqgkLIQQk=
X-Received: by 2002:a05:620a:4409:b0:77a:4a87:e9b7 with SMTP id
 v9-20020a05620a440900b0077a4a87e9b7mr21755254qkp.42.1699288650465; 
 Mon, 06 Nov 2023 08:37:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhBdTAmg3qHlIhGCK2lmUzPjXSXb06/ZO/uI9JGVFM0qpbz3g4b3qagWL/IhgKUI99Paqe4w==
X-Received: by 2002:a05:620a:4409:b0:77a:4a87:e9b7 with SMTP id
 v9-20020a05620a440900b0077a4a87e9b7mr21755230qkp.42.1699288650252; 
 Mon, 06 Nov 2023 08:37:30 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 l3-20020a05620a28c300b0076c96e571f3sm3426450qkp.26.2023.11.06.08.37.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 08:37:29 -0800 (PST)
Message-ID: <4ddd653e-9306-4adf-9b6b-e2227cccf044@redhat.com>
Date: Mon, 6 Nov 2023 17:37:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/41] vfio/common: Introduce
 vfio_container_init/destroy helper
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
 <20231102071302.1818071-10-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231102071302.1818071-10-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
> This adds two helper functions vfio_container_init/destroy which will be
> used by both legacy and iommufd containers to do base container specific
> initialization and release.
> 
> No fucntional change intended.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/vfio/vfio-container-base.h | 4 ++++
>   hw/vfio/container-base.c              | 9 +++++++++
>   hw/vfio/container.c                   | 4 +++-
>   3 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index 56b033f59f..577f52ccbc 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -38,6 +38,10 @@ int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
>                                hwaddr iova, ram_addr_t size,
>                                IOMMUTLBEntry *iotlb);
>   
> +void vfio_container_init(VFIOContainerBase *bcontainer,
> +                         const VFIOIOMMUOps *ops);
> +void vfio_container_destroy(VFIOContainerBase *bcontainer);
> +
>   struct VFIOIOMMUOps {
>       /* basic feature */
>       int (*dma_map)(VFIOContainerBase *bcontainer,
> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
> index 55d3a35fa4..e929435751 100644
> --- a/hw/vfio/container-base.c
> +++ b/hw/vfio/container-base.c
> @@ -30,3 +30,12 @@ int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
>       g_assert(bcontainer->ops->dma_unmap);
>       return bcontainer->ops->dma_unmap(bcontainer, iova, size, iotlb);
>   }
> +
> +void vfio_container_init(VFIOContainerBase *bcontainer, const VFIOIOMMUOps *ops)
> +{
> +    bcontainer->ops = ops;
> +}
> +
> +void vfio_container_destroy(VFIOContainerBase *bcontainer)
> +{
> +}
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index c04df26323..32a0251dd1 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -559,7 +559,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>       QLIST_INIT(&container->giommu_list);
>       QLIST_INIT(&container->vrdl_list);
>       bcontainer = &container->bcontainer;
> -    bcontainer->ops = &vfio_legacy_ops;
> +    vfio_container_init(bcontainer, &vfio_legacy_ops);
>   
>       ret = vfio_init_container(container, group->fd, errp);
>       if (ret) {
> @@ -661,6 +661,7 @@ put_space_exit:
>   static void vfio_disconnect_container(VFIOGroup *group)
>   {
>       VFIOContainer *container = group->container;
> +    VFIOContainerBase *bcontainer = &container->bcontainer;
>   
>       QLIST_REMOVE(group, container_next);
>       group->container = NULL;
> @@ -695,6 +696,7 @@ static void vfio_disconnect_container(VFIOGroup *group)
>               QLIST_REMOVE(giommu, giommu_next);
>               g_free(giommu);
>           }
> +        vfio_container_destroy(bcontainer);
>   
>           trace_vfio_disconnect_container(container->fd);
>           close(container->fd);


