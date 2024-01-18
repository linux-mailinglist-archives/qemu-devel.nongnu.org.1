Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F89831919
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 13:25:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQRSk-0005Rs-Q4; Thu, 18 Jan 2024 07:25:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rQRSW-0005Av-Iy
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 07:25:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rQRSS-000789-Uc
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 07:25:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705580718;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PMGN0Aptn07SIFPxlKczc8frqh2/vdWVw5jn6iR/GmI=;
 b=DqS665uqNMZOrl/wXpdskHkadHDLgF4wekI0duqWJRXp5LAk7wH/J0KMyXcEJzVnqnrMFG
 GIcu87PXN6x+XfxwtrpB44/BCSF2f8633+bM7jOLqKxPUYekX2HvorZ/4TtDdNazpAsezF
 wD88KS6LlMI6p6DSRvP9xUppC/5mQYU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-_imVXFP3OfigSCOt18Saow-1; Thu, 18 Jan 2024 07:25:16 -0500
X-MC-Unique: _imVXFP3OfigSCOt18Saow-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7833751431dso1130702785a.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 04:25:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705580715; x=1706185515;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PMGN0Aptn07SIFPxlKczc8frqh2/vdWVw5jn6iR/GmI=;
 b=vbdCbjX0J1yFXbJzAeUwJJMnlLGRupkeTSWaEg80L+w8M1mLX/Zwox+wNklc8YxEv5
 S9uds5yxz4rN/wOyloPLwU97S9pNiOhu6/86u3qlwz23xm8IjxS8es+FkI10rdF3IxVI
 2FIThDNCHyK7XIKH0tUrQVwcVOw+hCvWdpqHK55PwU9q+iR8YdjLX6bhdl+nfEG21XDy
 tGaLkrDGGQ5KFJfPb8S4YS/ut1W0icHNmBM1iakBsoCKIckLeSpMrWhLDMsgQofSpISh
 dDSKvDCcbMlZOavTvv9T+GaXf/zvQ0N7t7r7hoRJCYuluzVmgd0pMFpjt9FH6PwP1o+x
 4F/w==
X-Gm-Message-State: AOJu0YwFeikwOIrv6oVfF04vfajEn51HJtEByT4Xex0JlfIrEtGons2c
 N4alE7pEFWZnAPF+QfK9vmBlGlbb86qsVQEcD9CfhVMKtCSZZr3aOOMZvA2F3KP/d834MVnuY/6
 La4TPEaPTWx4z+bvCW6XNSd6vPgXV9NnW1WJd/Fal15yyBTC4sw62
X-Received: by 2002:a05:620a:2621:b0:781:a678:9a3f with SMTP id
 z33-20020a05620a262100b00781a6789a3fmr837481qko.115.1705580715629; 
 Thu, 18 Jan 2024 04:25:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4FGXgEF9tHBw8yhi9DRsqE01e8j37X/g6pb7WL7r9w3rLkrX96k9d5fZ6p9uuQju6imIjTA==
X-Received: by 2002:a05:620a:2621:b0:781:a678:9a3f with SMTP id
 z33-20020a05620a262100b00781a6789a3fmr837474qko.115.1705580715379; 
 Thu, 18 Jan 2024 04:25:15 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 os7-20020a05620a810700b007815c25b32bsm5265044qkn.35.2024.01.18.04.25.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jan 2024 04:25:14 -0800 (PST)
Message-ID: <307bbfec-005c-4ca8-8c21-cb39f16812f3@redhat.com>
Date: Thu, 18 Jan 2024 13:25:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 4/7] virtio-iommu: Implement PCIIOMMUOps
 set_host_resv_regions
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "yanghliu@redhat.com" <yanghliu@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Cc: "mst@redhat.com" <mst@redhat.com>, "clg@redhat.com" <clg@redhat.com>
References: <20240117080414.316890-1-eric.auger@redhat.com>
 <20240117080414.316890-5-eric.auger@redhat.com>
 <SJ0PR11MB67443F1D15B5959A77B60E3F92712@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <SJ0PR11MB67443F1D15B5959A77B60E3F92712@SJ0PR11MB6744.namprd11.prod.outlook.com>
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Zhenzhong,
On 1/18/24 08:43, Duan, Zhenzhong wrote:
> Hi Eric,
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Subject: [RFC 4/7] virtio-iommu: Implement PCIIOMMUOps
>> set_host_resv_regions
>>
>> Reuse the implementation of virtio_iommu_set_iova_ranges() which
>> will be removed in subsequent patches.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>> hw/virtio/virtio-iommu.c | 134 +++++++++++++++++++++++++++++---------
>> -
>> 1 file changed, 101 insertions(+), 33 deletions(-)
>>
>> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>> index 8a4bd933c6..716a3fcfbf 100644
>> --- a/hw/virtio/virtio-iommu.c
>> +++ b/hw/virtio/virtio-iommu.c
>> @@ -461,8 +461,109 @@ static AddressSpace
>> *virtio_iommu_find_add_as(PCIBus *bus, void *opaque,
>>     return &sdev->as;
>> }
>>
>> +/**
>> + * rebuild_resv_regions: rebuild resv regions with both the
>> + * info of host resv ranges and property set resv ranges
>> + */
>> +static int rebuild_resv_regions(IOMMUDevice *sdev)
>> +{
>> +    GList *l;
>> +    int i = 0;
>> +
>> +    /* free the existing list and rebuild it from scratch */
>> +    g_list_free_full(sdev->resv_regions, g_free);
>> +    sdev->resv_regions = NULL;
>> +
>> +    /* First add host reserved regions if any, all tagged as RESERVED */
>> +    for (l = sdev->host_resv_ranges; l; l = l->next) {
>> +        ReservedRegion *reg = g_new0(ReservedRegion, 1);
>> +        Range *r = (Range *)l->data;
>> +
>> +        reg->type = VIRTIO_IOMMU_RESV_MEM_T_RESERVED;
>> +        range_set_bounds(&reg->range, range_lob(r), range_upb(r));
>> +        sdev->resv_regions = resv_region_list_insert(sdev->resv_regions, reg);
>> +        trace_virtio_iommu_host_resv_regions(sdev-
>>> iommu_mr.parent_obj.name, i,
>> +                                             range_lob(&reg->range),
>> +                                             range_upb(&reg->range));
>> +        i++;
>> +    }
>> +    /*
>> +     * then add higher priority reserved regions set by the machine
>> +     * through properties
>> +     */
>> +    add_prop_resv_regions(sdev);
>> +    return 0;
>> +}
>> +
>> +static int virtio_iommu_set_host_iova_ranges(PCIBus *bus, void *opaque,
>> +                                             int devfn, GList *iova_ranges,
>> +                                             Error **errp)
>> +{
>> +    VirtIOIOMMU *s = opaque;
>> +    IOMMUPciBus *sbus = g_hash_table_lookup(s->as_by_busptr, bus);
>> +    IOMMUDevice *sdev;
>> +    GList *current_ranges;
>> +    GList *l, *tmp, *new_ranges = NULL;
>> +    int ret = -EINVAL;
>> +
>> +    if (!sbus) {
>> +        error_report("%s no sbus", __func__);
>> +    }
> Do we plan to support multiple devices in same iommu group?
> as_by_busptr is hashed by bus which is an aliased bus of the device.
> So sbus may be NULL if device's bus is different from aliased bus.
If I understand you remark properly this means that

virtio_iommu_set_host_iova_ranges should take as arg the aliased bus and not the bus, right?
I think we shall support non singleton groups too.

>
>> +
>> +    sdev = sbus->pbdev[devfn];
>> +
>> +    current_ranges = sdev->host_resv_ranges;
>> +
>> +    warn_report("%s: host_resv_regions=%d", __func__, !!sdev-
>>> host_resv_ranges);
>> +    /* check that each new resv region is included in an existing one */
>> +    if (sdev->host_resv_ranges) {
> May be we could just error out as vfio_realize should not call
> set_host_iova_ranges() twice.
so if we have several devices in the group,

set_host_iova_ranges()

 may be called several times. Right?

Eric
>
> Thanks
> Zhenzhong
>> +        range_inverse_array(iova_ranges,
>> +                            &new_ranges,
>> +                            0, UINT64_MAX);
>> +
>> +        for (tmp = new_ranges; tmp; tmp = tmp->next) {
>> +            Range *newr = (Range *)tmp->data;
>> +            bool included = false;
>> +
>> +            for (l = current_ranges; l; l = l->next) {
>> +                Range * r = (Range *)l->data;
>> +
>> +                if (range_contains_range(r, newr)) {
>> +                    included = true;
>> +                    break;
>> +                }
>> +            }
>> +            if (!included) {
>> +                goto error;
>> +            }
>> +        }
>> +        /* all new reserved ranges are included in existing ones */
>> +        ret = 0;
>> +        goto out;
>> +    }
>> +
>> +    if (sdev->probe_done) {
>> +        warn_report("%s: Notified about new host reserved regions after
>> probe",
>> +                    __func__);
>> +    }
>> +
>> +    range_inverse_array(iova_ranges,
>> +                        &sdev->host_resv_ranges,
>> +                        0, UINT64_MAX);
>> +    rebuild_resv_regions(sdev);
>> +
>> +    return 0;
>> +error:
>> +    error_setg(errp, "%s Conflicting host reserved ranges set!",
>> +               __func__);
>> +out:
>> +    g_list_free_full(new_ranges, g_free);
>> +    return ret;
>> +}
>> +
>> static const PCIIOMMUOps virtio_iommu_ops = {
>>     .get_address_space = virtio_iommu_find_add_as,
>> +    .set_host_iova_ranges = virtio_iommu_set_host_iova_ranges,
>> };
>>
>> static int virtio_iommu_attach(VirtIOIOMMU *s,
>> @@ -1158,39 +1259,6 @@ static int
>> virtio_iommu_set_page_size_mask(IOMMUMemoryRegion *mr,
>>     return 0;
>> }
>>
>> -/**
>> - * rebuild_resv_regions: rebuild resv regions with both the
>> - * info of host resv ranges and property set resv ranges
>> - */
>> -static int rebuild_resv_regions(IOMMUDevice *sdev)
>> -{
>> -    GList *l;
>> -    int i = 0;
>> -
>> -    /* free the existing list and rebuild it from scratch */
>> -    g_list_free_full(sdev->resv_regions, g_free);
>> -    sdev->resv_regions = NULL;
>> -
>> -    /* First add host reserved regions if any, all tagged as RESERVED */
>> -    for (l = sdev->host_resv_ranges; l; l = l->next) {
>> -        ReservedRegion *reg = g_new0(ReservedRegion, 1);
>> -        Range *r = (Range *)l->data;
>> -
>> -        reg->type = VIRTIO_IOMMU_RESV_MEM_T_RESERVED;
>> -        range_set_bounds(&reg->range, range_lob(r), range_upb(r));
>> -        sdev->resv_regions = resv_region_list_insert(sdev->resv_regions, reg);
>> -        trace_virtio_iommu_host_resv_regions(sdev-
>>> iommu_mr.parent_obj.name, i,
>> -                                             range_lob(&reg->range),
>> -                                             range_upb(&reg->range));
>> -        i++;
>> -    }
>> -    /*
>> -     * then add higher priority reserved regions set by the machine
>> -     * through properties
>> -     */
>> -    add_prop_resv_regions(sdev);
>> -    return 0;
>> -}
>>
>> /**
>>  * virtio_iommu_set_iova_ranges: Conveys the usable IOVA ranges
>> --
>> 2.41.0


