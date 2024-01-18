Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C2C83194F
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 13:42:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQRhZ-0005K2-Ue; Thu, 18 Jan 2024 07:40:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rQRhY-0005Ji-LM
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 07:40:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rQRhW-00033V-5C
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 07:40:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705581653;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jOAzZiJEHmKGMfUWMGO33XYEqMnbN+Ta0XJaY2wjvMY=;
 b=OHBGU4SRsp8xupL58uyRHw1/RrhBqOXUh6aAUkUCIR1fjTDm7Fbi1NnlF5aX1pEjQltDWu
 IcMS+nMwY/IbBgoB/9cieaY0wz3X+WxoxxnxoGR9DT/jj6gGrZ1zP1YFfOXbtHoyu2sAxv
 9lIt8TGyFGWGl8Wt2/d2iTniWRvozzU=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-gPJwOPRaPpGyedeqIIaIQg-1; Thu, 18 Jan 2024 07:40:46 -0500
X-MC-Unique: gPJwOPRaPpGyedeqIIaIQg-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-5e6f42b1482so184638517b3.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 04:40:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705581646; x=1706186446;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jOAzZiJEHmKGMfUWMGO33XYEqMnbN+Ta0XJaY2wjvMY=;
 b=XB9Qsx5w+A7MCHHjtNrDucrhgPMb2MzxshbCW3wDsLgTUHVQ5HMI6yAbrlS8rf156z
 f8VoNIoQZ+rl42iEWZpT6aGwkJulsiKaPKeVRZH11MQnGD+0uK49JMhjcolCRtodzmaZ
 7iL34U5odWXhsjNE+15Jb2m4jun3IXEm50AnWFkbD4hhslETr1gPB6a+dUgh42l5TS1q
 kH4yNyGJP5XyVIngxVCj83j5bjqrZGAtiDKlZ7F4dtERC+qmIfGP6GES9/k6kTudefsp
 m9Zfv4gz3c7gfy4y+D2T+dbaKKBqYi2CGeyq7y1kC1QQdVcNkQK3gFq7HwPUYlAqKrWP
 6V4Q==
X-Gm-Message-State: AOJu0YzD9Ppg1elclDyp0JA3Jd/7de2IAyVWTMi8mrH2baRlV7LSMqeu
 SDy1cZ4NwYkCMfHFo0sA0EaMsJv2PI1EMUJKQgk2HHg8VsQ5uQERxF9N+FKNLoKHG7HggqAQq4Q
 vmMii0GooRcugI6NYrCAHD023yeNZXPILKfp54Sh/nn3JBR/SGAX3
X-Received: by 2002:a25:c7c5:0:b0:dbe:ac6b:7266 with SMTP id
 w188-20020a25c7c5000000b00dbeac6b7266mr590384ybe.12.1705581646006; 
 Thu, 18 Jan 2024 04:40:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8RBloWqolocMy2gGZ3HFEGWGUDQhLO7qBFrNe+6CimxxP5/yj4ZQullQSYuHFaJi2WrgK0A==
X-Received: by 2002:a25:c7c5:0:b0:dbe:ac6b:7266 with SMTP id
 w188-20020a25c7c5000000b00dbeac6b7266mr590371ybe.12.1705581645696; 
 Thu, 18 Jan 2024 04:40:45 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 lx6-20020a0562145f0600b006818736f748sm896010qvb.29.2024.01.18.04.40.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jan 2024 04:40:45 -0800 (PST)
Message-ID: <6148ee77-676d-4fba-966f-5440797dddd5@redhat.com>
Date: Thu, 18 Jan 2024 13:40:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv1 6/6] intel_iommu: add a framework to check and sync
 host IOMMU cap/ecap
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240115101313.131139-1-zhenzhong.duan@intel.com>
 <20240115101313.131139-7-zhenzhong.duan@intel.com>
 <cf7ee2c4-6dcd-40f1-8d39-2efdc15c00d9@redhat.com>
 <SJ0PR11MB6744AC771797D3C7634817BC92712@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <SJ0PR11MB6744AC771797D3C7634817BC92712@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org



On 1/18/24 10:30, Duan, Zhenzhong wrote:
> Hi Eric,
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Subject: Re: [PATCH rfcv1 6/6] intel_iommu: add a framework to check and
>> sync host IOMMU cap/ecap
>>
>> Hi Zhenzhong,
>>
>> On 1/15/24 11:13, Zhenzhong Duan wrote:
>>> From: Yi Liu <yi.l.liu@intel.com>
>>>
>>> Add a framework to check and synchronize host IOMMU cap/ecap with
>>> vIOMMU cap/ecap.
>>>
>>> Currently only stage-2 translation is supported which is backed by
>>> shadow page table on host side. So we don't need exact matching of
>>> each bit of cap/ecap between vIOMMU and host. However, we can still
>>> utilize this framework to ensure compatibility of host and vIOMMU's
>>> address width at least, i.e., vIOMMU's aw_bits <= host aw_bits,
>>> which is missed before.
>>>
>>> When stage-1 translation is supported in future, a.k.a. scalable
>>> modern mode, we need to ensure compatibility of each bits. Some
>>> bits are user controllable, they should be checked with host side
>>> to ensure compatibility. Other bits are not, they should be synced
>>> into vIOMMU cap/ecap for compatibility.
>>>
>>> The sequence will be:
>>>
>>> vtd_cap_init() initializes iommu->cap/ecap. ---- vtd_cap_init()
>>> iommu->host_cap/ecap is initialized as iommu->cap/ecap.  ---- vtd_init()
>>> iommu->host_cap/ecap is checked and updated some bits with host
>> cap/ecap. ---- vtd_sync_hw_info()
>>> iommu->cap/ecap is finalized as iommu->host_cap/ecap.  ----
>> vtd_machine_done_hook()
>>> iommu->host_cap/ecap is a temporary storage to hold intermediate value
>>> when synthesize host cap/ecap and vIOMMU's initial configured cap/ecap.
>>>
>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>  include/hw/i386/intel_iommu.h |  4 ++
>>>  hw/i386/intel_iommu.c         | 78
>> +++++++++++++++++++++++++++++++----
>>>  2 files changed, 75 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/include/hw/i386/intel_iommu.h
>> b/include/hw/i386/intel_iommu.h
>>> index c65fdde56f..b8abbcce12 100644
>>> --- a/include/hw/i386/intel_iommu.h
>>> +++ b/include/hw/i386/intel_iommu.h
>>> @@ -292,6 +292,9 @@ struct IntelIOMMUState {
>>>      uint64_t cap;                   /* The value of capability reg */
>>>      uint64_t ecap;                  /* The value of extended capability reg */
>>>
>>> +    uint64_t host_cap;              /* The value of host capability reg */
>>> +    uint64_t host_ecap;             /* The value of host ext-capability reg */
>>> +
>>>      uint32_t context_cache_gen;     /* Should be in [1,MAX] */
>>>      GHashTable *iotlb;              /* IOTLB */
>>>
>>> @@ -314,6 +317,7 @@ struct IntelIOMMUState {
>>>      bool dma_translation;           /* Whether DMA translation supported */
>>>      bool pasid;                     /* Whether to support PASID */
>>>
>>> +    bool cap_finalized;             /* Whether VTD capability finalized */
>>>      /*
>>>       * Protects IOMMU states in general.  Currently it protects the
>>>       * per-IOMMU IOTLB cache, and context entry cache in
>> VTDAddressSpace.
>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>> index 4c1d058ebd..be03fcbf52 100644
>>> --- a/hw/i386/intel_iommu.c
>>> +++ b/hw/i386/intel_iommu.c
>>> @@ -3819,6 +3819,47 @@ VTDAddressSpace
>> *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
>>>      return vtd_dev_as;
>>>  }
>>>
>>> +static bool vtd_sync_hw_info(IntelIOMMUState *s, struct
>> iommu_hw_info_vtd *vtd,
>>> +                             Error **errp)
>>> +{
>>> +    uint64_t addr_width;
>>> +
>>> +    addr_width = (vtd->cap_reg >> 16) & 0x3fULL;
>>> +    if (s->aw_bits > addr_width) {
>>> +        error_setg(errp, "User aw-bits: %u > host address width: %lu",
>>> +                   s->aw_bits, addr_width);
>>> +        return false;
>>> +    }
>>> +
>>> +    /* TODO: check and sync host cap/ecap into vIOMMU cap/ecap */
>>> +
>>> +    return true;
>>> +}
>>> +
>>> +/*
>>> + * virtual VT-d which wants nested needs to check the host IOMMU
>>> + * nesting cap info behind the assigned devices. Thus that vIOMMU
>>> + * could bind guest page table to host.
>>> + */
>>> +static bool vtd_check_idev(IntelIOMMUState *s, IOMMUFDDevice *idev,
>>> +                           Error **errp)
>>> +{
>>> +    struct iommu_hw_info_vtd vtd;
>>> +    enum iommu_hw_info_type type =
>> IOMMU_HW_INFO_TYPE_INTEL_VTD;
>>> +
>>> +    if (iommufd_device_get_info(idev, &type, sizeof(vtd), &vtd)) {
>>> +        error_setg(errp, "Failed to get IOMMU capability!!!");
>>> +        return false;
>>> +    }
>>> +
>>> +    if (type != IOMMU_HW_INFO_TYPE_INTEL_VTD) {
>>> +        error_setg(errp, "IOMMU hardware is not compatible!!!");
>>> +        return false;
>>> +    }
>>> +
>>> +    return vtd_sync_hw_info(s, &vtd, errp);
>>> +}
>>> +
>>>  static int vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int32_t
>> devfn,
>>>                                      IOMMUFDDevice *idev, Error **errp)
>>>  {
>>> @@ -3837,6 +3878,10 @@ static int vtd_dev_set_iommu_device(PCIBus
>> *bus, void *opaque, int32_t devfn,
>>>          return 0;
>>>      }
>>>
>>> +    if (!vtd_check_idev(s, idev, errp)) {In
>> In
>> [RFC 0/7] VIRTIO-IOMMU/VFIO: Fix host iommu geometry handling for
>> hotplugged devices
>> https://lore.kernel.org/all/20240117080414.316890-1-
>> eric.auger@redhat.com/
>>
>> I also attempt to pass host iommu info to the virtio-iommu but with
>> legacy BE.
> I think your patch works with iommufd BE too😊 Because iommufd BE
> also fills bcontainer->iova_ranges in iommufd_cdev_get_info_iova_range().
correct. I wanted to emphasize that we also have the need to pass host
iommu info in legacy mode for instance. In this series you introduce an
object that works with the iommufd backed but I think if we go this way
we would need another one for the legacy device. So maybe introducing a
base object derived into 2 ones may be the most appropriate? Maybe,
given the assumption that we will use iommufd for new use cases this
legacy object will implement much fewer interfaces but still.
>
>> In my case I want to pass the reserved memory regions which
>> also model the aw.
>> So this is a pretty similar use case.
> Yes.
>
>> Why don't we pass the pointer to an opaque iommu_hw_info instead,
>> through the PCIIOMMUOps?
> Passing iommu_hw_info is ok for this series, but we want more from
> IOMMUFDDevice in nesting series. I.e., allocate/free ioas/hwpt,
> attach/detach from hwpt, get dirty bitmap, etc. It's more flexible to
> let vIOMMU get what it want itself.
OK, would be interesting to define the class for this object. Worth to
be introduced either in the cover letter or in the 1st patch

Eric
>
>>
>>
>>> +        return -1;
>>> +    }
>>> +
>>>      vtd_iommu_lock(s);
>>>
>>>      vtd_idev = g_hash_table_lookup(s->vtd_iommufd_dev, &key);
>>> @@ -4071,10 +4116,11 @@ static void vtd_init(IntelIOMMUState *s)
>>>  {
>>>      X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
>>>
>>> -    memset(s->csr, 0, DMAR_REG_SIZE);
>>> -    memset(s->wmask, 0, DMAR_REG_SIZE);
>>> -    memset(s->w1cmask, 0, DMAR_REG_SIZE);
>>> -    memset(s->womask, 0, DMAR_REG_SIZE);
>>> +    /* CAP/ECAP are initialized in machine create done stage */
>>> +    memset(s->csr + DMAR_GCMD_REG, 0, DMAR_REG_SIZE -
>> DMAR_GCMD_REG);
>>> +    memset(s->wmask + DMAR_GCMD_REG, 0, DMAR_REG_SIZE -
>> DMAR_GCMD_REG);
>>> +    memset(s->w1cmask + DMAR_GCMD_REG, 0, DMAR_REG_SIZE -
>> DMAR_GCMD_REG);
>>> +    memset(s->womask + DMAR_GCMD_REG, 0, DMAR_REG_SIZE -
>> DMAR_GCMD_REG);
>> This change is not documented in the commit msg.
>> Sorry I don't get why this is needed?
> I'll doc it. Above we have one line to explain when cap/ecap are initialized.
> vtd_init() is called in qemu init and guest reset. In qemu init,
> Cap/ecap is finalized, after that we don't want cap/ecap to be changed.
> So we bypass change to cap/ecap here.
>
>>>      s->root = 0;
>>>      s->root_scalable = false;
>>> @@ -4110,13 +4156,16 @@ static void vtd_init(IntelIOMMUState *s)
>>>          vtd_spte_rsvd_large[3] &= ~VTD_SPTE_SNP;
>>>      }
>>>
>>> -    vtd_cap_init(s);
>>> +    if (!s->cap_finalized) {
>>> +        vtd_cap_init(s);
>>> +        s->host_cap = s->cap;
>>> +        s->host_ecap = s->ecap;
>>> +    }
>>> +
>>>      vtd_reset_caches(s);
>>>
>>>      /* Define registers with default values and bit semantics */
>>>      vtd_define_long(s, DMAR_VER_REG, 0x10UL, 0, 0);
>>> -    vtd_define_quad(s, DMAR_CAP_REG, s->cap, 0, 0);
>>> -    vtd_define_quad(s, DMAR_ECAP_REG, s->ecap, 0, 0);
>>>      vtd_define_long(s, DMAR_GCMD_REG, 0, 0xff800000UL, 0);
>>>      vtd_define_long_wo(s, DMAR_GCMD_REG, 0xff800000UL);
>>>      vtd_define_long(s, DMAR_GSTS_REG, 0, 0, 0);
>>> @@ -4241,6 +4290,12 @@ static bool
>> vtd_decide_config(IntelIOMMUState *s, Error **errp)
>>>      return true;
>>>  }
>>>
>>> +static void vtd_setup_capability_reg(IntelIOMMUState *s)
>>> +{
>>> +    vtd_define_quad(s, DMAR_CAP_REG, s->cap, 0, 0);
>>> +    vtd_define_quad(s, DMAR_ECAP_REG, s->ecap, 0, 0);
>>> +}
>>> +
>>>  static int vtd_machine_done_notify_one(Object *child, void *unused)
>>>  {
>>>      IntelIOMMUState *iommu =
>> INTEL_IOMMU_DEVICE(x86_iommu_get_default());
>>> @@ -4259,6 +4314,14 @@ static int
>> vtd_machine_done_notify_one(Object *child, void *unused)
>>>  static void vtd_machine_done_hook(Notifier *notifier, void *unused)
>>>  {
>>> +    IntelIOMMUState *iommu =
>> INTEL_IOMMU_DEVICE(x86_iommu_get_default());
>>> +
>>> +    iommu->cap = iommu->host_cap;
>>> +    iommu->ecap = iommu->host_ecap;
>>> +    iommu->cap_finalized = true;
>> I don't think you can change the defaults like this without taking care
>> of compats (migration).
> Will bump vtd_vmstate .version_id works?
>
> Thanks
> Zhenzhong
>
>> Thanks
>>
>> Eric
>>> +
>>> +    vtd_setup_capability_reg(iommu);
>>> +
>>>      object_child_foreach_recursive(object_get_root(),
>>>                                     vtd_machine_done_notify_one, NULL);
>>>  }
>>> @@ -4292,6 +4355,7 @@ static void vtd_realize(DeviceState *dev, Error
>> **errp)
>>>      QLIST_INIT(&s->vtd_as_with_notifiers);
>>>      qemu_mutex_init(&s->iommu_lock);
>>> +    s->cap_finalized = false;
>>>      memory_region_init_io(&s->csrmem, OBJECT(s), &vtd_mem_ops, s,
>>>                            "intel_iommu", DMAR_REG_SIZE);
>>>      memory_region_add_subregion(get_system_memory(),


