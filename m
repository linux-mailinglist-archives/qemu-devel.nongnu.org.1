Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 680957BB77D
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 14:26:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qojtl-0004ap-NM; Fri, 06 Oct 2023 08:25:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1qojti-0004a3-5f
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 08:25:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1qojtg-0004hz-71
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 08:25:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696595135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cS9DJg/LhxJaMUIZtcRHJrRTXO2bFBoIQO33gSUAP0g=;
 b=LdMVF/xuoAb9DGSMU1dh5Z0Jd5m6s8xKAlBkVR6i0kMzfLM2basG85lXq9zDRsm6TxVhvs
 7pqwDXHW7FQtr9oEUmfLRhD/59uboJfv1nIqR8en+h85CpxjDSWs16kS8797/dtObIXqgo
 iK79Zz43v7C8ZRSPfm8BmGDfO/nw8V8=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-yAsoubl5Mv-GH05zLBsTUA-1; Fri, 06 Oct 2023 08:25:34 -0400
X-MC-Unique: yAsoubl5Mv-GH05zLBsTUA-1
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-d852a6749baso2576647276.0
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 05:25:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696595133; x=1697199933;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cS9DJg/LhxJaMUIZtcRHJrRTXO2bFBoIQO33gSUAP0g=;
 b=FeF5tG0q7QMq8Fv4nnVaZPdh269yHt/YyDUzOQT6xXPHxl/atzLApq4s9YMd+G8uo6
 Yog54mLe95bC6K6NdFLjBAYfMF77UBlcPtXRXh+ERw2Ip+Vr6wRKrvBP4zvrKN5swFr9
 n2+Quam32hJ5A1/kA7wrMmhZbXTtFeLv2F9gQoU3O9m4czbuKQXuaQalRB8fnWyLdZzC
 b8YragY+vsXJa0FWO6R+5CTVo7baHg3RkZW6nDDVZlZH+MoiU0+FK96ZKgA/+tNHfwe5
 Wj4T7iR872BUi3ONlUifLAgX0MsnV1awAQOxXBnPOX+Mn2rXUElpeHPT4iqnnhDRX2lj
 u+vg==
X-Gm-Message-State: AOJu0Yyir+iBsYDMxYws1FvS/zZItO4ZQ4zWLU8DM/LsllE6IiF4mO7u
 mCzA7q5eIIeI/BThKa3jIOf7DCtnuqD/NCq54RA+u2QSN43/jYxMSVlyv1csQ8o4jClAott7leM
 yOECYJDXnQ2j6mpI=
X-Received: by 2002:a5b:408:0:b0:d81:8c74:8f88 with SMTP id
 m8-20020a5b0408000000b00d818c748f88mr7466652ybp.25.1696595133617; 
 Fri, 06 Oct 2023 05:25:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaiGxI66WAE2aB/Qom6y180OBs4g37N5ZqvU3zYOmpSpBr7jTziyxZ1Slj+ipy7CpPguxFGA==
X-Received: by 2002:a5b:408:0:b0:d81:8c74:8f88 with SMTP id
 m8-20020a5b0408000000b00d818c748f88mr7466645ybp.25.1696595133298; 
 Fri, 06 Oct 2023 05:25:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 y14-20020a0cf14e000000b0065af71585b5sm1334567qvl.58.2023.10.06.05.25.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Oct 2023 05:25:32 -0700 (PDT)
Message-ID: <58d75d69-cfd8-903e-c0a1-f95acc64bfd0@redhat.com>
Date: Fri, 6 Oct 2023 14:25:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 00/21] vfio queue
Content-Language: en-US
From: Eric Auger <eauger@redhat.com>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20231006062005.1040296-1-clg@redhat.com>
 <1e2652d6-c10b-9b65-6e2c-7903574d501a@redhat.com>
 <3ea30f06-aeea-8e66-a8ed-75a9292a415f@redhat.com>
 <1c19badf-0c65-4ee0-61a0-e653b7be89bf@redhat.com>
In-Reply-To: <1c19badf-0c65-4ee0-61a0-e653b7be89bf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.797, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Hi Cédric,

On 10/6/23 13:46, Eric Auger wrote:
> Hi Cédric,
> 
> On 10/6/23 13:42, Eric Auger wrote:
>> Hi Cédric,
>>
>> On 10/6/23 12:33, Cédric Le Goater wrote:
>>> On 10/6/23 08:19, Cédric Le Goater wrote:
>>>> The following changes since commit
>>>> 2f3913f4b2ad74baeb5a6f1d36efbd9ecdf1057d:
>>>>
>>>>    Merge tag 'for_upstream' of
>>>> https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging
>>>> (2023-10-05 09:01:01 -0400)
>>>>
>>>> are available in the Git repository at:
>>>>
>>>>    https://github.com/legoater/qemu/ tags/pull-vfio-20231006
>>>>
>>>> for you to fetch changes up to 6e86aaef9ac57066aa923211a164df95b7b3cdf7:
>>>>
>>>>    vfio/common: Move legacy VFIO backend code into separate
>>>> container.c (2023-10-05 22:04:52 +0200)
>>>>
>>>> ----------------------------------------------------------------
>>>> vfio queue:
>>>>
>>>> * Fix for VFIO display when using Intel vGPUs
>>>> * Support for dynamic MSI-X
>>>> * Preliminary work for IOMMUFD support
>>>
>>> Stefan,
>>>
>>> I just did some tests on z with passthough devices (PCI and AP) and
>>> the series is not bisectable. QEMU crashes at patch  :
>>>
>>>   "vfio/pci: Introduce vfio_[attach/detach]_device".
>>>
>>> Also, with everything applied, the guest fails to start with :
>>>
>>>  vfio: IRQ 0 not available (number of irqs 0)
>>>
>>> So, please hold on and sorry for the noise. I will start digging
>>> on my side.
>> I just tested with the head on vfio/pci: Introduce
>> vfio_[attach/detach]_device, with PCIe assignment on ARM and I fail to
>> reproduce the crash.
>>
>> Do you try hotplug or something simpler?
> 
> also works for me with hotplug/hotunplug. Please let me know if I can help.

I think this is related to the error handling.

if you hotplug a vfio-device and if this encounters an error,
vfio_realize fails and you end at the 'error' label where the name of
the device is freed: g_free(vbasedev->name);

However I see that the vfio_finalize is called (Zhengzhong warned me !!)
calls vfio_pci_put_device
which calls g_free(vdev->vbasedev.name) again.
please try adding
vdev->vbasedev.name = NULL after freeing the name in vfio_realize error:
so see if it fixes the crash.

Then wrt irq stuff, I would be tempted to say it sounds unrelated to the
iommufd prereq series but well.

Please let me know how you want me to fix that mess, sorry.

Eric


> 
> Eric
>>
>> Thanks
>>
>> Eric
>>
>>
>>>
>>> Thanks,
>>>
>>> C.
>>>
>>>> ----------------------------------------------------------------
>>>> Alex Williamson (1):
>>>>        vfio/display: Fix missing update to set backing fields
>>>>
>>>> Eric Auger (7):
>>>>        scripts/update-linux-headers: Add iommufd.h
>>>>        vfio/common: Propagate KVM_SET_DEVICE_ATTR error if any
>>>>        vfio/common: Introduce vfio_container_add|del_section_window()
>>>>        vfio/pci: Introduce vfio_[attach/detach]_device
>>>>        vfio/platform: Use vfio_[attach/detach]_device
>>>>        vfio/ap: Use vfio_[attach/detach]_device
>>>>        vfio/ccw: Use vfio_[attach/detach]_device
>>>>
>>>> Jing Liu (4):
>>>>        vfio/pci: detect the support of dynamic MSI-X allocation
>>>>        vfio/pci: enable vector on dynamic MSI-X allocation
>>>>        vfio/pci: use an invalid fd to enable MSI-X
>>>>        vfio/pci: enable MSI-X in interrupt restoring on dynamic
>>>> allocation
>>>>
>>>> Yi Liu (2):
>>>>        vfio/common: Move IOMMU agnostic helpers to a separate file
>>>>        vfio/common: Move legacy VFIO backend code into separate
>>>> container.c
>>>>
>>>> Zhenzhong Duan (7):
>>>>        vfio/pci: rename vfio_put_device to vfio_pci_put_device
>>>>        linux-headers: Add iommufd.h
>>>>        vfio/common: Extract out vfio_kvm_device_[add/del]_fd
>>>>        vfio/common: Move VFIO reset handler registration to a group
>>>> agnostic function
>>>>        vfio/common: Introduce a per container device list
>>>>        vfio/common: Store the parent container in VFIODevice
>>>>        vfio/common: Introduce a global VFIODevice list
>>>>
>>>>   hw/vfio/pci.h                   |    1 +
>>>>   include/hw/vfio/vfio-common.h   |   60 +-
>>>>   linux-headers/linux/iommufd.h   |  444 +++++++++
>>>>   hw/vfio/ap.c                    |   69 +-
>>>>   hw/vfio/ccw.c                   |  122 +--
>>>>   hw/vfio/common.c                | 1885
>>>> +++------------------------------------
>>>>   hw/vfio/container.c             | 1161 ++++++++++++++++++++++++
>>>>   hw/vfio/display.c               |    2 +
>>>>   hw/vfio/helpers.c               |  612 +++++++++++++
>>>>   hw/vfio/pci.c                   |  194 ++--
>>>>   hw/vfio/platform.c              |   43 +-
>>>>   hw/vfio/meson.build             |    2 +
>>>>   hw/vfio/trace-events            |    6 +-
>>>>   scripts/update-linux-headers.sh |    3 +-
>>>>   14 files changed, 2580 insertions(+), 2024 deletions(-)
>>>>   create mode 100644 linux-headers/linux/iommufd.h
>>>>   create mode 100644 hw/vfio/container.c
>>>>   create mode 100644 hw/vfio/helpers.c
>>>>
>>>


