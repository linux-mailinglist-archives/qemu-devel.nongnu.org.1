Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2BE82F0C9
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 15:46:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPkgO-0003wB-Ja; Tue, 16 Jan 2024 09:44:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rPkgE-0003sw-JS
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 09:44:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rPkgC-0006wp-Py
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 09:44:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705416276;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=28Kn8cex8y9+iSmT8GYpAOyhIo/pnm+omlqhBsqFdXA=;
 b=D9YIL3/EfqDOyi3f3aupSm7pEsZvTBiTovJn1RyfYxt/iK5cVdk5IpdhIsAgny4pnNh9s5
 NWVCGD9o0stgIjZqijODeGglEUoQvB7GR93rKmABw4h9t3Z8efSDVuA1lDZqmo+IlfN6Fs
 me2qR6FrnETI73cZuxJC5wkCJ542AwQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-k_7864VlOPG8uJhzN7DzXg-1; Tue, 16 Jan 2024 09:44:34 -0500
X-MC-Unique: k_7864VlOPG8uJhzN7DzXg-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-680118b101fso196755756d6.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 06:44:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705416274; x=1706021074;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=28Kn8cex8y9+iSmT8GYpAOyhIo/pnm+omlqhBsqFdXA=;
 b=IXuVUtti69q7T/+GtoXbw8G7oMPqWCB2tXBA+0ncHacEJLHehk7F3orIBCeEkzWVqY
 VaXc7tc6wMj3NlO2E9tSIgqW+A0jyguWMiL1mHq7dlsmq8G1Dyn4BM03YCq/vhV7ljJU
 VpV/VzT5FC/CT+/T5+/o+9vgIAEUNs6J1BhgOv/nkxi2iNzibwQFPGl46QGKtLa+caHl
 YTDHqlHz78jUIwqce3mx8q431TS6NztfKtLzPt+/zEr/2OB2Dlt19ZdTA1IxV11FGZew
 ji9SKBqXTNNoPpA+NPzK/EgrwpDczEKfN+B9qqX2UML3+Cw4jcBiXT6HMw7MHZ70JVSf
 rV7w==
X-Gm-Message-State: AOJu0Yzq9kfhF915b7Q5/9VkkixE+ZhpnvCN1p1FBHTR3T736JbdwpTQ
 lex3sJgKz/OWjDf2UN87Atrt1iBILsTBHNr1pxtUosHSDBRA50/dqP0FTMIdrFCPZlEO7Png1XZ
 xbPbKNwAXZXcB/kBrOx9rPmg=
X-Received: by 2002:a05:6214:258e:b0:680:b48c:b543 with SMTP id
 fq14-20020a056214258e00b00680b48cb543mr9453232qvb.64.1705416274310; 
 Tue, 16 Jan 2024 06:44:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfCDMJh+sjTHvwcybiQQuqZZ9fc8dC47B1Fwd//vwgnZwEIuDvu+ih5xcT+vFASGm+AIBxeA==
X-Received: by 2002:a05:6214:258e:b0:680:b48c:b543 with SMTP id
 fq14-20020a056214258e00b00680b48cb543mr9453217qvb.64.1705416273985; 
 Tue, 16 Jan 2024 06:44:33 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ez15-20020ad4590f000000b0068116eaf26bsm4236319qvb.114.2024.01.16.06.44.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jan 2024 06:44:33 -0800 (PST)
Message-ID: <b513dd07-e696-411f-9c8a-ca1a8a6269f4@redhat.com>
Date: Tue, 16 Jan 2024 15:44:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-iommu: Use qemu_real_host_page_mask as default
 page_size_mask
Content-Language: en-US
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, mst@redhat.com, clg@redhat.com,
 alex.williamson@redhat.com
References: <20231221134505.100916-1-eric.auger@redhat.com>
 <20240116125359.GA710190@myrica>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240116125359.GA710190@myrica>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Jean,

On 1/16/24 13:53, Jean-Philippe Brucker wrote:
> On Thu, Dec 21, 2023 at 08:45:05AM -0500, Eric Auger wrote:
>> We used to set default page_size_mask to qemu_target_page_mask() but
>> with VFIO assignment it makes more sense to use the actual host page mask
>> instead.
>>
>> So from now on qemu_real_host_page_mask() will be used as a default.
>> To be able to migrate older code, we increase the vmstat version_id
>> to 3 and if an older incoming v2 stream is detected we set the previous
>> default value.
>>
>> The new default is well adapted to configs where host and guest have
>> the same page size. This allows to fix hotplugging VFIO devices on a
>> 64kB guest and a 64kB host. This test case has been failing before
>> and even crashing qemu with hw_error("vfio: DMA mapping failed,
>> unable to continue") in VFIO common). Indeed the hot-attached VFIO
>> device would call memory_region_iommu_set_page_size_mask with 64kB
>> mask whereas after the granule was frozen to 4kB on machine init done.
> I guess TARGET_PAGE_MASK is always 4kB on arm64 CPUs, since it's the
> smallest supported and the guest configures its page size at runtime.
correct
> Even if QEMU's software IOMMU can deal with any page size, VFIO can't so
> passing the host page size seems more accurate than forcing a value of
> 4kB.
that's my guess too
>
>> Now this works. However the new default will prevent 4kB guest on
>> 64kB host because the granule will be set to 64kB which would be
>> larger than the guest page size. In that situation, the virtio-iommu
>> driver fails the viommu_domain_finalise() with
>> "granule 0x10000 larger than system page zie 0x1000".
> "size"
> (it could matter if someone searches for this message later)
sure I will correct it
>
>> The current limitation of global granule in the virtio-iommu
>> should be removed and turned into per domain granule. But
>> until we get this upgraded, this new default is probably
>> better because I don't think anyone is currently interested in
>> running a 4kB page size guest with virtio-iommu on a 64kB host.
>> However supporting 64kB guest on 64kB host with virtio-iommu and
>> VFIO looks a more important feature.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> So to summarize the configurations that work for hotplug (tested with QEMU
> system emulation with SMMU + QEMU VMM with virtio-iommu):
>
>  Host | Guest | virtio-net | IGB passthrough
>   4k  | 4k    | Y          | Y
>   64k | 64k   | Y          | N -> Y (fixed by this patch)
>   64k | 4k    | Y -> N     | N
>   4k  | 64k   | Y          | Y
That table is correct
>
> The change is a reasonable trade-off in my opinion. It fixes the more common
> 64k on 64k case, and for 4k on 64k, the error is now contained to the
> guest and made clear ("granule 0x10000 larger than system page size
> 0x1000") instead of crashing the VMM. A guest OS now discovers that the
> host needs DMA buffers aligned on 64k and could actually support this case
> (but Linux won't because it can't control the origin of all DMA buffers).
> Later, support for page tables will enable 4k on 64k for all devices.
>
> Tested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

Many thanks!

Eric
>
>> ---
>>  hw/virtio/virtio-iommu.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>> index 9d463efc52..b77e3644ea 100644
>> --- a/hw/virtio/virtio-iommu.c
>> +++ b/hw/virtio/virtio-iommu.c
>> @@ -1313,7 +1313,7 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
>>       * in vfio realize
>>       */
>>      s->config.bypass = s->boot_bypass;
>> -    s->config.page_size_mask = qemu_target_page_mask();
>> +    s->config.page_size_mask = qemu_real_host_page_mask();
>>      s->config.input_range.end = UINT64_MAX;
>>      s->config.domain_range.end = UINT32_MAX;
>>      s->config.probe_size = VIOMMU_PROBE_SIZE;
>> @@ -1491,13 +1491,16 @@ static int iommu_post_load(void *opaque, int version_id)
>>       * still correct.
>>       */
>>      virtio_iommu_switch_address_space_all(s);
>> +    if (version_id <= 2) {
>> +        s->config.page_size_mask = qemu_target_page_mask();
>> +    }
>>      return 0;
>>  }
>>  
>>  static const VMStateDescription vmstate_virtio_iommu_device = {
>>      .name = "virtio-iommu-device",
>>      .minimum_version_id = 2,
>> -    .version_id = 2,
>> +    .version_id = 3,
>>      .post_load = iommu_post_load,
>>      .fields = (VMStateField[]) {
>>          VMSTATE_GTREE_DIRECT_KEY_V(domains, VirtIOIOMMU, 2,
>> -- 
>> 2.27.0
>>


