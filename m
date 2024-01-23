Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E577838947
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 09:40:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSCJg-0007Mm-Uv; Tue, 23 Jan 2024 03:39:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rSCJf-0007MP-2A
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 03:39:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rSCJc-0003Qb-RO
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 03:39:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705999167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uFK3DHLFTAH6LxaVyWMyuEHHEYPqjU+V2bp+haT3IRw=;
 b=CZ7eNl9qvJp7jjf+YaSMj7YN3U5TXuYKbtPpWela7VsOMDLRcJWcYKlEs16DPZP9jX9bnE
 Cm18zidapfdw7qBFG9GicJL8K4+zWXZYikgPBVytYfZPO/mQfr5wYiyGKKlUjDscBkH0Z8
 L3HNyCKVx0v2SIBK7gsbu7RIplv4Ek4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-zJHs-zbEMnaeCFb0_a113Q-1; Tue, 23 Jan 2024 03:39:25 -0500
X-MC-Unique: zJHs-zbEMnaeCFb0_a113Q-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-42a32dff21bso52155581cf.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 00:39:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705999164; x=1706603964;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uFK3DHLFTAH6LxaVyWMyuEHHEYPqjU+V2bp+haT3IRw=;
 b=sk93zNsBAYAzz9TKsBTS9lfCwUVeF9WMcnLyQSdW/R39L2PX1MPFu1JHpvKpM80G+1
 rnKA0AL+ku7uB0Tw5G6P77nnwtB3vLvJlVlf9juB2tMmhBoX0YIO8Ar+Lixp06FbvU56
 BwozvL5VZX0Nv/DG9jtpKj1MufkFf2d9bc+QFJihU20v/AEC+OM6pmahkI9rEaDk8qvf
 n7WIAyE6dUNnG2RT2T5tC96aMRG3JOpGyXQvTctAMtQ3/ybthEbiJvhXvHqKyVzEkYhJ
 iaU6IYnuuL7yDgql/vQ7l6a6BWFw4O/SpYJMXxSTLzcTaCNRHUYl43mJHvqgkepZqAmk
 r8mw==
X-Gm-Message-State: AOJu0YzTfZ17cKmrXHoWXD4N9FCVbY0C+EdR1bJgPtQg8fARmLLcy85W
 W6oTqGHPdOUCV8S6j0pLxFrIDeNww9G51/VKHPzwsgC1bO7CbBRqgr1nt9/gw1KdpwABMshtcHC
 N+G9x2PRw/tw2H4l54543ONAgMjQrZYe/OYdNtA3jhd8k6br0SC6r
X-Received: by 2002:a05:622a:110a:b0:42a:3248:1eb6 with SMTP id
 e10-20020a05622a110a00b0042a32481eb6mr668285qty.30.1705999164470; 
 Tue, 23 Jan 2024 00:39:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFez4nuppUFxrF1wc1YHCa1IghXU+OdJMOBFdVU6Xgf+sxf4gpH28EPvjneCrsntjdgzkeF8A==
X-Received: by 2002:a05:622a:110a:b0:42a:3248:1eb6 with SMTP id
 e10-20020a05622a110a00b0042a32481eb6mr668276qty.30.1705999164051; 
 Tue, 23 Jan 2024 00:39:24 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 u13-20020a05622a17cd00b0042a0a0d4225sm3291550qtk.38.2024.01.23.00.39.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 00:39:23 -0800 (PST)
Message-ID: <5f78ee34-757b-4264-81b7-7ec7e5f12259@redhat.com>
Date: Tue, 23 Jan 2024 09:39:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv1 6/6] intel_iommu: add a framework to check and sync
 host IOMMU cap/ecap
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com, Yi Sun
 <yi.y.sun@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
References: <20240115101313.131139-1-zhenzhong.duan@intel.com>
 <20240115101313.131139-7-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240115101313.131139-7-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.289,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 1/15/24 11:13, Zhenzhong Duan wrote:
> From: Yi Liu <yi.l.liu@intel.com>
> 
> Add a framework to check and synchronize host IOMMU cap/ecap with
> vIOMMU cap/ecap.
> 
> Currently only stage-2 translation is supported which is backed by
> shadow page table on host side. So we don't need exact matching of
> each bit of cap/ecap between vIOMMU and host. However, we can still
> utilize this framework to ensure compatibility of host and vIOMMU's
> address width at least, i.e., vIOMMU's aw_bits <= host aw_bits,
> which is missed before.
> 
> When stage-1 translation is supported in future, a.k.a. scalable
> modern mode, we need to ensure compatibility of each bits. Some
> bits are user controllable, they should be checked with host side
> to ensure compatibility. Other bits are not, they should be synced
> into vIOMMU cap/ecap for compatibility.
> 
> The sequence will be:
> 
> vtd_cap_init() initializes iommu->cap/ecap. ---- vtd_cap_init()
> iommu->host_cap/ecap is initialized as iommu->cap/ecap.  ---- vtd_init()
> iommu->host_cap/ecap is checked and updated some bits with host cap/ecap. ---- vtd_sync_hw_info()
> iommu->cap/ecap is finalized as iommu->host_cap/ecap.  ---- vtd_machine_done_hook()
> 
> iommu->host_cap/ecap is a temporary storage to hold intermediate value
> when synthesize host cap/ecap and vIOMMU's initial configured cap/ecap.


The above "sequence" paragraph is not very clear. The patch may need to
be split further.



> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/hw/i386/intel_iommu.h |  4 ++
>   hw/i386/intel_iommu.c         | 78 +++++++++++++++++++++++++++++++----
>   2 files changed, 75 insertions(+), 7 deletions(-)
> 
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> index c65fdde56f..b8abbcce12 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -292,6 +292,9 @@ struct IntelIOMMUState {
>       uint64_t cap;                   /* The value of capability reg */
>       uint64_t ecap;                  /* The value of extended capability reg */
>   
> +    uint64_t host_cap;              /* The value of host capability reg */
> +    uint64_t host_ecap;             /* The value of host ext-capability reg */
> +
>       uint32_t context_cache_gen;     /* Should be in [1,MAX] */
>       GHashTable *iotlb;              /* IOTLB */
>   
> @@ -314,6 +317,7 @@ struct IntelIOMMUState {
>       bool dma_translation;           /* Whether DMA translation supported */
>       bool pasid;                     /* Whether to support PASID */
>   
> +    bool cap_finalized;             /* Whether VTD capability finalized */
>       /*
>        * Protects IOMMU states in general.  Currently it protects the
>        * per-IOMMU IOTLB cache, and context entry cache in VTDAddressSpace.
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 4c1d058ebd..be03fcbf52 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3819,6 +3819,47 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
>       return vtd_dev_as;
>   }
>   
> +static bool vtd_sync_hw_info(IntelIOMMUState *s, struct iommu_hw_info_vtd *vtd,
> +                             Error **errp)
> +{
> +    uint64_t addr_width;
> +
> +    addr_width = (vtd->cap_reg >> 16) & 0x3fULL;

Virek uses the same kind of macro in :

   https://lore.kernel.org/qemu-devel/20240118192049.1796763-1-vivek.kasireddy@intel.com/

What about the + 1 ? Looks like it's missing here, according to 11.4.2
Capability Register.

Could we introduce a common macro in intel_iommu_internal.h ?


> +    if (s->aw_bits > addr_width) {
> +        error_setg(errp, "User aw-bits: %u > host address width: %lu",

I think %lu should be PRId64. This is a general comment. You should avoid
%llx, %lx, etc. in the code.

> +                   s->aw_bits, addr_width);
> +        return false;
> +    }
> +
> +    /* TODO: check and sync host cap/ecap into vIOMMU cap/ecap */
> +
> +    return true;
> +}
> +
> +/*
> + * virtual VT-d which wants nested needs to check the host IOMMU
> + * nesting cap info behind the assigned devices. Thus that vIOMMU
> + * could bind guest page table to host.
> + */
> +static bool vtd_check_idev(IntelIOMMUState *s, IOMMUFDDevice *idev,
> +                           Error **errp)
> +{
> +    struct iommu_hw_info_vtd vtd;
> +    enum iommu_hw_info_type type = IOMMU_HW_INFO_TYPE_INTEL_VTD;
> +
> +    if (iommufd_device_get_info(idev, &type, sizeof(vtd), &vtd)) {
> +        error_setg(errp, "Failed to get IOMMU capability!!!");
> +        return false;
> +    }
> +
> +    if (type != IOMMU_HW_INFO_TYPE_INTEL_VTD) {
> +        error_setg(errp, "IOMMU hardware is not compatible!!!");
> +        return false;
> +    }
> +
> +    return vtd_sync_hw_info(s, &vtd, errp);
> +}
> +
>   static int vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int32_t devfn,
>                                       IOMMUFDDevice *idev, Error **errp)
>   {
> @@ -3837,6 +3878,10 @@ static int vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int32_t devfn,
>           return 0;
>       }
>   
> +    if (!vtd_check_idev(s, idev, errp)) {
> +        return -1;
> +    }
> +
>       vtd_iommu_lock(s);
>   
>       vtd_idev = g_hash_table_lookup(s->vtd_iommufd_dev, &key);
> @@ -4071,10 +4116,11 @@ static void vtd_init(IntelIOMMUState *s)
>   {
>       X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
>   
> -    memset(s->csr, 0, DMAR_REG_SIZE);
> -    memset(s->wmask, 0, DMAR_REG_SIZE);
> -    memset(s->w1cmask, 0, DMAR_REG_SIZE);
> -    memset(s->womask, 0, DMAR_REG_SIZE);
> +    /* CAP/ECAP are initialized in machine create done stage */
> +    memset(s->csr + DMAR_GCMD_REG, 0, DMAR_REG_SIZE - DMAR_GCMD_REG);
> +    memset(s->wmask + DMAR_GCMD_REG, 0, DMAR_REG_SIZE - DMAR_GCMD_REG);
> +    memset(s->w1cmask + DMAR_GCMD_REG, 0, DMAR_REG_SIZE - DMAR_GCMD_REG);
> +    memset(s->womask + DMAR_GCMD_REG, 0, DMAR_REG_SIZE - DMAR_GCMD_REG);
>   
>       s->root = 0;
>       s->root_scalable = false;
> @@ -4110,13 +4156,16 @@ static void vtd_init(IntelIOMMUState *s)

vtd_init() is called from reset and from realize. This is redundant.
reset should be enough.


>           vtd_spte_rsvd_large[3] &= ~VTD_SPTE_SNP;
>       }
>   
> -    vtd_cap_init(s);
> +    if (!s->cap_finalized) {

ok. so this can only be done in reset.

> +        vtd_cap_init(s);
> +        s->host_cap = s->cap;
> +        s->host_ecap = s->ecap;
> +    }
> +
>       vtd_reset_caches(s);
>   
>       /* Define registers with default values and bit semantics */
>       vtd_define_long(s, DMAR_VER_REG, 0x10UL, 0, 0);
> -    vtd_define_quad(s, DMAR_CAP_REG, s->cap, 0, 0);
> -    vtd_define_quad(s, DMAR_ECAP_REG, s->ecap, 0, 0);
>       vtd_define_long(s, DMAR_GCMD_REG, 0, 0xff800000UL, 0);
>       vtd_define_long_wo(s, DMAR_GCMD_REG, 0xff800000UL);
>       vtd_define_long(s, DMAR_GSTS_REG, 0, 0, 0);
> @@ -4241,6 +4290,12 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
>       return true;
>   }
>   
> +static void vtd_setup_capability_reg(IntelIOMMUState *s)
> +{
> +    vtd_define_quad(s, DMAR_CAP_REG, s->cap, 0, 0);
> +    vtd_define_quad(s, DMAR_ECAP_REG, s->ecap, 0, 0);
> +}
> +
>   static int vtd_machine_done_notify_one(Object *child, void *unused)
>   {
>       IntelIOMMUState *iommu = INTEL_IOMMU_DEVICE(x86_iommu_get_default());
> @@ -4259,6 +4314,14 @@ static int vtd_machine_done_notify_one(Object *child, void *unused)
>   
>   static void vtd_machine_done_hook(Notifier *notifier, void *unused)
>   {
> +    IntelIOMMUState *iommu = INTEL_IOMMU_DEVICE(x86_iommu_get_default());
> +
> +    iommu->cap = iommu->host_cap;
> +    iommu->ecap = iommu->host_ecap;
> +    iommu->cap_finalized = true;
> +
> +    vtd_setup_capability_reg(iommu);
> +

This is confusing. Please split the patch better to reflect the ordering of
the e/cap register settings.


Thanks,

C.




>       object_child_foreach_recursive(object_get_root(),
>                                      vtd_machine_done_notify_one, NULL);
>   }
> @@ -4292,6 +4355,7 @@ static void vtd_realize(DeviceState *dev, Error **errp)
>   
>       QLIST_INIT(&s->vtd_as_with_notifiers);
>       qemu_mutex_init(&s->iommu_lock);
> +    s->cap_finalized = false;
>       memory_region_init_io(&s->csrmem, OBJECT(s), &vtd_mem_ops, s,
>                             "intel_iommu", DMAR_REG_SIZE);
>       memory_region_add_subregion(get_system_memory(),


