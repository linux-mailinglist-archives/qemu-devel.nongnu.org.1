Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 236DA7E2B03
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 18:35:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r03Vr-0001xw-Ft; Mon, 06 Nov 2023 12:35:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r03Vo-0001qE-Uy
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 12:35:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r03Vm-0004Yu-Nv
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 12:35:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699292142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NhEfPTBVIM6uq99sLN6RSlsrtGplndcpejFYVjL4wVI=;
 b=AB2YHGt8YWwiwyumvl0XrxElp4c7yDikXxQraTmi90cXhm3/EPUq/0e7esaF+kCvuq9dUH
 +39NLYw7wK+JUM7Dsk11H2YHxta74DdlOx1qLIRSEzgnXMKZ0HTjkN6s1fzklhdeVLdp+a
 Z+eu6C7lH+H8HGMadTydhI0p8YG+Arg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-j3E_KDTxMaOpe6_WPDsCAQ-1; Mon, 06 Nov 2023 12:35:40 -0500
X-MC-Unique: j3E_KDTxMaOpe6_WPDsCAQ-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-41cb4d6744bso50910551cf.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 09:35:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699292140; x=1699896940;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NhEfPTBVIM6uq99sLN6RSlsrtGplndcpejFYVjL4wVI=;
 b=YOk8Zm03FnSwu6UpHKhEfHixTtiOpvtiyVHYHn4lOxGtQKAJaBzfA47PftxYbnsI6B
 8eSwweKI2XcGiSnTANLl3CmDoP1UJ209+VGcql0EhWbTwBFKjOa/ukCfixVuLBouzd9V
 VQWdap0GpivQiv2984bCs2cGRoNqQeSfGYqlZlm+vqY5qJcnHa9FEFPeijAf/zby+UKg
 DTvtbuTUAnBuZevvShPWrjGqbdlEZWCRWDpX9GUlX5JAcHFctsagWywZqp6PlX3sBWbN
 vwO8cFPSEOG/OZx0fe4T6vsXXVQHnnoDquAPGDm9fVZKTUhqvIrZuLdHlT91c01p140/
 S3kg==
X-Gm-Message-State: AOJu0YxGOB2ZEpHnwzsLxEr6nQXyysIZYhD1I1NEuHqLy7Mrj6dsxvVh
 aDfMk1y87G5AzWxab69WE+8+mpqfsODEqn1CwjFUxqkevep/oFbFzuBEnEhVNmY9T9vR6tt3EZt
 SJPFMYcwLGVqCGz6h+J+oQKs=
X-Received: by 2002:ac8:5882:0:b0:417:b746:8dec with SMTP id
 t2-20020ac85882000000b00417b7468decmr31746496qta.58.1699292139996; 
 Mon, 06 Nov 2023 09:35:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2gJzOAvKF0Se9hYyVkt2ArNCK6wy2NSiNwQ6BOTZlZOqMzijeyELwYjKIIHipMDOfnfTt6A==
X-Received: by 2002:ac8:5882:0:b0:417:b746:8dec with SMTP id
 t2-20020ac85882000000b00417b7468decmr31746470qta.58.1699292139643; 
 Mon, 06 Nov 2023 09:35:39 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 bq8-20020a05622a1c0800b0041abcc69050sm3552232qtb.95.2023.11.06.09.35.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 09:35:39 -0800 (PST)
Message-ID: <9cf9ecdd-5a61-4670-94bd-53979152ad54@redhat.com>
Date: Mon, 6 Nov 2023 18:35:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 24/41] vfio/spapr: Move hostwin_list into spapr
 container
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
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
 <20231102071302.1818071-25-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231102071302.1818071-25-zhenzhong.duan@intel.com>
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
> No functional changes intended.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/vfio/vfio-common.h |  1 -
>   hw/vfio/spapr.c               | 36 +++++++++++++++++++----------------
>   2 files changed, 20 insertions(+), 17 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index ed6148c058..24ecc0e7ee 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -79,7 +79,6 @@ typedef struct VFIOContainer {
>       VFIOContainerBase bcontainer;
>       int fd; /* /dev/vfio/vfio, empowered by the attached groups */
>       unsigned iommu_type;
> -    QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
>       QLIST_HEAD(, VFIOGroup) group_list;
>   } VFIOContainer;
>   
> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> index 68c3dd6c75..5c6426e697 100644
> --- a/hw/vfio/spapr.c
> +++ b/hw/vfio/spapr.c
> @@ -27,6 +27,7 @@
>   typedef struct VFIOSpaprContainer {
>       VFIOContainer container;
>       MemoryListener prereg_listener;
> +    QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
>   } VFIOSpaprContainer;
>   
>   static bool vfio_prereg_listener_skipped_section(MemoryRegionSection *section)
> @@ -154,12 +155,12 @@ static const MemoryListener vfio_prereg_listener = {
>       .region_del = vfio_prereg_listener_region_del,
>   };
>   
> -static void vfio_host_win_add(VFIOContainer *container, hwaddr min_iova,
> +static void vfio_host_win_add(VFIOSpaprContainer *scontainer, hwaddr min_iova,
>                                 hwaddr max_iova, uint64_t iova_pgsizes)
>   {
>       VFIOHostDMAWindow *hostwin;
>   
> -    QLIST_FOREACH(hostwin, &container->hostwin_list, hostwin_next) {
> +    QLIST_FOREACH(hostwin, &scontainer->hostwin_list, hostwin_next) {
>           if (ranges_overlap(hostwin->min_iova,
>                              hostwin->max_iova - hostwin->min_iova + 1,
>                              min_iova,
> @@ -173,15 +174,15 @@ static void vfio_host_win_add(VFIOContainer *container, hwaddr min_iova,
>       hostwin->min_iova = min_iova;
>       hostwin->max_iova = max_iova;
>       hostwin->iova_pgsizes = iova_pgsizes;
> -    QLIST_INSERT_HEAD(&container->hostwin_list, hostwin, hostwin_next);
> +    QLIST_INSERT_HEAD(&scontainer->hostwin_list, hostwin, hostwin_next);
>   }
>   
> -static int vfio_host_win_del(VFIOContainer *container,
> +static int vfio_host_win_del(VFIOSpaprContainer *scontainer,
>                                hwaddr min_iova, hwaddr max_iova)
>   {
>       VFIOHostDMAWindow *hostwin;
>   
> -    QLIST_FOREACH(hostwin, &container->hostwin_list, hostwin_next) {
> +    QLIST_FOREACH(hostwin, &scontainer->hostwin_list, hostwin_next) {
>           if (hostwin->min_iova == min_iova && hostwin->max_iova == max_iova) {
>               QLIST_REMOVE(hostwin, hostwin_next);
>               g_free(hostwin);
> @@ -192,7 +193,7 @@ static int vfio_host_win_del(VFIOContainer *container,
>       return -1;
>   }
>   
> -static VFIOHostDMAWindow *vfio_find_hostwin(VFIOContainer *container,
> +static VFIOHostDMAWindow *vfio_find_hostwin(VFIOSpaprContainer *container,
>                                               hwaddr iova, hwaddr end)
>   {
>       VFIOHostDMAWindow *hostwin;
> @@ -329,6 +330,8 @@ vfio_spapr_container_add_section_window(VFIOContainerBase *bcontainer,
>   {
>       VFIOContainer *container = container_of(bcontainer, VFIOContainer,
>                                               bcontainer);
> +    VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
> +                                                  container);
>       VFIOHostDMAWindow *hostwin;
>       hwaddr pgsize = 0;
>       int ret;
> @@ -344,7 +347,7 @@ vfio_spapr_container_add_section_window(VFIOContainerBase *bcontainer,
>           iova = section->offset_within_address_space;
>           end = iova + int128_get64(section->size) - 1;
>   
> -        if (!vfio_find_hostwin(container, iova, end)) {
> +        if (!vfio_find_hostwin(scontainer, iova, end)) {
>               error_setg(errp, "Container %p can't map guest IOVA region"
>                          " 0x%"HWADDR_PRIx"..0x%"HWADDR_PRIx, container,
>                          iova, end);
> @@ -358,7 +361,7 @@ vfio_spapr_container_add_section_window(VFIOContainerBase *bcontainer,
>       }
>   
>       /* For now intersections are not allowed, we may relax this later */
> -    QLIST_FOREACH(hostwin, &container->hostwin_list, hostwin_next) {
> +    QLIST_FOREACH(hostwin, &scontainer->hostwin_list, hostwin_next) {
>           if (ranges_overlap(hostwin->min_iova,
>                              hostwin->max_iova - hostwin->min_iova + 1,
>                              section->offset_within_address_space,
> @@ -380,7 +383,7 @@ vfio_spapr_container_add_section_window(VFIOContainerBase *bcontainer,
>           return ret;
>       }
>   
> -    vfio_host_win_add(container, section->offset_within_address_space,
> +    vfio_host_win_add(scontainer, section->offset_within_address_space,
>                         section->offset_within_address_space +
>                         int128_get64(section->size) - 1, pgsize);
>   #ifdef CONFIG_KVM
> @@ -419,6 +422,8 @@ vfio_spapr_container_del_section_window(VFIOContainerBase *bcontainer,
>   {
>       VFIOContainer *container = container_of(bcontainer, VFIOContainer,
>                                               bcontainer);
> +    VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
> +                                                  container);
>   
>       if (container->iommu_type != VFIO_SPAPR_TCE_v2_IOMMU) {
>           return;
> @@ -426,7 +431,7 @@ vfio_spapr_container_del_section_window(VFIOContainerBase *bcontainer,
>   
>       vfio_spapr_remove_window(container,
>                                section->offset_within_address_space);
> -    if (vfio_host_win_del(container,
> +    if (vfio_host_win_del(scontainer,
>                             section->offset_within_address_space,
>                             section->offset_within_address_space +
>                             int128_get64(section->size) - 1) < 0) {
> @@ -454,7 +459,7 @@ int vfio_spapr_container_init(VFIOContainer *container, Error **errp)
>       bool v2 = container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU;
>       int ret, fd = container->fd;
>   
> -    QLIST_INIT(&container->hostwin_list);
> +    QLIST_INIT(&scontainer->hostwin_list);
>   
>       /*
>        * The host kernel code implementing VFIO_IOMMU_DISABLE is called
> @@ -506,7 +511,7 @@ int vfio_spapr_container_init(VFIOContainer *container, Error **errp)
>       } else {
>           /* The default table uses 4K pages */
>           bcontainer->pgsizes = 0x1000;
> -        vfio_host_win_add(container, info.dma32_window_start,
> +        vfio_host_win_add(scontainer, info.dma32_window_start,
>                             info.dma32_window_start +
>                             info.dma32_window_size - 1,
>                             0x1000);
> @@ -525,15 +530,14 @@ listener_unregister_exit:
>   
>   void vfio_spapr_container_deinit(VFIOContainer *container)
>   {
> +    VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
> +                                                  container);
>       VFIOHostDMAWindow *hostwin, *next;
>   
>       if (container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU) {
> -        VFIOSpaprContainer *scontainer = container_of(container,
> -                                                      VFIOSpaprContainer,
> -                                                      container);
>           memory_listener_unregister(&scontainer->prereg_listener);
>       }
> -    QLIST_FOREACH_SAFE(hostwin, &container->hostwin_list, hostwin_next,
> +    QLIST_FOREACH_SAFE(hostwin, &scontainer->hostwin_list, hostwin_next,
>                          next) {
>           QLIST_REMOVE(hostwin, hostwin_next);
>           g_free(hostwin);


