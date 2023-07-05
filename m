Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE67D7487C9
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 17:21:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH4JJ-0001G3-4K; Wed, 05 Jul 2023 11:20:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qH4JE-0001FP-2q
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 11:20:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qH4JC-0003JE-GO
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 11:20:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688570438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oBNSaLhQg85jlxzbzhWUGTYtwdAbT+hJb3e6ecC5E5E=;
 b=Pf7bsyVjkj9KlyD/I/8bz964BhNTjbB+hZeVpwyq0V6MeZXXfJzsPFlqgtFGA5rb+Jci7o
 INZmw+oRtjzBFx3RAyUlneFfYqWke9z0gJNTnASdWzd54SjY/fCsmmcDbP5PKiKPvFt6F9
 14ITgp2cQLV0jxK0CVIk/j46YKfI7bg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-Nc0khW8RPTSP5PlIHhF_5g-1; Wed, 05 Jul 2023 11:20:36 -0400
X-MC-Unique: Nc0khW8RPTSP5PlIHhF_5g-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-635f38834acso72801556d6.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 08:20:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688570436; x=1691162436;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oBNSaLhQg85jlxzbzhWUGTYtwdAbT+hJb3e6ecC5E5E=;
 b=jSI/wKEMVbHmqOJbXUCA7jJCOmeBrnzZAQkGYnODTqF3otweBpVxwIekCCDjcdf9pv
 cEzx4S9ty/PCzaKpcQiihwewGFOcmck4BXsgTPRWqh/7URXQBQybL1mvM9U7rW9Epf6r
 749B0c6r3K+4zWtxopy+uXIHvSz9pDSrL9vzpNHf4coXGVj9Pz3CdvObV3KPEDU4wbhH
 VtIrESCSg+yf6/Nw/9nBMhvcaFsFz23eEMTWFlz7XBTfDBG78YQPjC/8bWjkNAb9OYb8
 owYpwer2E286s6B42gKnJwXe8Eb+zWNvFdMwspfVmXjtW0sFWoeUx467ksEz4JTqhb3n
 coPA==
X-Gm-Message-State: ABy/qLZ9hod+dVm3XoLWqpTPpaDvf2npXN7ADba2kBvjfP4Hptv4DpHl
 VuhbfU6tEaePCOiMKdGORltfU3br9njGYwFdOrbIlujJQooUdFMw2UW7F9e8L1YVaH7A86Hs2sG
 nXbDQ9iMTxgIqOkg=
X-Received: by 2002:a05:6214:5009:b0:62d:ef41:b847 with SMTP id
 jo9-20020a056214500900b0062def41b847mr22716286qvb.14.1688570436147; 
 Wed, 05 Jul 2023 08:20:36 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEeCKSGKP1EeN02klmI9cvML4HxZehnCeeM98z9E6q6i7NeGeITEowd0sYEHgE1Rd30agQkSQ==
X-Received: by 2002:a05:6214:5009:b0:62d:ef41:b847 with SMTP id
 jo9-20020a056214500900b0062def41b847mr22716266qvb.14.1688570435899; 
 Wed, 05 Jul 2023 08:20:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 y11-20020ad457cb000000b00631eb444e6esm13651106qvx.51.2023.07.05.08.20.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 08:20:35 -0700 (PDT)
Message-ID: <581addef-5b33-639a-cc4f-404d5c70a1cf@redhat.com>
Date: Wed, 5 Jul 2023 17:20:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] kconfig: Add PCIe devices to s390x machines
Content-Language: en-US
To: Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20230704120137.2604646-1-clg@redhat.com>
 <6fb9e146-7ace-0db6-305b-f6fc135878c1@linaro.org>
 <149fdc25-f88d-67f5-f409-8ea2299e41ef@redhat.com>
 <bf100be6-2b22-f45d-3479-f8ce50cfdf76@linaro.org>
 <497815d2-27ce-fa08-c835-f2245f79bacb@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <497815d2-27ce-fa08-c835-f2245f79bacb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 7/5/23 16:54, Matthew Rosato wrote:
> On 7/4/23 9:33 AM, Philippe Mathieu-Daudé wrote:
>> On 4/7/23 14:32, Cédric Le Goater wrote:
>>> On 7/4/23 14:09, Philippe Mathieu-Daudé wrote:
>>>> On 4/7/23 14:01, Cédric Le Goater wrote:
>>>>> It is useful to extend the number of available PCI devices to KVM guests
>>>>> for passthrough scenarios and also to expose these models to a different
>>>>> (big endian) architecture. Include models for Intel Ethernet adapters
>>>>> and one USB controller, which all support MSI-X. Devices only supporting
>>>>> INTx won't work on s390x.
>>>>>
>>>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>>>> ---
>>>>>
>>>>>    Tested under KVM as a machine device, under KVM nested as a passthrough
>>>>>    device
>>>>>
>>>>>    hw/s390x/Kconfig | 4 ++++
>>>>>    1 file changed, 4 insertions(+)
>>>>>
>>>>> diff --git a/hw/s390x/Kconfig b/hw/s390x/Kconfig
>>>>> index 5e7d8a2bae8b..7a82c58cdf6e 100644
>>>>> --- a/hw/s390x/Kconfig
>>>>> +++ b/hw/s390x/Kconfig
>>>>> @@ -10,3 +10,7 @@ config S390_CCW_VIRTIO
>>>>>        select SCLPCONSOLE
>>>>>        select VIRTIO_CCW
>>>>>        select MSI_NONBROKEN
>>>>> +    imply PCI_EXPRESS
>>>>
>>>> No, PCIe is a bus, which is implemented in s390-pci-bus.c;
>>>> S390_CCW_VIRTIO exposes this bus, so we Kconfig SELECT it.
>>>>
>>>>> +    imply E1000E_PCI_EXPRESS
>>>>> +    imply IGB_PCI_EXPRESS
>>>>> +    imply USB_XHCI_PCI
>>>>
>>>> These are devices you can plug on a PCIe bus, so Kconfig
>>>> IMPLY is correct.
>>>
>>> If I understand correctly, this should be ?
>>>
>>> @@ -5,8 +5,11 @@ config S390_CCW_VIRTIO
>>>        imply VFIO_AP
>>>        imply VFIO_CCW
>>>        imply WDT_DIAG288
>>> -    select PCI
>>> +    select PCI_EXPRESS
>>>        select S390_FLIC
>>>        select SCLPCONSOLE
>>>        select VIRTIO_CCW
>>>        select MSI_NONBROKEN
>>> +    imply E1000E_PCI_EXPRESS
>>> +    imply IGB_PCI_EXPRESS
>>> +    imply USB_XHCI_PCI
>>
>> This is how I'd write this patch. Note I have zero knowledge of zPCI.
>>
> 
> Indeed, our s390x PCI emulation is lacking in some places (e.g. missing legacy interrupts as Thomas indicated in a prior thread) so we want to be selective about what we enable.
> 
> I have no strong objection to adding them as long as you've tested them.
> 
> Based on the above comments, will there be a v3?  I don't have the imply'd devices readily available for test but I did do some passthrough and virtio sanity-testing with s390x hardware to make sure this changes doesn't regress anything there.  I used the diff just above (select PCI_EXPRESS + imply*3)

Good. The VM I use for tests has the following PCI devices :

  0001:00:00.0 Ethernet controller: Mellanox Technologies MT27710 Family [ConnectX-4 Lx Virtual Function]
  0002:00:00.0 Non-VGA unclassified device: IBM Internal Shared Memory (ISM) virtual PCI device
  0003:00:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Connection
  0004:00:00.0 Ethernet controller: Intel Corporation 82576 Gigabit Network Connection (rev 01)

The first two devices are passthrough devices from the LPAR. Then in the nested,
I simply pass one of the last two devices, emulated in QEMU. Both kernels have
the Intel net drivers to check connectivity with the LPAR. These are not shipped
by default.

Sending a v3.

Thanks,

C.





