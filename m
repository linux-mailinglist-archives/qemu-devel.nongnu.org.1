Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0C6831615
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 10:45:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQOwW-0004YV-68; Thu, 18 Jan 2024 04:44:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rQOwU-0004Y1-Ch
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 04:44:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rQOwO-0002Hg-Ht
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 04:44:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705571043;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L1eWFuvbPN2XWYlwmX84RL9N5C6TGdAt+GZgn+IeD54=;
 b=QI0VihlqSA7cy3T8gmtlH1xePwDx/SfQt2Jf+h0Q+9b+X/sA0ESB8Hjp3u39p78OAMcr79
 c4l7xXQuFRDvoYtJlhkqBDj93Uw3dCGf+YOlXb/hzcpixGKTmH75oxrxmDT1cqDYXWpHE9
 cBqMo/v8CJNAivSTE1yzwbDv/RWJFfI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-nFLkswQ1ObuM2GvjiU_ssg-1; Thu, 18 Jan 2024 04:44:01 -0500
X-MC-Unique: nFLkswQ1ObuM2GvjiU_ssg-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-78333746457so1120297285a.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 01:44:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705571041; x=1706175841;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L1eWFuvbPN2XWYlwmX84RL9N5C6TGdAt+GZgn+IeD54=;
 b=pk6SlB4bCYs5W22N2MhRi3nUfVk2oa1hagQB9UM3GW0fyBQ5oeXB9GzdTbCSHkRi1U
 g7/oMe2orLs1hSpBludz2geEzUo36qRRuethYKgIUin50nlYLPJC4pE0ncSyPxES8Tux
 EZnQ+tM7/SBUWCIUg85QwWo2cslAxrFXWSj+Dg6hAvnGnlFQkmXfdEngUOXJQJK7Wr2i
 KpzQq1BXpjvBIH/dkrEZVBCV2CZFWIQLAhvQicjXtIe+CFYQ0+uFM8SPCvlSCJU8Gx+j
 QhBlSsEQ4V5rK70Gl+hPn381opvbjp9X9mF8VAqOuJEuSO8jVC6CPQZdiQbZDG0hGRDg
 WfQQ==
X-Gm-Message-State: AOJu0Yxwhl4hrbFlMfGvUEmSMOwdok6oaxSaJXuabm9VsWqEJKj4k01E
 o8pKUXzsC+lhMyexwmvCpt2pRe+Zj/o2ijzQo2g/3wafusGbDpqNEVRdql5p2Wm5/MGHahry+Nz
 f217c6JeDYEkOZUSp0U9lr+9JfMzt7+ai6dvzp3p3iqioRK11Wi+/
X-Received: by 2002:a37:ac0c:0:b0:783:3f20:4120 with SMTP id
 e12-20020a37ac0c000000b007833f204120mr456855qkm.86.1705571041200; 
 Thu, 18 Jan 2024 01:44:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgvODMo8GP0glw7P5P3yjFik4tZc6C0uWwnrtQotfoSSpuwmx81b44kuwM6b4AOpugiG466A==
X-Received: by 2002:a37:ac0c:0:b0:783:3f20:4120 with SMTP id
 e12-20020a37ac0c000000b007833f204120mr456841qkm.86.1705571040965; 
 Thu, 18 Jan 2024 01:44:00 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 w15-20020ae9e50f000000b007837a9b3590sm463258qkf.65.2024.01.18.01.43.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jan 2024 01:43:59 -0800 (PST)
Message-ID: <7bc955a1-f58d-43b1-8e95-c452bb11f208@redhat.com>
Date: Thu, 18 Jan 2024 10:43:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/7] VIRTIO-IOMMU/VFIO: Fix host iommu geometry handling for
 hotplugged devices
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
 <SJ0PR11MB6744C50921CC63221A93C75492712@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <SJ0PR11MB6744C50921CC63221A93C75492712@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Zhenzhong,
On 1/18/24 08:10, Duan, Zhenzhong wrote:
> Hi Eric,
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Cc: mst@redhat.com; clg@redhat.com
>> Subject: [RFC 0/7] VIRTIO-IOMMU/VFIO: Fix host iommu geometry handling
>> for hotplugged devices
>>
>> In [1] we attempted to fix a case where a VFIO-PCI device protected
>> with a virtio-iommu was assigned to an x86 guest. On x86 the physical
>> IOMMU may have an address width (gaw) of 39 or 48 bits whereas the
>> virtio-iommu used to expose a 64b address space by default.
>> Hence the guest was trying to use the full 64b space and we hit
>> DMA MAP failures. To work around this issue we managed to pass
>> usable IOVA regions (excluding the out of range space) from VFIO
>> to the virtio-iommu device. This was made feasible by introducing
>> a new IOMMU Memory Region callback dubbed iommu_set_iova_regions().
>> This latter gets called when the IOMMU MR is enabled which
>> causes the vfio_listener_region_add() to be called.
>>
>> However with VFIO-PCI hotplug, this technique fails due to the
>> race between the call to the callback in the add memory listener
>> and the virtio-iommu probe request. Indeed the probe request gets
>> called before the attach to the domain. So in that case the usable
>> regions are communicated after the probe request and fail to be
>> conveyed to the guest. To be honest the problem was hinted by
>> Jean-Philippe in [1] and I should have been more careful at
>> listening to him and testing with hotplug :-(
> It looks the global virtio_iommu_config.bypass is never cleared in guest.
> When guest virtio_iommu driver enable IOMMU, should it clear this
> bypass attribute?
> If it could be cleared in viommu_probe(), then qemu will call
> virtio_iommu_set_config() then virtio_iommu_switch_address_space_all()
> to enable IOMMU MR. Then both coldplugged and hotplugged devices will work.

this field is iommu wide while the probe applies on a one device.In
general I would prefer not to be dependent on the MR enablement. We know
that the device is likely to be protected and we can collect its
requirements beforehand.
>
> Intel iommu has a similar bit in register GCMD_REG.TE, when guest
> intel_iommu driver probe set it, on qemu side, vtd_address_space_refresh_all()
> is called to enable IOMMU MRs.
interesting.

Would be curious to get Jean Philippe's pov.
>
>> For coldplugged device the technique works because we make sure all
>> the IOMMU MR are enabled once on the machine init done: 94df5b2180
>> ("virtio-iommu: Fix 64kB host page size VFIO device assignment")
>> for granule freeze. But I would be keen to get rid of this trick.
>>
>> Using an IOMMU MR Ops is unpractical because this relies on the IOMMU
>> MR to have been enabled and the corresponding vfio_listener_region_add()
>> to be executed. Instead this series proposes to replace the usage of this
>> API by the recently introduced PCIIOMMUOps: ba7d12eb8c  ("hw/pci:
>> modify
>> pci_setup_iommu() to set PCIIOMMUOps"). That way, the callback can be
>> called earlier, once the usable IOVA regions have been collected by
>> VFIO, without the need for the IOMMU MR to be enabled.
>>
>> This looks cleaner. In the short term this may also be used for
>> passing the page size mask, which would allow to get rid of the
>> hacky transient IOMMU MR enablement mentionned above.
>>
>> [1] [PATCH v4 00/12] VIRTIO-IOMMU/VFIO: Don't assume 64b IOVA space
>>    https://lore.kernel.org/all/20231019134651.842175-1-
>> eric.auger@redhat.com/
>>
>> [2] https://lore.kernel.org/all/20230929161547.GB2957297@myrica/
>>
>> Extra Notes:
>> With that series, the reserved memory regions are communicated on time
>> so that the virtio-iommu probe request grabs them. However this is not
>> sufficient. In some cases (my case), I still see some DMA MAP failures
>> and the guest keeps on using IOVA ranges outside the geometry of the
>> physical IOMMU. This is due to the fact the VFIO-PCI device is in the
>> same iommu group as the pcie root port. Normally the kernel
>> iova_reserve_iommu_regions (dma-iommu.c) is supposed to call
>> reserve_iova()
>> for each reserved IOVA, which carves them out of the allocator. When
>> iommu_dma_init_domain() gets called for the hotplugged vfio-pci device
>> the iova domain is already allocated and set and we don't call
>> iova_reserve_iommu_regions() again for the vfio-pci device. So its
>> corresponding reserved regions are not properly taken into account.
> I suspect there is same issue with coldplugged devices. If those devices
> are in same group, get iova_reserve_iommu_regions() is only called
> for first device. But other devices's reserved regions are missed.

Correct
>
> Curious how you make passthrough device and pcie root port under same
> group.
> When I start a x86 guest with passthrough device, I see passthrough
> device and pcie root port are in different group.
>
> -[0000:00]-+-00.0
>            +-01.0
>            +-02.0
>            +-03.0-[01]----00.0
>
> /sys/kernel/iommu_groups/3/devices:
> 0000:00:03.0
> /sys/kernel/iommu_groups/7/devices:
> 0000:01:00.0
>
> My qemu cmdline:
> -device pcie-root-port,id=root0,slot=0
> -device vfio-pci,host=6f:01.0,id=vfio0,bus=root0

I just replayed the scenario:
- if you have a coldplugged vfio-pci device, the pci root port and the
passthroughed device end up in different iommu groups. On my end I use
ioh3420 but you confirmed that's the same for the generic pcie-root-port
- however if you hotplug the vfio-pci device that's a different story:
they end up in the same group. Don't ask me why. I tried with
both virtio-iommu and intel iommu and I end up with the same topology.
That looks really weird to me.

I initially thought this was an ACS issue but I am now puzzled.

Thanks!

Eric
>
> Thanks
> Zhenzhong
>
>> This is not trivial to fix because theoretically the 1st attached
>> devices could already have allocated IOVAs within the reserved regions
>> of the second device. Also we are somehow hijacking the reserved
>> memory regions to model the geometry of the physical IOMMU so not sure
>> any attempt to fix that upstream will be accepted. At the moment one
>> solution is to make sure assigned devices end up in singleton group.
>> Another solution is to work on a different approach where the gaw
>> can be passed as an option to the virtio-iommu device, similarly at
>> what is done with intel iommu.
>>
>> This series can be found at:
>> https://github.com/eauger/qemu/tree/hotplug-resv-rfc
>>
>>
>> Eric Auger (7):
>>  hw/pci: Introduce PCIIOMMUOps::set_host_iova_regions
>>  hw/pci: Introduce pci_device_iommu_bus
>>  vfio/pci: Pass the usable IOVA ranges through PCIIOMMUOps
>>  virtio-iommu: Implement PCIIOMMUOps set_host_resv_regions
>>  virtio-iommu: Remove the implementation of iommu_set_iova_ranges
>>  hw/vfio: Remove memory_region_iommu_set_iova_ranges() call
>>  memory: Remove IOMMU MR iommu_set_iova_range API
>>
>> include/exec/memory.h    |  32 -------
>> include/hw/pci/pci.h     |  16 ++++
>> hw/pci/pci.c             |  16 ++++
>> hw/vfio/common.c         |  10 --
>> hw/vfio/pci.c            |  27 ++++++
>> hw/virtio/virtio-iommu.c | 201 ++++++++++++++++++++-------------------
>> system/memory.c          |  13 ---
>> 7 files changed, 160 insertions(+), 155 deletions(-)
>>
>> --
>> 2.41.0


