Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 812597D9DC3
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 18:05:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwPKX-0000OX-4i; Fri, 27 Oct 2023 12:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qwPKF-0000FA-KE
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 12:04:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qwPKD-0006BI-RP
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 12:04:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698422679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oobSXX/xSTJbgonGxVkF2GNud4J5G/CmMYFZTP7SnyA=;
 b=Hi8k9zmoI7F4kjqT9lAv6V8ZUR5aLqKGcIUHrw+sXRkVrWKPBn+qvsiwcWp/J1Roge6PWp
 yKdu9j//axmKZtAy8JP2w+DsJsPFvzPUB6/EPWiEDFoR/UJUrGJiIwl82GZH4+sqt92MZz
 nUXp1fSd8CpA0N6oDj7PACUu6iOhyjk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-v4p3bl7WN-mq5FpgrBDyRQ-1; Fri, 27 Oct 2023 12:04:38 -0400
X-MC-Unique: v4p3bl7WN-mq5FpgrBDyRQ-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-66cfd45de06so28197796d6.0
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 09:04:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698422677; x=1699027477;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oobSXX/xSTJbgonGxVkF2GNud4J5G/CmMYFZTP7SnyA=;
 b=PqDDX1R2XnG3FbcEBloLK+LKlGQqoq2HomvgkBlWN+T3sLG89vi9fms/rUeh3AL7dg
 A0zktMTcS66TuNmbVv8ANM0Oo0Xu2NoBP9SUvjZm2ng/S+XTdyruPhUG3FygT2btPdT6
 43JkEZ7inJZyiglM8KU4zC7VU06A8xvZLZ9lofjbYlmaa4wNjbKN9llCBx3aEFnFPxxB
 c1Zq01lhkP9ylAN5ZHHJrd6pA27e97jbX0W96j8yJ2vQWXMvieywWuR/HyHIaaSt7Stb
 znysbT0KRieAqr3+IlpryX6BXKSGPJlILeZMxThEYD+GW8rRAFFPzuyQV1+gZE1/B5kk
 GPTA==
X-Gm-Message-State: AOJu0YzmfQLwDr+jgMAtImx5KowTDyjZIp4YbW8MvrSSGPLtsDEn/qo4
 gu8QZ/EvW6ZR7EpawPrECnYrYmrBVrQXLXNRnAeVMnSj7U0RQCTdR6TJCLDsLeah9SfTJjiUZRA
 UzZ4SAMIEqgKimr4=
X-Received: by 2002:a05:622a:1d4:b0:417:c16a:c2c9 with SMTP id
 t20-20020a05622a01d400b00417c16ac2c9mr3633125qtw.62.1698422677482; 
 Fri, 27 Oct 2023 09:04:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFSNrwWrDSOfn0vK1Vo5LN8nqu+j9VCO3Mgt0AO/0aQiAgA+ysNLYuy3OMuBbMCxUTD17FkA==
X-Received: by 2002:a05:622a:1d4:b0:417:c16a:c2c9 with SMTP id
 t20-20020a05622a01d400b00417c16ac2c9mr3633096qtw.62.1698422677158; 
 Fri, 27 Oct 2023 09:04:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:b215:e40:e078:4b27?
 ([2a01:e0a:9e2:9000:b215:e40:e078:4b27])
 by smtp.gmail.com with ESMTPSA id
 f8-20020ac81348000000b00419b5274381sm677366qtj.94.2023.10.27.09.04.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Oct 2023 09:04:36 -0700 (PDT)
Message-ID: <87f13c36-f2e0-4719-ae08-47a03a808b1c@redhat.com>
Date: Fri, 27 Oct 2023 18:04:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/37] vfio/spapr: Introduce spapr backend and target
 interface
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
 <20231026103104.1686921-20-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231026103104.1686921-20-zhenzhong.duan@intel.com>
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
> Introduce an empry spapr backend which will hold spapr specific
> content, currently only prereg_listener and hostwin_list.
> 
> Also introduce and instantiate a spapr specific target interface,
> currently only has add/del_window callbacks.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/hw/vfio/vfio-common.h         | 8 ++++++++
>   include/hw/vfio/vfio-container-base.h | 2 ++
>   hw/vfio/spapr.c                       | 8 ++++++++
>   3 files changed, 18 insertions(+)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 938f75e70c..a74e60e677 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -169,6 +169,14 @@ VFIOAddressSpace *vfio_get_address_space(AddressSpace *as);
>   void vfio_put_address_space(VFIOAddressSpace *space);
>   
>   /* SPAPR specific */
> +typedef struct VFIOIOMMUSpaprOps {
> +    int (*add_window)(VFIOContainerBase *bcontainer,
> +                      MemoryRegionSection *section,
> +                      Error **errp);
> +    void (*del_window)(VFIOContainerBase *bcontainer,
> +                       MemoryRegionSection *section);
> +} VFIOIOMMUSpaprOps;

I don't think we need a new structure type.

If possible, these callbacks should be under VFIOIOMMUOps and only
defined in the VFIOIOMMUOps struct for spapr. This struct would a
copy of vfio_legacy_ops plus the two add/del_window  handlers.

Thanks,

C.


> +
>   int vfio_container_add_section_window(VFIOContainer *container,
>                                         MemoryRegionSection *section,
>                                         Error **errp);
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index 2ffafb0d58..1e1854d24f 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -31,6 +31,7 @@
>   
>   typedef struct VFIODevice VFIODevice;
>   typedef struct VFIOIOMMUOps VFIOIOMMUOps;
> +typedef struct VFIOIOMMUSpaprOps VFIOIOMMUSpaprOps;
>   
>   typedef struct {
>       unsigned long *bitmap;
> @@ -49,6 +50,7 @@ typedef struct VFIOAddressSpace {
>    */
>   typedef struct VFIOContainerBase {
>       const VFIOIOMMUOps *ops;
> +    const VFIOIOMMUSpaprOps *spapr_ops;
>       VFIOAddressSpace *space;
>       MemoryListener listener;
>       Error *error;
> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> index 5786377317..3739004151 100644
> --- a/hw/vfio/spapr.c
> +++ b/hw/vfio/spapr.c
> @@ -24,6 +24,10 @@
>   #include "qapi/error.h"
>   #include "trace.h"
>   
> +typedef struct VFIOSpaprContainer {
> +    VFIOContainer container;
> +} VFIOSpaprContainer;
> +
>   static bool vfio_prereg_listener_skipped_section(MemoryRegionSection *section)
>   {
>       if (memory_region_is_iommu(section->mr)) {
> @@ -384,6 +388,8 @@ void vfio_container_del_section_window(VFIOContainer *container,
>       }
>   }
>   
> +const VFIOIOMMUSpaprOps vfio_iommu_spapr_ops;
> +
>   bool vfio_spapr_container_init(VFIOContainer *container, Error **errp)
>   {
>       VFIOContainerBase *bcontainer = &container->bcontainer;
> @@ -447,6 +453,8 @@ bool vfio_spapr_container_init(VFIOContainer *container, Error **errp)
>                             0x1000);
>       }
>   
> +    bcontainer->spapr_ops = &vfio_iommu_spapr_ops;
> +
>   listener_unregister_exit:
>       if (v2) {
>           memory_listener_unregister(&container->prereg_listener);


