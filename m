Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 260117E2B01
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 18:35:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r03Uz-0000hZ-Hs; Mon, 06 Nov 2023 12:34:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r03Uv-0000h2-4Y
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 12:34:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r03Ut-0004DW-Ic
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 12:34:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699292086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pjtfdoPhiu6YhTNwxQ3V4nWfUTTKbOipm8LihzWqqvU=;
 b=cmn/YaKTl8B+c02QMtYUBUeNS+OiVpBF8I6fJxzV6+s05JXZd9pYQ3kl1WLhxymgoPXX2e
 tKwIj7dlbcNBflnFVjOdDZCVlbSHgvsin4zTPqiv4++ndFg8u1vPfHzjLntez3CLa+CzH3
 k2363Jt5gHSQVvZQ34vtZfmiFRyZTvc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-O0hsOh3hMKaWhkDhEAWExA-1; Mon, 06 Nov 2023 12:34:43 -0500
X-MC-Unique: O0hsOh3hMKaWhkDhEAWExA-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-41cc6fa3ea4so50713911cf.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 09:34:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699292083; x=1699896883;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pjtfdoPhiu6YhTNwxQ3V4nWfUTTKbOipm8LihzWqqvU=;
 b=dmrrQcg9ggppCfF0XPShC2d3VGWrEA9vCJJNZvtvQoqx2m3t4FKB9A3UV4sMzwhp98
 CCDJXdulRDU+Tfgt7Cukvb2DORxaSQuxCBO/A2nfGQO2RcZX2JsHZk8KgbtabXqOvcz8
 0Penw5UJKOYMlj9NH8vPnI7yTuGGDdxZtpyPOgVWT8RsCPkIJsWy2AicfNqJ5Qa6IdtA
 esJ1cOiE7ln/oIxeJTDoVcXF8bUjswZcVF+Qh68fDrHwJXi/5tyg28d8qKBm6JkyGNI1
 VJbIe2blYM7eShdc71W0zw2sEOlY0ltfDmvn7WJeAO+DKt+gqxixywt+fxSaGIhTbjO6
 n76Q==
X-Gm-Message-State: AOJu0YxPFu8WToQSassyjfI9PmDtEIb34ma/lD7Vj18B0zmr9liWWxJQ
 +H5UM2O/lkyEux87eA1uE2kGW7Q7UzOE3yQdl0INtQkDKBrTno9Efz3N3YBMeAFB1Vk0G+6I7sW
 7ZhR/CGbBjR5TznU=
X-Received: by 2002:a05:622a:13c8:b0:41e:a723:732 with SMTP id
 p8-20020a05622a13c800b0041ea7230732mr8511088qtk.33.1699292082900; 
 Mon, 06 Nov 2023 09:34:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEyFDuSU9NnEYIJ4tBYR3RXWIOI+U1Vy1SshKG4HF2h/o9oAZjEcojVcI2TVkJau5h0mqlbXA==
X-Received: by 2002:a05:622a:13c8:b0:41e:a723:732 with SMTP id
 p8-20020a05622a13c800b0041ea7230732mr8511075qtk.33.1699292082655; 
 Mon, 06 Nov 2023 09:34:42 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 bq8-20020a05622a1c0800b0041abcc69050sm3552232qtb.95.2023.11.06.09.34.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 09:34:42 -0800 (PST)
Message-ID: <a1ea92c7-6e3f-45dd-a8f5-528c15f2b826@redhat.com>
Date: Mon, 6 Nov 2023 18:34:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 23/41] vfio/spapr: Move prereg_listener into spapr
 container
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "open list:sPAPR (pseries)" <qemu-ppc@nongnu.org>
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
 <20231102071302.1818071-24-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231102071302.1818071-24-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
> No functional changes intended.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/vfio/vfio-common.h |  1 -
>   hw/vfio/spapr.c               | 24 ++++++++++++++++--------
>   2 files changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 055f679363..ed6148c058 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -78,7 +78,6 @@ struct VFIOGroup;
>   typedef struct VFIOContainer {
>       VFIOContainerBase bcontainer;
>       int fd; /* /dev/vfio/vfio, empowered by the attached groups */
> -    MemoryListener prereg_listener;
>       unsigned iommu_type;
>       QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
>       QLIST_HEAD(, VFIOGroup) group_list;
> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> index 5be1911aad..68c3dd6c75 100644
> --- a/hw/vfio/spapr.c
> +++ b/hw/vfio/spapr.c
> @@ -26,6 +26,7 @@
>   
>   typedef struct VFIOSpaprContainer {
>       VFIOContainer container;
> +    MemoryListener prereg_listener;
>   } VFIOSpaprContainer;
>   
>   static bool vfio_prereg_listener_skipped_section(MemoryRegionSection *section)
> @@ -48,8 +49,9 @@ static void *vfio_prereg_gpa_to_vaddr(MemoryRegionSection *section, hwaddr gpa)
>   static void vfio_prereg_listener_region_add(MemoryListener *listener,
>                                               MemoryRegionSection *section)
>   {
> -    VFIOContainer *container = container_of(listener, VFIOContainer,
> -                                            prereg_listener);
> +    VFIOSpaprContainer *scontainer = container_of(listener, VFIOSpaprContainer,
> +                                                  prereg_listener);
> +    VFIOContainer *container = &scontainer->container;
>       VFIOContainerBase *bcontainer = &container->bcontainer;
>       const hwaddr gpa = section->offset_within_address_space;
>       hwaddr end;
> @@ -107,8 +109,9 @@ static void vfio_prereg_listener_region_add(MemoryListener *listener,
>   static void vfio_prereg_listener_region_del(MemoryListener *listener,
>                                               MemoryRegionSection *section)
>   {
> -    VFIOContainer *container = container_of(listener, VFIOContainer,
> -                                            prereg_listener);
> +    VFIOSpaprContainer *scontainer = container_of(listener, VFIOSpaprContainer,
> +                                                  prereg_listener);
> +    VFIOContainer *container = &scontainer->container;
>       const hwaddr gpa = section->offset_within_address_space;
>       hwaddr end;
>       int ret;
> @@ -445,6 +448,8 @@ static void setup_spapr_ops(VFIOContainerBase *bcontainer)
>   int vfio_spapr_container_init(VFIOContainer *container, Error **errp)
>   {
>       VFIOContainerBase *bcontainer = &container->bcontainer;
> +    VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
> +                                                  container);
>       struct vfio_iommu_spapr_tce_info info;
>       bool v2 = container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU;
>       int ret, fd = container->fd;
> @@ -463,9 +468,9 @@ int vfio_spapr_container_init(VFIOContainer *container, Error **errp)
>               return -errno;
>           }
>       } else {
> -        container->prereg_listener = vfio_prereg_listener;
> +        scontainer->prereg_listener = vfio_prereg_listener;
>   
> -        memory_listener_register(&container->prereg_listener,
> +        memory_listener_register(&scontainer->prereg_listener,
>                                    &address_space_memory);
>           if (bcontainer->error) {
>               ret = -1;
> @@ -513,7 +518,7 @@ int vfio_spapr_container_init(VFIOContainer *container, Error **errp)
>   
>   listener_unregister_exit:
>       if (v2) {
> -        memory_listener_unregister(&container->prereg_listener);
> +        memory_listener_unregister(&scontainer->prereg_listener);
>       }
>       return ret;
>   }
> @@ -523,7 +528,10 @@ void vfio_spapr_container_deinit(VFIOContainer *container)
>       VFIOHostDMAWindow *hostwin, *next;
>   
>       if (container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU) {
> -        memory_listener_unregister(&container->prereg_listener);
> +        VFIOSpaprContainer *scontainer = container_of(container,
> +                                                      VFIOSpaprContainer,
> +                                                      container);
> +        memory_listener_unregister(&scontainer->prereg_listener);
>       }
>       QLIST_FOREACH_SAFE(hostwin, &container->hostwin_list, hostwin_next,
>                          next) {


