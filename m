Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB7C7D93A7
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 11:28:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwJ8Q-0005S3-Ea; Fri, 27 Oct 2023 05:28:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qwJ8B-0005Fg-RZ
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 05:27:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qwJ83-0008PP-NR
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 05:27:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698398862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RrZGV93CqAXb7ropGYaC4zEU3j6MU+wSy33BBBXlBgs=;
 b=If9e2fV/Hydvm0BAJ/hRhrLs1oZV2+Jx/S3H+kancjxHZ1z560TOU5hlfVwUeIgbC3miwG
 4TXTZxrURyzgqtC87UPH0TlgM9Andp1ZckNyxZGBFixJCpkKEvhKzR0UEHP81k1fj/V7y5
 ldkSYyAIoy+4lIQvBGLD5Q+0c+atKHU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-b18RNeTlN1G-sZS8On7ABg-1; Fri, 27 Oct 2023 05:27:39 -0400
X-MC-Unique: b18RNeTlN1G-sZS8On7ABg-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-66d062708b0so27756566d6.1
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 02:27:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698398859; x=1699003659;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RrZGV93CqAXb7ropGYaC4zEU3j6MU+wSy33BBBXlBgs=;
 b=fzETQpe4+Mv4Qi6/XiHwfiAvBVdWNWOx83wi9MZVnE8zk9U2E9TjcNfAdu3FiCTv0g
 yqV8gM5Twx7OzHpXO0j/oBdbJyZneHog9QT+35pbZqFfcRbWMSAcyNo+6fwGj8sQfui5
 lLIzfukFQmMZSimDwW2eq9bMmgDQNwObc3qWy1bxUSIbC/ZH+fidULc0ksrnyvqzxRLn
 6fzWNKp0cmPE9bdr/jHfA++vm5n7EoOuH9pYi8zivQG2jilnwKVXokhjNTnl70QcBo3z
 Dl+Lyb49y8XIdm+5BZtWsIOSVAlxlHcPtio2K3YQ0+d4kHuDoDD9vLprOkgiYsOipbUN
 UY0g==
X-Gm-Message-State: AOJu0YziZi82JxFq3scXJm+W3HWvhmREalrWLlzzj+5BOH+bEIylXIDz
 02D/xpxI3vcVji6YljwHBivejd+uBFdGRPaqo25PbQsVA5vDuK3qqZhpEjZvaKCRr3kZSD+OWw8
 DtMevQfZlybd2TV0=
X-Received: by 2002:a05:6214:29c9:b0:66d:245a:4b70 with SMTP id
 gh9-20020a05621429c900b0066d245a4b70mr2437201qvb.2.1698398858919; 
 Fri, 27 Oct 2023 02:27:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEo3qee/so9wwGFpF2f/u34MBI/8DGvsExpsKDvJ8oJIfh722TKgW5zWfh3LkuKCgqxQI2PMw==
X-Received: by 2002:a05:6214:29c9:b0:66d:245a:4b70 with SMTP id
 gh9-20020a05621429c900b0066d245a4b70mr2437174qvb.2.1698398858649; 
 Fri, 27 Oct 2023 02:27:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:b215:e40:e078:4b27?
 ([2a01:e0a:9e2:9000:b215:e40:e078:4b27])
 by smtp.gmail.com with ESMTPSA id
 ei6-20020ad45a06000000b0065b2167fd63sm460837qvb.65.2023.10.27.02.27.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Oct 2023 02:27:37 -0700 (PDT)
Message-ID: <5e922ceb-7497-4200-9b74-bd460724676b@redhat.com>
Date: Fri, 27 Oct 2023 11:27:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/37] vfio/spapr: Make vfio_spapr_create/remove_window
 static
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "open list:sPAPR (pseries)" <qemu-ppc@nongnu.org>
References: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
 <20231026103104.1686921-5-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231026103104.1686921-5-zhenzhong.duan@intel.com>
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
> vfio_spapr_create_window calls vfio_spapr_remove_window,
> With reoder of definition of the two, we can make
> vfio_spapr_create/remove_window static.
> 
> No functional changes intended.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/vfio/vfio-common.h |  6 -----
>   hw/vfio/spapr.c               | 48 +++++++++++++++++------------------
>   2 files changed, 24 insertions(+), 30 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 8d1d4f0a89..f3174b3c5c 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -293,12 +293,6 @@ struct vfio_info_cap_header *
>   vfio_get_cap(void *ptr, uint32_t cap_offset, uint16_t id);
>   #endif
>   
> -int vfio_spapr_create_window(VFIOContainer *container,
> -                             MemoryRegionSection *section,
> -                             hwaddr *pgsize);
> -int vfio_spapr_remove_window(VFIOContainer *container,
> -                             hwaddr offset_within_address_space);
> -
>   bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
>   void vfio_migration_exit(VFIODevice *vbasedev);
>   
> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> index fd0613dfde..43adbdb7b3 100644
> --- a/hw/vfio/spapr.c
> +++ b/hw/vfio/spapr.c
> @@ -146,9 +146,30 @@ static const MemoryListener vfio_prereg_listener = {
>       .region_del = vfio_prereg_listener_region_del,
>   };
>   
> -int vfio_spapr_create_window(VFIOContainer *container,
> -                             MemoryRegionSection *section,
> -                             hwaddr *pgsize)
> +static int vfio_spapr_remove_window(VFIOContainer *container,
> +                                    hwaddr offset_within_address_space)
> +{
> +    struct vfio_iommu_spapr_tce_remove remove = {
> +        .argsz = sizeof(remove),
> +        .start_addr = offset_within_address_space,
> +    };
> +    int ret;
> +
> +    ret = ioctl(container->fd, VFIO_IOMMU_SPAPR_TCE_REMOVE, &remove);
> +    if (ret) {
> +        error_report("Failed to remove window at %"PRIx64,
> +                     (uint64_t)remove.start_addr);
> +        return -errno;
> +    }
> +
> +    trace_vfio_spapr_remove_window(offset_within_address_space);
> +
> +    return 0;
> +}
> +
> +static int vfio_spapr_create_window(VFIOContainer *container,
> +                                    MemoryRegionSection *section,
> +                                    hwaddr *pgsize)
>   {
>       int ret = 0;
>       IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
> @@ -238,27 +259,6 @@ int vfio_spapr_create_window(VFIOContainer *container,
>       return 0;
>   }
>   
> -int vfio_spapr_remove_window(VFIOContainer *container,
> -                             hwaddr offset_within_address_space)
> -{
> -    struct vfio_iommu_spapr_tce_remove remove = {
> -        .argsz = sizeof(remove),
> -        .start_addr = offset_within_address_space,
> -    };
> -    int ret;
> -
> -    ret = ioctl(container->fd, VFIO_IOMMU_SPAPR_TCE_REMOVE, &remove);
> -    if (ret) {
> -        error_report("Failed to remove window at %"PRIx64,
> -                     (uint64_t)remove.start_addr);
> -        return -errno;
> -    }
> -
> -    trace_vfio_spapr_remove_window(offset_within_address_space);
> -
> -    return 0;
> -}
> -
>   int vfio_container_add_section_window(VFIOContainer *container,
>                                         MemoryRegionSection *section,
>                                         Error **errp)


