Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB129086E8
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jun 2024 11:01:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI2ne-0001kM-R9; Fri, 14 Jun 2024 05:00:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sI2nd-0001jn-HH
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 05:00:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sI2na-0000yW-0b
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 05:00:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718355640;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uFpz4ZTSWrOF7oYjA80r6wLikmp5jJZEBmXIsTGFvJQ=;
 b=XaC1SloAJWQd8VTgFNVTTilNNWDSxDeWlWU7TxOl07fvbKjboAXpLyV9PYc72ky3PZ5oDm
 j4RRzZVWRH65hB64uESrZ8zSD8Yr+Pgb6Vf/5CZ9/dc4h0pEN3Ih7+8iemtp/jUTXMgbqn
 y0ArdkS+2y/DWTsWDDRg24Oi/JWzgR4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-nfdUOjWeN5GQlqIPkKsVhw-1; Fri, 14 Jun 2024 05:00:38 -0400
X-MC-Unique: nfdUOjWeN5GQlqIPkKsVhw-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-797f788afa8so309945385a.0
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2024 02:00:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718355638; x=1718960438;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uFpz4ZTSWrOF7oYjA80r6wLikmp5jJZEBmXIsTGFvJQ=;
 b=dlYgZBd1pdFlW6DIDURGlWDnAbpjubz7fwQeL4/IfZfV787VUXv5jRFLXY5kQng8P/
 lu4NMAWMppQ1gMAJuikxjXvIoyJagqrXRxW94xn29MTsViQoa2Sg/r8IEigPtpSI5q/3
 uE4Dc0KEYe2GAKb/4jekrKCn17yQewknFbjfjEs/dHNC8xXuliehC04P54SIdEMY/M84
 d7fn2Khijg24wvjOBr8GuQPep2rwscSVysIcWWFRBFuVyVFa2b/ZszsaVQ+WqnWgYNA1
 oVbmeercTt9h2KgYtPp8a5JusmmiiMcE4fLixCn8YMJoC8/5gqpZ6tIG7Aku5gjSGRJx
 qZRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXB9/RHyVNCjF+coyFBderBXCcaxc7qSESnyaLLBfKVP5fk9LE9bNPV4TnBZtLPdAVb4uJ1Pj99+anX+Jjx5ZIpW1aV1zM=
X-Gm-Message-State: AOJu0YyjuqHzGJk3aF6KnSn2FEaK5ppf3CN8NXRu7wH1D5y9bJphEA8U
 vZDYJJwzAlGaKamds2lMw3j/iD4W7t2XrOsXlQKG069ZmWTekJq5L6TW3TwpInwgZq4AlIhDXBe
 ULagD+BgbrYdkDpIejLyhDgYLWXS2UcjEuBIxN5oHXugiaYD4+NdB
X-Received: by 2002:a05:620a:1918:b0:795:2391:bc36 with SMTP id
 af79cd13be357-79810103913mr898697085a.21.1718355638264; 
 Fri, 14 Jun 2024 02:00:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7kjigs05aVzM4q2xu124z7fZDwfxFfa6Q6ZgAuyrWXIEzOh6PcBq3vWTeE23MuWt0Vg9lRw==
X-Received: by 2002:a05:620a:1918:b0:795:2391:bc36 with SMTP id
 af79cd13be357-79810103913mr898692485a.21.1718355637779; 
 Fri, 14 Jun 2024 02:00:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-441ef3d88b7sm14236441cf.13.2024.06.14.02.00.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Jun 2024 02:00:37 -0700 (PDT)
Message-ID: <a937c61f-3d96-49bd-b92a-192a86b0122f@redhat.com>
Date: Fri, 14 Jun 2024 11:00:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] virtio-iommu: Compute host reserved regions
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "clg@redhat.com" <clg@redhat.com>, "yanghliu@redhat.com"
 <yanghliu@redhat.com>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>
References: <20240613092359.847145-1-eric.auger@redhat.com>
 <20240613092359.847145-5-eric.auger@redhat.com>
 <SJ0PR11MB6744A08077F63B0E4535D97292C12@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <107a70a8-b75f-48bb-8df2-7d779b7e889a@redhat.com>
 <SJ0PR11MB67442EC0B322352072F228B392C22@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <SJ0PR11MB67442EC0B322352072F228B392C22@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Zhenzhong,

On 6/14/24 05:05, Duan, Zhenzhong wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Subject: Re: [PATCH v3 4/7] virtio-iommu: Compute host reserved regions
>>
>>
>>
>> On 6/13/24 12:00, Duan, Zhenzhong wrote:
>>> Hi Eric,
>>>
>>>> -----Original Message-----
>>>> From: Eric Auger <eric.auger@redhat.com>
>>>> Subject: [PATCH v3 4/7] virtio-iommu: Compute host reserved regions
>>>>
>>>> Compute the host reserved regions in virtio_iommu_set_iommu_device().
>>>> The usable IOVA regions are retrieved from the HOSTIOMMUDevice.
>>>> The virtio_iommu_set_host_iova_ranges() helper turns usable regions
>>>> into complementary reserved regions while testing the inclusion
>>>> into existing ones. virtio_iommu_set_host_iova_ranges() reuse the
>>>> implementation of virtio_iommu_set_iova_ranges() which will be
>>>> removed in subsequent patches. rebuild_resv_regions() is just moved.
>>>>
>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>>
>>>> ---
>>>>
>>>> - added g_assert(!sdev->probe_done)
>>>> ---
>>>> hw/virtio/virtio-iommu.c | 146 ++++++++++++++++++++++++++++++----
>> ----
>>>> -
>>>> 1 file changed, 112 insertions(+), 34 deletions(-)
>>>>
>>>> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>>>> index db842555c8..04474ebd74 100644
>>>> --- a/hw/virtio/virtio-iommu.c
>>>> +++ b/hw/virtio/virtio-iommu.c
>>>> @@ -498,12 +498,109 @@ get_host_iommu_device(VirtIOIOMMU
>>>> *viommu, PCIBus *bus, int devfn) {
>>>>     return g_hash_table_lookup(viommu->host_iommu_devices, &key);
>>>> }
>>>>
>>>> +/**
>>>> + * rebuild_resv_regions: rebuild resv regions with both the
>>>> + * info of host resv ranges and property set resv ranges
>>>> + */
>>>> +static int rebuild_resv_regions(IOMMUDevice *sdev)
>>>> +{
>>>> +    GList *l;
>>>> +    int i = 0;
>>>> +
>>>> +    /* free the existing list and rebuild it from scratch */
>>>> +    g_list_free_full(sdev->resv_regions, g_free);
>>>> +    sdev->resv_regions = NULL;
>>>> +
>>>> +    /* First add host reserved regions if any, all tagged as RESERVED */
>>>> +    for (l = sdev->host_resv_ranges; l; l = l->next) {
>>>> +        ReservedRegion *reg = g_new0(ReservedRegion, 1);
>>>> +        Range *r = (Range *)l->data;
>>>> +
>>>> +        reg->type = VIRTIO_IOMMU_RESV_MEM_T_RESERVED;
>>>> +        range_set_bounds(&reg->range, range_lob(r), range_upb(r));
>>>> +        sdev->resv_regions = resv_region_list_insert(sdev->resv_regions,
>> reg);
>>>> +        trace_virtio_iommu_host_resv_regions(sdev-
>>>>> iommu_mr.parent_obj.name, i,
>>>> +                                             range_lob(&reg->range),
>>>> +                                             range_upb(&reg->range));
>>>> +        i++;
>>>> +    }
>>>> +    /*
>>>> +     * then add higher priority reserved regions set by the machine
>>>> +     * through properties
>>>> +     */
>>>> +    add_prop_resv_regions(sdev);
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int virtio_iommu_set_host_iova_ranges(VirtIOIOMMU *s, PCIBus
>>>> *bus,
>>>> +                                             int devfn, GList *iova_ranges,
>>>> +                                             Error **errp)
>>>> +{
>>>> +    IOMMUPciBus *sbus = g_hash_table_lookup(s->as_by_busptr, bus);
>>> Here the bus/devfn parameters are real device BDF not aliased one,
>>> But used to index s->as_by_busptr which expect aliased bus/devfn.
>>>
>>> Do we need a translation of bus/devfn?
>> Hum that's a good point actually. I need to further study that. that's
>> not easy to translate, is it?
> Yes, may need a path to call into pci_device_get_iommu_bus_devfn().
> Maybe a new HostIOMMUDevice callback.
>
>> Now I am not totally sure why we don't use the alias as well for
>> HostIOMMUDevices or at least store the aliased bdf.
> Because we need to store HostIOMMUDevice in vIOMMU in real bdf granularity,
> Not aliased bdf granularity. Virtual vtd calls VFIO device uAPI on real device not
> the aliased device, i.e., VFIO_DEVICE_[ATTACH|DETACH]_IOMMUFD_PT.
>
> I also have a question, could we define host_resv_ranges in VirtioHostIOMMUDevice
> to avoid translation?
I would suggest to pass the aliased info through the set_iommu_device()
and store them in the HostIOMMUDevice. I will submit a patch accordingly

Thanks

Eric


>
> Thanks
> Zhenzhong
>
>> Thanks
>>
>> Eric
>>> Thanks
>>> Zhenzhong
>>>
>>>> +    IOMMUDevice *sdev;
>>>> +    GList *current_ranges;
>>>> +    GList *l, *tmp, *new_ranges = NULL;
>>>> +    int ret = -EINVAL;
>>>> +
>>>> +    if (!sbus) {
>>>> +        error_report("%s no sbus", __func__);
>>>> +    }
>>>> +
>>>> +    sdev = sbus->pbdev[devfn];
>>>> +
>>>> +    current_ranges = sdev->host_resv_ranges;
>>>> +
>>>> +    g_assert(!sdev->probe_done);
>>>> +
>>>> +    /* check that each new resv region is included in an existing one */
>>>> +    if (sdev->host_resv_ranges) {
>>>> +        range_inverse_array(iova_ranges,
>>>> +                            &new_ranges,
>>>> +                            0, UINT64_MAX);
>>>> +
>>>> +        for (tmp = new_ranges; tmp; tmp = tmp->next) {
>>>> +            Range *newr = (Range *)tmp->data;
>>>> +            bool included = false;
>>>> +
>>>> +            for (l = current_ranges; l; l = l->next) {
>>>> +                Range * r = (Range *)l->data;
>>>> +
>>>> +                if (range_contains_range(r, newr)) {
>>>> +                    included = true;
>>>> +                    break;
>>>> +                }
>>>> +            }
>>>> +            if (!included) {
>>>> +                goto error;
>>>> +            }
>>>> +        }
>>>> +        /* all new reserved ranges are included in existing ones */
>>>> +        ret = 0;
>>>> +        goto out;
>>>> +    }
>>>> +
>>>> +    range_inverse_array(iova_ranges,
>>>> +                        &sdev->host_resv_ranges,
>>>> +                        0, UINT64_MAX);
>>>> +    rebuild_resv_regions(sdev);
>>>> +
>>>> +    return 0;
>>>> +error:
>>>> +    error_setg(errp, "%s Conflicting host reserved ranges set!",
>>>> +               __func__);
>>>> +out:
>>>> +    g_list_free_full(new_ranges, g_free);
>>>> +    return ret;
>>>> +}
>>>> +
>>>> static bool virtio_iommu_set_iommu_device(PCIBus *bus, void *opaque,
>>>> int devfn,
>>>>                                           HostIOMMUDevice *hiod, Error **errp)
>>>> {
>>>>     VirtIOIOMMU *viommu = opaque;
>>>>     VirtioHostIOMMUDevice *vhiod;
>>>> +    HostIOMMUDeviceClass *hiodc =
>>>> HOST_IOMMU_DEVICE_GET_CLASS(hiod);
>>>>     struct hiod_key *new_key;
>>>> +    GList *host_iova_ranges = NULL;
>>>>
>>>>     assert(hiod);
>>>>
>>>> @@ -513,6 +610,20 @@ static bool
>>>> virtio_iommu_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>>>>         return false;
>>>>     }
>>>>
>>>> +    if (hiodc->get_iova_ranges) {
>>>> +        int ret;
>>>> +        host_iova_ranges = hiodc->get_iova_ranges(hiod, errp);
>>>> +        if (!host_iova_ranges) {
>>>> +            return true; /* some old kernels may not support that capability
>> */
>>>> +        }
>>>> +        ret = virtio_iommu_set_host_iova_ranges(viommu, bus, devfn,
>>>> +                                                host_iova_ranges, errp);
>>>> +        if (ret) {
>>>> +            g_list_free_full(host_iova_ranges, g_free);
>>>> +            return false;
>>>> +        }
>>>> +    }
>>>> +
>>>>     vhiod = g_malloc0(sizeof(VirtioHostIOMMUDevice));
>>>>     vhiod->bus = bus;
>>>>     vhiod->devfn = (uint8_t)devfn;
>>>> @@ -525,6 +636,7 @@ static bool
>>>> virtio_iommu_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>>>>
>>>>     object_ref(hiod);
>>>>     g_hash_table_insert(viommu->host_iommu_devices, new_key, vhiod);
>>>> +    g_list_free_full(host_iova_ranges, g_free);
>>>>
>>>>     return true;
>>>> }
>>>> @@ -1246,40 +1358,6 @@ static int
>>>> virtio_iommu_set_page_size_mask(IOMMUMemoryRegion *mr,
>>>>     return 0;
>>>> }
>>>>
>>>> -/**
>>>> - * rebuild_resv_regions: rebuild resv regions with both the
>>>> - * info of host resv ranges and property set resv ranges
>>>> - */
>>>> -static int rebuild_resv_regions(IOMMUDevice *sdev)
>>>> -{
>>>> -    GList *l;
>>>> -    int i = 0;
>>>> -
>>>> -    /* free the existing list and rebuild it from scratch */
>>>> -    g_list_free_full(sdev->resv_regions, g_free);
>>>> -    sdev->resv_regions = NULL;
>>>> -
>>>> -    /* First add host reserved regions if any, all tagged as RESERVED */
>>>> -    for (l = sdev->host_resv_ranges; l; l = l->next) {
>>>> -        ReservedRegion *reg = g_new0(ReservedRegion, 1);
>>>> -        Range *r = (Range *)l->data;
>>>> -
>>>> -        reg->type = VIRTIO_IOMMU_RESV_MEM_T_RESERVED;
>>>> -        range_set_bounds(&reg->range, range_lob(r), range_upb(r));
>>>> -        sdev->resv_regions = resv_region_list_insert(sdev->resv_regions,
>> reg);
>>>> -        trace_virtio_iommu_host_resv_regions(sdev-
>>>>> iommu_mr.parent_obj.name, i,
>>>> -                                             range_lob(&reg->range),
>>>> -                                             range_upb(&reg->range));
>>>> -        i++;
>>>> -    }
>>>> -    /*
>>>> -     * then add higher priority reserved regions set by the machine
>>>> -     * through properties
>>>> -     */
>>>> -    add_prop_resv_regions(sdev);
>>>> -    return 0;
>>>> -}
>>>> -
>>>> /**
>>>>  * virtio_iommu_set_iova_ranges: Conveys the usable IOVA ranges
>>>>  *
>>>> --
>>>> 2.41.0


