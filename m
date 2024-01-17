Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3E6830C55
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 18:57:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQA9H-0004cE-Ux; Wed, 17 Jan 2024 12:56:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rQA9C-0004bt-OC
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 12:56:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rQA9A-0000ny-M9
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 12:56:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705514175;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tFAqm6y/gDHJdi3pmk+8oe1BNX4icF7gXrGRNsrcyrY=;
 b=hhwZGKk9UmmbJ/Wo3Mbv9G3p/u0YH8NLnAezrlGuhPj74N+SkAZ6BIZ5BiDNqpYOT0oeRu
 W+Z77tPy1WG91Kmdi7ieM2y2e5onPPLRQ+PYEz81QRwfsWo08Lp45D9738hKM+sKvz/vOI
 IYwLinMpv37nxec/po/1xMwJdSuWPp4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-28aaLvRsPDq17g7Reejc4g-1; Wed, 17 Jan 2024 12:56:11 -0500
X-MC-Unique: 28aaLvRsPDq17g7Reejc4g-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7831aaa797aso1956088885a.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 09:56:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705514171; x=1706118971;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tFAqm6y/gDHJdi3pmk+8oe1BNX4icF7gXrGRNsrcyrY=;
 b=T/98wHZwRZNbpVlNzfka+o0nl0yWMEVoiEiv2CFvPgGoKZFOt9k3By32zKNNSDek0n
 vBIoVazHk5gaBuHvXBFa8iB/1aQvili9BtgjA8GeSYAhaXDZ3cqDIKyghWVw9BelneLP
 6fnrQIiR7eC03aVbrmVydgqMWp7e1NXhgGW08vIG4TbLt9o+tQylL8jUf5vWVxRhd9G4
 aK1E1hdqgiswmFE3cUmXmgjm7lUWYW1EV06cM1njtsQZEv1kZug0YbrisqrIoveJvuJX
 j9KbQmEksz/w3VQd3kxaEnjPWI00lT0ncCmiDL7v6CPhMcD3fpJv9+R3N/b5ZQPWTi8l
 ocjQ==
X-Gm-Message-State: AOJu0YyTF2ijXi1nmFSxe6TM7DhROnPSBdp7Y1f9fUuBe8B6MfqntCf+
 BacUcsAjGi8rip0CGeFd5yntfVXlAuSGQ1MWjnrXD8h+wmq+VE0mnz+EQdHpDCnaApZ4d61LF9W
 BxmZFtNYGXOSRC3PROgG3xn4=
X-Received: by 2002:a05:620a:2805:b0:783:ad2:9031 with SMTP id
 f5-20020a05620a280500b007830ad29031mr1911791qkp.61.1705514171203; 
 Wed, 17 Jan 2024 09:56:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGStqwfXDClQyhHMbVmkfTGQ//TtNXqNqARSv6D47HWTwJawx0gIz9lqpcewfvdCeqF0QkQSg==
X-Received: by 2002:a05:620a:2805:b0:783:ad2:9031 with SMTP id
 f5-20020a05620a280500b007830ad29031mr1911773qkp.61.1705514170890; 
 Wed, 17 Jan 2024 09:56:10 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 z18-20020a05620a08d200b007834386eeaesm4618692qkz.33.2024.01.17.09.56.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 09:56:10 -0800 (PST)
Message-ID: <cf7ee2c4-6dcd-40f1-8d39-2efdc15c00d9@redhat.com>
Date: Wed, 17 Jan 2024 18:56:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv1 6/6] intel_iommu: add a framework to check and sync
 host IOMMU cap/ecap
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com, Yi Sun
 <yi.y.sun@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240115101313.131139-1-zhenzhong.duan@intel.com>
 <20240115101313.131139-7-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240115101313.131139-7-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Zhenzhong,

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
>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  include/hw/i386/intel_iommu.h |  4 ++
>  hw/i386/intel_iommu.c         | 78 +++++++++++++++++++++++++++++++----
>  2 files changed, 75 insertions(+), 7 deletions(-)
>
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> index c65fdde56f..b8abbcce12 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -292,6 +292,9 @@ struct IntelIOMMUState {
>      uint64_t cap;                   /* The value of capability reg */
>      uint64_t ecap;                  /* The value of extended capability reg */
>  
> +    uint64_t host_cap;              /* The value of host capability reg */
> +    uint64_t host_ecap;             /* The value of host ext-capability reg */
> +
>      uint32_t context_cache_gen;     /* Should be in [1,MAX] */
>      GHashTable *iotlb;              /* IOTLB */
>  
> @@ -314,6 +317,7 @@ struct IntelIOMMUState {
>      bool dma_translation;           /* Whether DMA translation supported */
>      bool pasid;                     /* Whether to support PASID */
>  
> +    bool cap_finalized;             /* Whether VTD capability finalized */
>      /*
>       * Protects IOMMU states in general.  Currently it protects the
>       * per-IOMMU IOTLB cache, and context entry cache in VTDAddressSpace.
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 4c1d058ebd..be03fcbf52 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3819,6 +3819,47 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
>      return vtd_dev_as;
>  }
>  
> +static bool vtd_sync_hw_info(IntelIOMMUState *s, struct iommu_hw_info_vtd *vtd,
> +                             Error **errp)
> +{
> +    uint64_t addr_width;
> +
> +    addr_width = (vtd->cap_reg >> 16) & 0x3fULL;
> +    if (s->aw_bits > addr_width) {
> +        error_setg(errp, "User aw-bits: %u > host address width: %lu",
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
>  static int vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int32_t devfn,
>                                      IOMMUFDDevice *idev, Error **errp)
>  {
> @@ -3837,6 +3878,10 @@ static int vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int32_t devfn,
>          return 0;
>      }
>  
> +    if (!vtd_check_idev(s, idev, errp)) {In
In
[RFC 0/7] VIRTIO-IOMMU/VFIO: Fix host iommu geometry handling for
hotplugged devices
https://lore.kernel.org/all/20240117080414.316890-1-eric.auger@redhat.com/

I also attempt to pass host iommu info to the virtio-iommu but with
legacy BE. In my case I want to pass the reserved memory regions which
also model the aw.
So this is a pretty similar use case.

Why don't we pass the pointer to an opaque iommu_hw_info instead,
through the PCIIOMMUOps?



> +        return -1;
> +    }
> +
>      vtd_iommu_lock(s);
>  
>      vtd_idev = g_hash_table_lookup(s->vtd_iommufd_dev, &key);
> @@ -4071,10 +4116,11 @@ static void vtd_init(IntelIOMMUState *s)
>  {
>      X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
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
This change is not documented in the commit msg.
Sorry I don't get why this is needed?
>  
>      s->root = 0;
>      s->root_scalable = false;
> @@ -4110,13 +4156,16 @@ static void vtd_init(IntelIOMMUState *s)
>          vtd_spte_rsvd_large[3] &= ~VTD_SPTE_SNP;
>      }
>  
> -    vtd_cap_init(s);
> +    if (!s->cap_finalized) {
> +        vtd_cap_init(s);
> +        s->host_cap = s->cap;
> +        s->host_ecap = s->ecap;
> +    }
> +
>      vtd_reset_caches(s);
>  
>      /* Define registers with default values and bit semantics */
>      vtd_define_long(s, DMAR_VER_REG, 0x10UL, 0, 0);
> -    vtd_define_quad(s, DMAR_CAP_REG, s->cap, 0, 0);
> -    vtd_define_quad(s, DMAR_ECAP_REG, s->ecap, 0, 0);
>      vtd_define_long(s, DMAR_GCMD_REG, 0, 0xff800000UL, 0);
>      vtd_define_long_wo(s, DMAR_GCMD_REG, 0xff800000UL);
>      vtd_define_long(s, DMAR_GSTS_REG, 0, 0, 0);
> @@ -4241,6 +4290,12 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
>      return true;
>  }
>  
> +static void vtd_setup_capability_reg(IntelIOMMUState *s)
> +{
> +    vtd_define_quad(s, DMAR_CAP_REG, s->cap, 0, 0);
> +    vtd_define_quad(s, DMAR_ECAP_REG, s->ecap, 0, 0);
> +}
> +
>  static int vtd_machine_done_notify_one(Object *child, void *unused)
>  {
>      IntelIOMMUState *iommu = INTEL_IOMMU_DEVICE(x86_iommu_get_default());
> @@ -4259,6 +4314,14 @@ static int vtd_machine_done_notify_one(Object *child, void *unused)
>  
>  static void vtd_machine_done_hook(Notifier *notifier, void *unused)
>  {
> +    IntelIOMMUState *iommu = INTEL_IOMMU_DEVICE(x86_iommu_get_default());
> +
> +    iommu->cap = iommu->host_cap;
> +    iommu->ecap = iommu->host_ecap;
> +    iommu->cap_finalized = true;
I don't think you can change the defaults like this without taking care
of compats (migration).

Thanks

Eric
> +
> +    vtd_setup_capability_reg(iommu);
> +
>      object_child_foreach_recursive(object_get_root(),
>                                     vtd_machine_done_notify_one, NULL);
>  }
> @@ -4292,6 +4355,7 @@ static void vtd_realize(DeviceState *dev, Error **errp)
>  
>      QLIST_INIT(&s->vtd_as_with_notifiers);
>      qemu_mutex_init(&s->iommu_lock);
> +    s->cap_finalized = false;
>      memory_region_init_io(&s->csrmem, OBJECT(s), &vtd_mem_ops, s,
>                            "intel_iommu", DMAR_REG_SIZE);
>      memory_region_add_subregion(get_system_memory(),


