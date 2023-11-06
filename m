Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0057E2AF9
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 18:32:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r03RG-0006f4-DS; Mon, 06 Nov 2023 12:31:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r03RC-0006db-MX
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 12:30:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r03RA-0003b7-M1
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 12:30:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699291855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+9QMJ2OSo/eUKuwvXtw+ePjWXTzTL4sGz6LiUmA+9Zw=;
 b=bhtayzOaSRz2p0nSRuXxLt7DZcddWDyG/bqJXvcHCs2JOTaHR2AkL7RurGoN9gGZ96RWcf
 YKvviduV2WVRvFy7dfwxeE0eLf+YoMfxQwOLDrnZr8wtGNGSA98O0n9HmUDm1+UTVIUEMk
 BqfD5A/f6g3rWEQcfsL/iVNyVKSuxS4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-K98Ik7iiMwKFqHi7SszRTg-1; Mon, 06 Nov 2023 12:30:54 -0500
X-MC-Unique: K98Ik7iiMwKFqHi7SszRTg-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-778b25af933so545265485a.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 09:30:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699291854; x=1699896654;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+9QMJ2OSo/eUKuwvXtw+ePjWXTzTL4sGz6LiUmA+9Zw=;
 b=NZSPdC5ZA7wUKNXFsdTmF7Aa2Hikdy23uwG8Yx9KUYsSBWFFww7RgkB1+3Pl0IFtpg
 zT6NGLcfMS6ya95loIKh5lWuJAroS6paYfVKCxXJ5AgMFMOz0tOGUGRIiscXliLjm3yk
 yo6hWLi5yz58stIAk71CSvAKEQwrF5/AJ4glC1moiHPcC1HtUNoWJ3/P1U2Ns1PSYS/N
 tJLb/+jvDBZEkbjW4Pei+08rUP+YSp5daKBAkPY3wEV7LSvvd3swl/NURbjrEc4qMtTY
 9K348SNaSjkbZqV3n+Bmq3YYsDXJlcc5476gjP19AsZbEexQl6ahOYPKd4KrGjLo38Za
 8Kng==
X-Gm-Message-State: AOJu0YxTVJuKQGKqALKt0W2irLjDWMyPnGmYIE0PCvzIOdldRLtr90gH
 Q+Mj56hwCAgzQJPi/bD6GMSzCcA2wZ3z/FFpnTBcn7tSPvwCoVjvyIfz1hySa0Raaryag7Zu2fh
 hIX/29MFn/uh3vqg=
X-Received: by 2002:a05:620a:1a05:b0:774:2915:d180 with SMTP id
 bk5-20020a05620a1a0500b007742915d180mr37658094qkb.37.1699291854153; 
 Mon, 06 Nov 2023 09:30:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRnSn2iT+yORtbe8trlXJcrYRs2cT5fY0R470bYCECmxJt1R45Mu8Ij5ulAVUS6gNoYZLQ5A==
X-Received: by 2002:a05:620a:1a05:b0:774:2915:d180 with SMTP id
 bk5-20020a05620a1a0500b007742915d180mr37658075qkb.37.1699291853856; 
 Mon, 06 Nov 2023 09:30:53 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 y13-20020a37e30d000000b007759e9b0eb8sm3462676qki.99.2023.11.06.09.30.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 09:30:53 -0800 (PST)
Message-ID: <2472a56e-3d2a-422b-be4c-8681dbe6f166@redhat.com>
Date: Mon, 6 Nov 2023 18:30:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 21/41] vfio/spapr: Introduce spapr backend and target
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
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
 <20231102071302.1818071-22-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231102071302.1818071-22-zhenzhong.duan@intel.com>
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
> Introduce an empty spapr backend which will hold spapr specific
> content, currently only prereg_listener and hostwin_list.
> 
> Also introduce two spapr specific callbacks add/del_window into
> VFIOIOMMUOps. Instantiate a spapr ops with a helper setup_spapr_ops
> and assign it to bcontainer->ops.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
> v4: remove VFIOIOMMUSpaprOps
> 
>   include/hw/vfio/vfio-container-base.h |  6 ++++++
>   hw/vfio/spapr.c                       | 14 ++++++++++++++
>   2 files changed, 20 insertions(+)
> 
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index 9658ffb526..f62a14ac73 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -101,5 +101,11 @@ struct VFIOIOMMUOps {
>       int (*set_dirty_page_tracking)(VFIOContainerBase *bcontainer, bool start);
>       int (*query_dirty_bitmap)(VFIOContainerBase *bcontainer, VFIOBitmap *vbmap,
>                                 hwaddr iova, hwaddr size);
> +    /* SPAPR specific */
> +    int (*add_window)(VFIOContainerBase *bcontainer,
> +                      MemoryRegionSection *section,
> +                      Error **errp);
> +    void (*del_window)(VFIOContainerBase *bcontainer,
> +                       MemoryRegionSection *section);
>   };
>   #endif /* HW_VFIO_VFIO_CONTAINER_BASE_H */
> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> index 7a50975f25..e1a6b35563 100644
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
> @@ -421,6 +425,14 @@ void vfio_container_del_section_window(VFIOContainer *container,
>       }
>   }
>   
> +static VFIOIOMMUOps vfio_iommu_spapr_ops;
> +
> +static void setup_spapr_ops(VFIOContainerBase *bcontainer)
> +{
> +    vfio_iommu_spapr_ops = *bcontainer->ops;
> +    bcontainer->ops = &vfio_iommu_spapr_ops;
> +}
> +
>   int vfio_spapr_container_init(VFIOContainer *container, Error **errp)
>   {
>       VFIOContainerBase *bcontainer = &container->bcontainer;
> @@ -486,6 +498,8 @@ int vfio_spapr_container_init(VFIOContainer *container, Error **errp)
>                             0x1000);
>       }
>   
> +    setup_spapr_ops(bcontainer);
> +
>       return 0;
>   
>   listener_unregister_exit:


