Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 710AF852FD1
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Feb 2024 12:51:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZrI9-0004Yp-Vo; Tue, 13 Feb 2024 06:49:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rZrI7-0004YP-Cz
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 06:49:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rZrI4-0006hF-Jn
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 06:49:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707824970;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vamfsKdPatXVDEl9NBvaAQnKjVOUy27fVpfEjv2u8og=;
 b=PcbpTdghY43u9lJP9Okt7U4fHcp8mFq92qIS4FLTLjObNN2ZfG/GNRIEFb6pHkbSa6bEvY
 TGlXiCvGl/MY6K7eAJHsNwHvecur0xUguKdFvH7bHsCOHJkDNrG6iLrzQ0hSQrlO8PTSRr
 L1ANmGKKSjMYqbqHAscZOeqL8hZy79w=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-8dpytj_MPMaZBmyj1KHiFw-1; Tue, 13 Feb 2024 06:49:27 -0500
X-MC-Unique: 8dpytj_MPMaZBmyj1KHiFw-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7831ed4bb2aso573270885a.0
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 03:49:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707824967; x=1708429767;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vamfsKdPatXVDEl9NBvaAQnKjVOUy27fVpfEjv2u8og=;
 b=BvpDcuR8TOGbB2YTMBDMbGyobuMYgC6VvyEtEN1waiKYvdttuo7ygTaeakLh7oBq3z
 Jb9Ftq3h70l7fz6p9XFF50lVDVpsUKY98b1JU78KksQNuVCiu/nRCCNGpjIAGnXAKOlV
 W8DOODpplDr2ifN5/IXmnfCn3uDUVyM6qfEGryua9oWZlxdWM43dmbsfba1PVpKlUmDh
 OuQHoBt4h9y57m9YLZmOxRDDlDCre/+BzT5IYVJpIK1WRHP82Z3AlyVecC9DI/r4nWXR
 7k6ZkQ11qQybHawxLwsyz9+yhZ6aPs0RxwnycXI4v0fMLVltMTDHidaGJPwnoAybCYFF
 VZSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKBJ6zmfqFgBOo0/IFYADei9fM5JFe+Gpi+wTDmBmXY6yY5DB08gpbPxlG9U5ls0IEHeylsoDe+431UOqBS0l4G6WQiRI=
X-Gm-Message-State: AOJu0Yy5dIfpUkjhYwrv4WCpW8qyDRa5982TJl2jIxRfBZaT+yHiY1nt
 evxQfpAJdpRwcPWgTmAVuLFnxoSq0GxCOsnbBrjVr26ml1OOSmUNHudPfNrG2l/zkPHtwSN591y
 V12uDZ239k7KFv69WSb0Ktwwc8GF5fEy2iTuCkc3RQJkwLunrvpau
X-Received: by 2002:a05:622a:156:b0:42c:70e8:9673 with SMTP id
 v22-20020a05622a015600b0042c70e89673mr8919784qtw.68.1707824967373; 
 Tue, 13 Feb 2024 03:49:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGU2G5xz59LIfcugIwJ5hgcFmI4EWlGB5wxkalnpMWSj9m85QALYEkMjEvDxTwnNxOxUp4+Jw==
X-Received: by 2002:a05:622a:156:b0:42c:70e8:9673 with SMTP id
 v22-20020a05622a015600b0042c70e89673mr8919767qtw.68.1707824967069; 
 Tue, 13 Feb 2024 03:49:27 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUdiG28STtXTCx2p6YRBDdPnw2CEq+1htKK5mBjVUnLYP2PfSJLsutROXi1kOoRDgvfIR47cyxnV7zICB35yaRcdyWfVVlx+WW57K/abiQIamN5UT9+3e8hScdH1+IkVhsCPESUng2vlEHNQ79WEL03sMvL8iBBp40hIXDXpXE0xkc5vpACyrt5PqpsGOkvZiCnpRQ0KLsPAwHo+XJANLEty9z/qd1wVL3ajO6f+/QjkXkt2ndYueeLMaU=
Received: from ?IPV6:2a01:e0a:59e:9d80:4685:ff:fe66:ea36?
 ([2a01:e0a:59e:9d80:4685:ff:fe66:ea36])
 by smtp.gmail.com with ESMTPSA id
 v9-20020a05620a440900b007871c0ab742sm457421qkp.80.2024.02.13.03.49.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 03:49:26 -0800 (PST)
Message-ID: <e45dd358-f0bb-476f-9e84-de77b21f81f5@redhat.com>
Date: Tue, 13 Feb 2024 12:49:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] virtio-iommu: Use qemu_real_host_page_mask as default
 page_size_mask
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 jean-philippe@linaro.org, alex.williamson@redhat.com, clg@redhat.com,
 peter.maydell@linaro.org
References: <20240117132039.332273-1-eric.auger@redhat.com>
 <20240213044312-mutt-send-email-mst@kernel.org>
 <6d4b5766-f8e2-4889-827d-01d3509239f7@redhat.com>
 <20240213060544-mutt-send-email-mst@kernel.org>
 <91f1b2d8-da88-43c3-871f-7c47ef0d9439@redhat.com>
 <20240213063755-mutt-send-email-mst@kernel.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240213063755-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
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



On 2/13/24 12:39, Michael S. Tsirkin wrote:
> On Tue, Feb 13, 2024 at 12:19:16PM +0100, Eric Auger wrote:
>>
>> On 2/13/24 12:07, Michael S. Tsirkin wrote:
>>> On Tue, Feb 13, 2024 at 11:32:13AM +0100, Eric Auger wrote:
>>>> Hi Michael,
>>>>
>>>> On 2/13/24 10:43, Michael S. Tsirkin wrote:
>>>>> On Wed, Jan 17, 2024 at 02:20:39PM +0100, Eric Auger wrote:
>>>>>> We used to set default page_size_mask to qemu_target_page_mask() but
>>>>>> with VFIO assignment it makes more sense to use the actual host page mask
>>>>>> instead.
>>>>>>
>>>>>> So from now on qemu_real_host_page_mask() will be used as a default.
>>>>>> To be able to migrate older code, we increase the vmstat version_id
>>>>>> to 3 and if an older incoming v2 stream is detected we set the previous
>>>>>> default value.
>>>>>>
>>>>>> The new default is well adapted to configs where host and guest have
>>>>>> the same page size. This allows to fix hotplugging VFIO devices on a
>>>>>> 64kB guest and a 64kB host. This test case has been failing before
>>>>>> and even crashing qemu with hw_error("vfio: DMA mapping failed,
>>>>>> unable to continue") in VFIO common). Indeed the hot-attached VFIO
>>>>>> device would call memory_region_iommu_set_page_size_mask with 64kB
>>>>>> mask whereas after the granule was frozen to 4kB on machine init done.
>>>>>> Now this works. However the new default will prevent 4kB guest on
>>>>>> 64kB host because the granule will be set to 64kB which would be
>>>>>> larger than the guest page size. In that situation, the virtio-iommu
>>>>>> driver fails on viommu_domain_finalise() with
>>>>>> "granule 0x10000 larger than system page size 0x1000".
>>>>>>
>>>>>> The current limitation of global granule in the virtio-iommu
>>>>>> should be removed and turned into per domain granule. But
>>>>>> until we get this upgraded, this new default is probably
>>>>>> better because I don't think anyone is currently interested in
>>>>>> running a 4kB page size guest with virtio-iommu on a 64kB host.
>>>>>> However supporting 64kB guest on 64kB host with virtio-iommu and
>>>>>> VFIO looks a more important feature.
>>>>>>
>>>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>>>> Tested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>>>>> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>>>> What about migration compatibility? In particular, cross-version one?
>>>>> Don't we need compat machinery for this?
>>>> See below
>>>>>> ---
>>>>>>
>>>>>> v1 -> v2:
>>>>>> - fixed 2 typos in the commit msg and added Jean's R-b and T-b
>>>>>> ---
>>>>>>  hw/virtio/virtio-iommu.c | 7 +++++--
>>>>>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>>>>>> index 8a4bd933c6..ec2ba11d1d 100644
>>>>>> --- a/hw/virtio/virtio-iommu.c
>>>>>> +++ b/hw/virtio/virtio-iommu.c
>>>>>> @@ -1313,7 +1313,7 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
>>>>>>       * in vfio realize
>>>>>>       */
>>>>>>      s->config.bypass = s->boot_bypass;
>>>>>> -    s->config.page_size_mask = qemu_target_page_mask();
>>>>>> +    s->config.page_size_mask = qemu_real_host_page_mask();
>>>>>>      s->config.input_range.end = UINT64_MAX;
>>>>>>      s->config.domain_range.end = UINT32_MAX;
>>>>>>      s->config.probe_size = VIOMMU_PROBE_SIZE;
>>>>>> @@ -1491,13 +1491,16 @@ static int iommu_post_load(void *opaque, int version_id)
>>>>>>       * still correct.
>>>>>>       */
>>>>>>      virtio_iommu_switch_address_space_all(s);
>>>>>> +    if (version_id <= 2) {
>>>>>> +        s->config.page_size_mask = qemu_target_page_mask();
>>>> I tested migration from v2 -> v3 and the above code is overriding the
>>>> new default by the older one.
>>>>
>>>> Do you have an other concern?
>>>>
>>>> Thanks
>>>>
>>>> Eric
>>>
>>>>>> +    }
>>>>>>      return 0;
>>>>>>  }
>>>>>>  
>>>>>>  static const VMStateDescription vmstate_virtio_iommu_device = {
>>>>>>      .name = "virtio-iommu-device",
>>>>>>      .minimum_version_id = 2,
>>>>>> -    .version_id = 2,
>>>>>> +    .version_id = 3,
>>>>>>      .post_load = iommu_post_load,
>>>>>>      .fields = (const VMStateField[]) {
>>>>>>          VMSTATE_GTREE_DIRECT_KEY_V(domains, VirtIOIOMMU, 2,
>>> Oh I missed the version change. But then migration  to older version
>>> is completely broken isn't it? Old qemu can not handle version_id 3 at
>>> all.
>> Indeed, I considered migrating backyard was not that much important. Do
>> you consider this is mandated?
>>
>> Eric
> Generally yes. We only ship downstream but e.g. any RHEL major version
> migrates to same major version in any direction as people have clusters
> mixing different versions. It's easier to maintain that guarantee
> upstream than break it upstream and try to fix it downstream.

OK then I will revisit the implementation

thanks

Eric
>
>
>>> Generally, compat machinery is nicer than the old version hacks.
>>>
>>>
>>>>>> -- 
>>>>>> 2.41.0


