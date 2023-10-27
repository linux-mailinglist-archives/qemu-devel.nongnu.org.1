Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D66D7D9B3A
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 16:22:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwNhx-0001tt-Ok; Fri, 27 Oct 2023 10:21:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qwNhw-0001tl-0j
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:21:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qwNhu-0003Cv-7Z
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:21:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698416460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j3bspq4khKVrw6ChzeDVR/Gs4s631/K8FvMmJ4rPY3Q=;
 b=JBvKLdZIT/FunIJ9Ykz7RilGQoNPz6yLXtf4dX/yE/Q8EswJCAubmUDapSzKuhT+oxCdwt
 vVRDpIYVKcLcx9RLmKnbId2RgOaNNmxzUPj07yBg4kgYiZMJS0JCyFz2ZhYIrdvIqZyaqF
 YDCDNGUWG/lKyCMSUXbwGzWiRYEacZQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-K_sBJqTfPqKkDC_p0aMQEw-1; Fri, 27 Oct 2023 10:20:57 -0400
X-MC-Unique: K_sBJqTfPqKkDC_p0aMQEw-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-66d03b02d16so47818536d6.0
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 07:20:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698416456; x=1699021256;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j3bspq4khKVrw6ChzeDVR/Gs4s631/K8FvMmJ4rPY3Q=;
 b=XmAy1DdYZ8WH3Sl2yhC7PtsO3dKLHH2toULS54NO0ptPXw0dPc5IrTA6q+YAtjK+31
 McZSr/WOLmSypveFpffwN0o5Vkzx5HOx+zOLXsBP2w4iQSaOPKALHMscSkyjMGMLT35q
 THJ5DKH3d7KOcvRvL9rtQyXoLDKBDUPFUnKs/nyCdJ2SWG0ac4S3BJgVL3wMinrpTbkX
 kodqW7uVB8LctRETWUo25Q32jQgunEAXDl9TNwQLX4iDvokJzlNPLT8+OQe8pilQ9LSQ
 o6ibYD7aoJfXUnxrsmci+SE8SDi8sM3kNGlCt0wthMIgyqmbeuThJTjvpoz6Ae2KikB8
 B/Dg==
X-Gm-Message-State: AOJu0Yzbe9NkvVyLw5remEDEDFdam1W9UWfB2MikuI+4emX/uEGyiiec
 b3LdaE83+dxguNSRbYwDXKLu01jMiXpoN5bQhgCc0hvqnIRQv8qWhFMZ1dK6z4tFM5fhXOiPQsE
 wi9m9d3NMzCPdAgA=
X-Received: by 2002:a05:6214:300b:b0:65a:feb1:ec46 with SMTP id
 ke11-20020a056214300b00b0065afeb1ec46mr8022949qvb.6.1698416456654; 
 Fri, 27 Oct 2023 07:20:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeUO52QyX8jz9nV0MLO+9fhUxb9BZIebe9km9dhOSvQ9rNW+6vyAQmu7pmp/r5c37zbC0/Jg==
X-Received: by 2002:a05:6214:300b:b0:65a:feb1:ec46 with SMTP id
 ke11-20020a056214300b00b0065afeb1ec46mr8022929qvb.6.1698416456403; 
 Fri, 27 Oct 2023 07:20:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:b215:e40:e078:4b27?
 ([2a01:e0a:9e2:9000:b215:e40:e078:4b27])
 by smtp.gmail.com with ESMTPSA id
 d13-20020a056214184d00b006516780a0a5sm633835qvy.117.2023.10.27.07.20.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Oct 2023 07:20:55 -0700 (PDT)
Message-ID: <c475bb0c-02be-48d6-8219-0822189c9f2d@redhat.com>
Date: Fri, 27 Oct 2023 16:20:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/37] vfio/container: Introduce a empty VFIOIOMMUOps
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
 <20231026103104.1686921-8-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231026103104.1686921-8-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/26/23 12:30, Zhenzhong Duan wrote:
> This empty VFIOIOMMUOps named vfio_legacy_ops will hold all general
> IOMMU ops of legacy container.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/hw/vfio/vfio-common.h | 2 +-
>   hw/vfio/container.c           | 5 +++++
>   2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index d8f293cb57..8ded5cd8e4 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -255,7 +255,7 @@ typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
>   typedef QLIST_HEAD(VFIODeviceList, VFIODevice) VFIODeviceList;
>   extern VFIOGroupList vfio_group_list;
>   extern VFIODeviceList vfio_device_list;
> -
> +extern const VFIOIOMMUOps vfio_legacy_ops;


why does it need to be external ?

Thanks,

C.


>   extern const MemoryListener vfio_memory_listener;
>   extern int vfio_kvm_device_fd;
>   
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 242010036a..4bc43ddfa4 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -472,6 +472,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>                                     Error **errp)
>   {
>       VFIOContainer *container;
> +    VFIOContainerBase *bcontainer;
>       int ret, fd;
>       VFIOAddressSpace *space;
>   
> @@ -552,6 +553,8 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>       container->iova_ranges = NULL;
>       QLIST_INIT(&container->giommu_list);
>       QLIST_INIT(&container->vrdl_list);
> +    bcontainer = &container->bcontainer;
> +    bcontainer->ops = &vfio_legacy_ops;
>   
>       ret = vfio_init_container(container, group->fd, errp);
>       if (ret) {
> @@ -933,3 +936,5 @@ void vfio_detach_device(VFIODevice *vbasedev)
>       vfio_put_base_device(vbasedev);
>       vfio_put_group(group);
>   }
> +
> +const VFIOIOMMUOps vfio_legacy_ops;


