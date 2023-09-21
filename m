Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C78807A9487
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 15:10:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjJRC-0004TN-Fz; Thu, 21 Sep 2023 09:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qjJQy-00049c-T2
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 09:09:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qjJQu-0006NG-Kn
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 09:09:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695301767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=13vvfQKiALPXnWulUQ4FjXCVS+jk6RnCwNFI5srYqDw=;
 b=DiriKbWoAddsDKC0EGIm1qAv60tsvP3igR2yb8W5fOUapfp7Rxox92xjx+y93Wum+AMdPm
 Tlr6g6JM3/cJFMKQLHYWL7ZHb/OWRYDSdjXxPOkxmQ0IEC0oUbgV0Un3woSEiHSfG1KiXe
 V57IFxoguvyBe6sa9LW0znFS/XPF1yg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-_-cPKhG3P36-ELRZlMhPhA-1; Thu, 21 Sep 2023 06:55:59 -0400
X-MC-Unique: _-cPKhG3P36-ELRZlMhPhA-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7740a95a29aso51567085a.0
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 03:55:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695293759; x=1695898559;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=13vvfQKiALPXnWulUQ4FjXCVS+jk6RnCwNFI5srYqDw=;
 b=Ujmvtz93ugKyDnpsjHlxpcj1J4lVdlnj36oLE69E7TNoL/TX7r6p9Bj1OuHFt90sIv
 qaVRKjCIvZIiuCSdaB/XinorSeic81Im4xru0yfwltD1ecO+Rpfi/SLtT0uM21MxeZXJ
 TIsdU4MIxZKmaTFoU4jpWtm4ctPz8V01FKEyDlBUJN5NUltpAghi/QHaOAyQ1QQXOtbS
 S4nl7mL1D7TN+1G9uIc4ATeR/Sc3iCI1LWfJprYXVpp6RlF39JlNxWNuWbzaV179gM7x
 huF0gUAYJrh9Sz8Ythmt+lkuWgescpX90SnU2n0zR+Ko1zXzDkVhElXU7wHniaLvAolh
 B3iQ==
X-Gm-Message-State: AOJu0YwWEgMYfwTe8k24PQbPZ4xZ5FkrNgq2en47lGrzOG76APcfcsq7
 WpWMrjqB3TbHV/N4IFSfbWVxyAZUytrR9t4/o4TYpzVl27M3QMRyv9Q8dRLwHZn7Zxf29ZvNXuP
 BPb/jzSWfQc7/Bk4=
X-Received: by 2002:a05:620a:2a08:b0:767:eb51:ac27 with SMTP id
 o8-20020a05620a2a0800b00767eb51ac27mr5603295qkp.5.1695293759345; 
 Thu, 21 Sep 2023 03:55:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHe1EIKJLxsiLv7UDOJW68izwzL85K7MlS5cPX/39jnb8QRN2ylWmKO8h71qOmXS01MTN+Ofg==
X-Received: by 2002:a05:620a:2a08:b0:767:eb51:ac27 with SMTP id
 o8-20020a05620a2a0800b00767eb51ac27mr5603286qkp.5.1695293759076; 
 Thu, 21 Sep 2023 03:55:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 z13-20020a05620a100d00b00754b7ee6922sm493521qkj.9.2023.09.21.03.55.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Sep 2023 03:55:58 -0700 (PDT)
Message-ID: <c46f7736-9073-b6eb-e52d-e4988423f5d0@redhat.com>
Date: Thu, 21 Sep 2023 12:55:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 04/22] vfio/common: Introduce
 vfio_container_add|del_section_window()
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-5-zhenzhong.duan@intel.com>
 <facf584a-e8bf-5386-8660-ac7dd3e6dde8@redhat.com>
 <SJ0PR11MB6744CFE4E7D6AB400FD8BE6D92F8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB6744CFE4E7D6AB400FD8BE6D92F8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/21/23 12:14, Duan, Zhenzhong wrote:
> Hi Cédric,
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Sent: Thursday, September 21, 2023 4:29 PM
>> Subject: Re: [PATCH v1 04/22] vfio/common: Introduce
>> vfio_container_add|del_section_window()
>>
>> Hello Zhenzhong,
>>
>> On 8/30/23 12:37, Zhenzhong Duan wrote:
>>> From: Eric Auger <eric.auger@redhat.com>
>>>
>>> Introduce helper functions that isolate the code used for
>>> VFIO_SPAPR_TCE_v2_IOMMU. This code reliance is IOMMU backend
>>> specific whereas the rest of the code in the callers, ie.
>>> vfio_listener_region_add|del is not.
>>>
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>    hw/vfio/common.c | 156 +++++++++++++++++++++++++++--------------------
>>>    1 file changed, 89 insertions(+), 67 deletions(-)
>>>
>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>>> index 9ca695837f..67150e4575 100644
>>> --- a/hw/vfio/common.c
>>> +++ b/hw/vfio/common.c
>>> @@ -796,6 +796,92 @@ static bool
>> vfio_get_section_iova_range(VFIOContainer *container,
>>>        return true;
>>>    }
>>>
>>> +static int vfio_container_add_section_window(VFIOContainer *container,
>>> +                                             MemoryRegionSection *section,
>>> +                                             Error **errp)
>>> +{
>>> +    VFIOHostDMAWindow *hostwin;
>>> +    hwaddr pgsize = 0;
>>> +    int ret;
>>> +
>>> +    if (container->iommu_type != VFIO_SPAPR_TCE_v2_IOMMU) {
>>> +        return 0;
>>> +    }
>>
>> This test makes me think that we should register a specific backend
>> for the pseries machines, implementing the add/del_window handler,
>> since others do not need it. Correct ?
> 
> Yes, introducing a specific backend could help removing above check.
> But each backend has a VFIOIOMMUBackendOps, we need same check
> as above to select Ops.
> 
>>
>> It would avoid this ugly test. Let's keep that in mind when the
>> backends are introduced.
>>
>>> +
>>> +    /* For now intersections are not allowed, we may relax this later */
>>> +    QLIST_FOREACH(hostwin, &container->hostwin_list, hostwin_next) {
>>> +        if (ranges_overlap(hostwin->min_iova,
>>> +                           hostwin->max_iova - hostwin->min_iova + 1,
>>> +                           section->offset_within_address_space,
>>> +                           int128_get64(section->size))) {
>>> +            error_setg(errp,
>>> +                "region [0x%"PRIx64",0x%"PRIx64"] overlaps with existing"
>>> +                "host DMA window [0x%"PRIx64",0x%"PRIx64"]",
>>> +                section->offset_within_address_space,
>>> +                section->offset_within_address_space +
>>> +                    int128_get64(section->size) - 1,
>>> +                hostwin->min_iova, hostwin->max_iova);
>>> +            return -EINVAL;
>>> +        }
>>> +    }
>>> +
>>> +    ret = vfio_spapr_create_window(container, section, &pgsize);
>>> +    if (ret) {
>>> +        error_setg_errno(errp, -ret, "Failed to create SPAPR window");
>>> +        return ret;
>>> +    }
>>> +
>>> +    vfio_host_win_add(container, section->offset_within_address_space,
>>> +                      section->offset_within_address_space +
>>> +                      int128_get64(section->size) - 1, pgsize);
>>> +#ifdef CONFIG_KVM
>>
>> the ifdef test doesn't seem useful because the compiler should compile
>> out the section below since, in that case, kvm_enabled() is defined as :
>>
>>    #define kvm_enabled()           (0)
> 
> Looks so, I'll remove it in v2.
> 
>>
>>> +    if (kvm_enabled()) {
>>> +        VFIOGroup *group;
>>> +        IOMMUMemoryRegion *iommu_mr =
>> IOMMU_MEMORY_REGION(section->mr);
>>> +        struct kvm_vfio_spapr_tce param;
>>> +        struct kvm_device_attr attr = {
>>> +            .group = KVM_DEV_VFIO_GROUP,
>>> +            .attr = KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE,
>>> +            .addr = (uint64_t)(unsigned long)&param,
>>> +        };
>>> +
>>> +        if (!memory_region_iommu_get_attr(iommu_mr,
>> IOMMU_ATTR_SPAPR_TCE_FD,
>>> +                                          &param.tablefd)) {
>>> +            QLIST_FOREACH(group, &container->group_list, container_next) {
>>> +                param.groupfd = group->fd;
>>> +                if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
>>> +                    error_report("vfio: failed to setup fd %d "
>>> +                                 "for a group with fd %d: %s",
>>> +                                 param.tablefd, param.groupfd,
>>> +                                 strerror(errno));
>>> +                    return 0;
>>
>> hmm, the code bails out directly without undoing previous actions. we should
>> return some error at least.
> 
> I think Eric doesn't intend any functional change in this patch, just refactor these
> code into two wrapper functions. In fact the original code just return void,
> if ioctl() fails. Not clear if that's intentional or a bug.
> 
>>
>>> +                }
>>> +                trace_vfio_spapr_group_attach(param.groupfd, param.tablefd);
>>> +            }
>>> +        }
>>> +    }
>>> +#endif
>>> +    return 0;
>>> +}
>>> +
>>> +static void vfio_container_del_section_window(VFIOContainer *container,
>>> +                                              MemoryRegionSection *section)
>>> +{
>>> +    if (container->iommu_type != VFIO_SPAPR_TCE_v2_IOMMU) {
>>> +        return;
>>> +    }
>>> +
>>> +    vfio_spapr_remove_window(container,
>>> +                             section->offset_within_address_space);
>>> +    if (vfio_host_win_del(container,
>>> +                          section->offset_within_address_space,
>>> +                          section->offset_within_address_space +
>>> +                          int128_get64(section->size) - 1) < 0) {
>>> +        hw_error("%s: Cannot delete missing window at %"HWADDR_PRIx,
>>> +                 __func__, section->offset_within_address_space);
>>> +    }
>>> +}
>>> +
>>>    static void vfio_listener_region_add(MemoryListener *listener,
>>>                                         MemoryRegionSection *section)
>>>    {
>>> @@ -822,62 +908,8 @@ static void vfio_listener_region_add(MemoryListener
>> *listener,
>>>            return;
>>>        }
>>>
>>> -    if (container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU) {
>>> -        hwaddr pgsize = 0;
>>> -
>>> -        /* For now intersections are not allowed, we may relax this later */
>>> -        QLIST_FOREACH(hostwin, &container->hostwin_list, hostwin_next) {
>>> -            if (ranges_overlap(hostwin->min_iova,
>>> -                               hostwin->max_iova - hostwin->min_iova + 1,
>>> -                               section->offset_within_address_space,
>>> -                               int128_get64(section->size))) {
>>> -                error_setg(&err,
>>> -                    "region [0x%"PRIx64",0x%"PRIx64"] overlaps with existing"
>>> -                    "host DMA window [0x%"PRIx64",0x%"PRIx64"]",
>>> -                    section->offset_within_address_space,
>>> -                    section->offset_within_address_space +
>>> -                        int128_get64(section->size) - 1,
>>> -                    hostwin->min_iova, hostwin->max_iova);
>>> -                goto fail;
>>> -            }
>>> -        }
>>> -
>>> -        ret = vfio_spapr_create_window(container, section, &pgsize);
>>> -        if (ret) {
>>> -            error_setg_errno(&err, -ret, "Failed to create SPAPR window");
>>> -            goto fail;
>>> -        }
>>> -
>>> -        vfio_host_win_add(container, section->offset_within_address_space,
>>> -                          section->offset_within_address_space +
>>> -                          int128_get64(section->size) - 1, pgsize);
>>> -#ifdef CONFIG_KVM
>>> -        if (kvm_enabled()) {
>>> -            VFIOGroup *group;
>>> -            IOMMUMemoryRegion *iommu_mr =
>> IOMMU_MEMORY_REGION(section->mr);
>>> -            struct kvm_vfio_spapr_tce param;
>>> -            struct kvm_device_attr attr = {
>>> -                .group = KVM_DEV_VFIO_GROUP,
>>> -                .attr = KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE,
>>> -                .addr = (uint64_t)(unsigned long)&param,
>>> -            };
>>> -
>>> -            if (!memory_region_iommu_get_attr(iommu_mr,
>> IOMMU_ATTR_SPAPR_TCE_FD,
>>> -                                              &param.tablefd)) {
>>> -                QLIST_FOREACH(group, &container->group_list, container_next) {
>>> -                    param.groupfd = group->fd;
>>> -                    if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
>>> -                        error_report("vfio: failed to setup fd %d "
>>> -                                     "for a group with fd %d: %s",
>>> -                                     param.tablefd, param.groupfd,
>>> -                                     strerror(errno));
>>> -                        return;
>>> -                    }
>>> -                    trace_vfio_spapr_group_attach(param.groupfd, param.tablefd);
>>> -                }
>>> -            }
>>> -        }
>>> -#endif
>>> +    if (vfio_container_add_section_window(container, section, &err)) {
>>> +        goto fail;
>>
>> That's not exactly the same as the return above when the ioctl call
>> fails. there doesn't seem to be much consequences though. Let's keep
>> it that way.
> OK.
> 
>>
>>>        }
>>>
>>>        hostwin = vfio_find_hostwin(container, iova, end);
>>> @@ -1094,17 +1126,7 @@ static void
>> vfio_listener_region_del(MemoryListener *listener,
>>>
>>>        memory_region_unref(section->mr);
>>>
>>> -    if (container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU) {
>>> -        vfio_spapr_remove_window(container,
>>> -                                 section->offset_within_address_space);
>>> -        if (vfio_host_win_del(container,
>>> -                              section->offset_within_address_space,
>>> -                              section->offset_within_address_space +
>>> -                              int128_get64(section->size) - 1) < 0) {
>>> -            hw_error("%s: Cannot delete missing window at %"HWADDR_PRIx,
>>> -                     __func__, section->offset_within_address_space);
>>> -        }
>>> -    }
>>> +    vfio_container_del_section_window(container, section);
>>>    }
>>>
>>>    static int vfio_set_dirty_page_tracking(VFIOContainer *container, bool start)
>>
>> PPC is in the way. May be we could move these two routines in pseries to
>> help a little. I will look into it.
> Do you mean PPC cleanup?

I will see if we can move out of VFIO the implementation of the spapr routines.
Don't wait for me. It can be addressed in parallel.

Thanks,

C.


> 
> Thanks
> Zhenzhong
> 


