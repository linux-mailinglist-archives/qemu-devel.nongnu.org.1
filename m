Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 451F7AE9766
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Jun 2025 10:02:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUhY7-0008CU-MD; Thu, 26 Jun 2025 04:01:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1uUhY5-0008Bl-9y
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 04:01:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1uUhY2-0005Sp-FD
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 04:01:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750924887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ewWo6Zakc4NuqMUKw6/WMwVuqLaBsbu3NFCk7+WCJL8=;
 b=XNMwhnLM/AO3RCJXSpMO7jKMY2r8RjrW/d0UdxLEODft0Cj7n1jytLngXnM9yxGcfjndSV
 T8qrS1+n+F7vpID8jXfizcjxvFlP6whayQ9LYS7LnXTeqP5RYNhfXTYs2FuO04TEjI+GVb
 flNqHouUJgfRBD0cY2FzECXcfK5MoHQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-dIeUqstYM322OGZuJodkDA-1; Thu, 26 Jun 2025 04:01:26 -0400
X-MC-Unique: dIeUqstYM322OGZuJodkDA-1
X-Mimecast-MFC-AGG-ID: dIeUqstYM322OGZuJodkDA_1750924885
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-452ff9e054eso2254245e9.2
 for <qemu-devel@nongnu.org>; Thu, 26 Jun 2025 01:01:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750924885; x=1751529685;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ewWo6Zakc4NuqMUKw6/WMwVuqLaBsbu3NFCk7+WCJL8=;
 b=Xo6jJhF6Jqpu4usWuOcNOPgKw62A71HcvEfSgfurXK/iPxsHzArrKspXkeOQFEBp0V
 M+tItcTsVgAzukRclPveRJUXDnNXyOWqL4AxCDof2ADW4sHm88RBm8s7g6FHPDpFBbGO
 7DNps6ggXpZhZ4tnaE1h45wHq2OU2MhDtNenqSER+6DyT/uF/ewLkFDfBDjEWs7guGnD
 JJnVS8FQx53ejz2RTQLjWnZv3PhdY11N3wxM8GlYL9OnNMujqnleRPomqXDDQmIpfYV2
 SA6Nt1fbYa+Ho3L6UhMMIxN8xz2+HHGDMZssuvu1sR7ZjoIx/VlbSm8UzbNGIQMOnCRe
 PoLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU40iJeeReDiHD9Bt7M3tWcRqDREvO4yuKE121qpv+yUlHyjzSftJqpyFMs5keSkxtBQGaWMYcFb16n@nongnu.org
X-Gm-Message-State: AOJu0Yx8WZgoU+amWvRwG0irZFqBkBDjROp/2zFBZqQ9IuEqyX47a65Q
 qzOHcbkvGShuuRMwUrRtywZeG69alKY+LLUZ5bmCawjBoFkRbAFMggaCuOxiBMJVGDu7H1NBEth
 0WvjQL8bAzoWTiuMkns0cGFCmhDRo7vypsX8xnZwqWE2GETYIZGSZ0f+w
X-Gm-Gg: ASbGncvUcVUlDXo4jgqoKm/NVlad4j61jdlStvrIQh38+hTludPQM6uhbv6sD/9Dk5F
 uteT8QTQKJdT/4qNqnVsfgArxJmvSnTUnT9Km98uPQ2/kLVmp0ffckzgPuH3BwJlV0rfJSWiAr/
 XEmBUbQHuoFzA0LkZuAMWWQAob/IJEmWfQXJMM8w39NOkgbJpe88FgCveHyIq0dce4yfroitbBz
 AyNRJo2rgKChJbOEfYjUQjh/IlvRbyfK7eAksSv0kc4uLLmxjQJ8aUnKU9Q2WCGrx+ExwxW1XNP
 ZrEpbMNHP7pOASB+SbbhZUs+LiSaKytBicP+ILzIqTJhZ0QHcbWajprb/p/x+LVM
X-Received: by 2002:a05:600c:35c9:b0:450:d00d:cc with SMTP id
 5b1f17b1804b1-453886d53d9mr27473905e9.2.1750924884503; 
 Thu, 26 Jun 2025 01:01:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsobZSvBdeLMxXpHmYRJoQzGZSgZrZgPrcNuW0wxHQbjNWDdOU7pXIfwYdoq7jr+vhn7UDwg==
X-Received: by 2002:a05:600c:35c9:b0:450:d00d:cc with SMTP id
 5b1f17b1804b1-453886d53d9mr27473105e9.2.1750924883811; 
 Thu, 26 Jun 2025 01:01:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453823b6e9esm42310265e9.28.2025.06.26.01.01.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Jun 2025 01:01:22 -0700 (PDT)
Message-ID: <8c3cce88-fab5-4bf1-bc6b-804730e9889d@redhat.com>
Date: Thu, 26 Jun 2025 10:01:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] hw/i386: Add the ramfb romfile compatatibility
Content-Language: en-US
To: Shaoqin Huang <shahuang@redhat.com>, qemu-arm@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
References: <20250617030521.2109305-1-shahuang@redhat.com>
 <20250617030521.2109305-3-shahuang@redhat.com>
 <aa4ef145-9e08-4ad9-a152-dd8fa2371436@redhat.com>
 <ba75ac62-db52-491e-8944-2bf27106d0a6@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <ba75ac62-db52-491e-8944-2bf27106d0a6@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 6/26/25 4:05 AM, Shaoqin Huang wrote:
> Hi Eric,
> 
> On 6/23/25 5:20 PM, Eric Auger wrote:
>>
>>
>> On 6/17/25 5:05 AM, Shaoqin Huang wrote:
>>> Set the "use-legacy-x86-rom" property to false by default, and only set
>>> it to true on x86 since only x86 will need it.
>> s/compatatibility/compatibility in the title
> 
> Ok. Will fix it.
> 
>>>
>>> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
>>> ---
>>>   hw/display/ramfb-standalone.c | 2 +-
>>>   hw/i386/pc_q35.c              | 3 +++
>>>   hw/vfio/pci.c                 | 2 +-
>>>   3 files changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/display/ramfb-standalone.c b/hw/display/ramfb-
>>> standalone.c
>>> index af1175bf96..ddbf42f181 100644
>>> --- a/hw/display/ramfb-standalone.c
>>> +++ b/hw/display/ramfb-standalone.c
>>> @@ -63,7 +63,7 @@ static const VMStateDescription ramfb_dev_vmstate = {
>>>     static const Property ramfb_properties[] = {
>>>       DEFINE_PROP_BOOL("x-migrate", RAMFBStandaloneState, migrate, 
>>> true),
>>> -    DEFINE_PROP_BOOL("use-legacy-x86-rom", RAMFBStandaloneState,
>>> use_legacy_x86_rom, true),
>>> +    DEFINE_PROP_BOOL("use-legacy-x86-rom", RAMFBStandaloneState,
>>> use_legacy_x86_rom, false),
>>>   };
>>>     static void ramfb_class_initfn(ObjectClass *klass, void *data)
>>> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
>>> index fd96d0345c..f6d89578d0 100644
>>> --- a/hw/i386/pc_q35.c
>>> +++ b/hw/i386/pc_q35.c
>>> @@ -45,6 +45,7 @@
>>>   #include "hw/i386/pc.h"
>>>   #include "hw/i386/amd_iommu.h"
>>>   #include "hw/i386/intel_iommu.h"
>>> +#include "hw/vfio/pci.h"
>>>   #include "hw/virtio/virtio-iommu.h"
>>>   #include "hw/display/ramfb.h"
>>>   #include "hw/ide/pci.h"
>>> @@ -67,6 +68,8 @@
>>>     static GlobalProperty pc_q35_compat_defaults[] = {
>>>       { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "39" },
>>> +    { TYPE_RAMFB_DEVICE, "use-legacy-x86-rom", "true" },
>>> +    { TYPE_VFIO_PCI, "use-legacy-x86-rom", "true" },
>> this will only keep the legacy behavior along with q35 machine type but
>> not on other machines being used for x86. what about pc-i440fx? Doesn't
>> it apply to it as well? Are there other machine types also impacted.
> 
> Ok I will also add it with pc-i440fx. I think only q35 and i440fx are
> impacted.
> 
>>
>> Also what about Daniel's comment in v3:
>> https://lore.kernel.org/all/aEak8utPPkHepVfR@redhat.com/
>> "For non-x86, historical versioned machine types will need
>> likely it set to true, in order to avoid the memory layout
>> being changed IIUC."
>>
>> Is it actually needed?
> 
> If those machine types need to set it to true. I think they can set it
> after they have this property.
nope it does not work like that. In case we really need to take care of
this, this must be handled by compats.

Thanks

Eric
> 
> Thanks,
> Shaoqin
> 
>>
>> Thanks
>>
>> Eric
>>>   };
>>>   static const size_t pc_q35_compat_defaults_len =
>>>       G_N_ELEMENTS(pc_q35_compat_defaults);
>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>> index ff0d93fae0..a529500b70 100644
>>> --- a/hw/vfio/pci.c
>>> +++ b/hw/vfio/pci.c
>>> @@ -3564,7 +3564,7 @@ static const TypeInfo vfio_pci_dev_info = {
>>>     static const Property vfio_pci_dev_nohotplug_properties[] = {
>>>       DEFINE_PROP_BOOL("ramfb", VFIOPCIDevice, enable_ramfb, false),
>>> -    DEFINE_PROP_BOOL("use-legacy-x86-rom", VFIOPCIDevice,
>>> use_legacy_x86_rom, true),
>>> +    DEFINE_PROP_BOOL("use-legacy-x86-rom", VFIOPCIDevice,
>>> use_legacy_x86_rom, false),
>>>       DEFINE_PROP_ON_OFF_AUTO("x-ramfb-migrate", VFIOPCIDevice,
>>> ramfb_migrate,
>>>                               ON_OFF_AUTO_AUTO),
>>>   };
>>
> 


