Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3087BBDBF
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 19:30:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoocw-0001JH-Hh; Fri, 06 Oct 2023 13:28:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1qoocu-0001J8-Jt
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 13:28:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1qoocs-0005RC-Jf
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 13:28:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696613313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QRyNBmp2/Mq6fOdBF1CQxY11cele04Mt8HkIVgV6ztM=;
 b=W/R4hhkYqqMiGEzmZWC8Ke2C2QllEyjxiLEF2URY4IQGkyd9/6AlJj8amZT2ksdFIqc2mH
 Qu4GbWQCL3PFaNssCqcp2cWuE3Ttw5cFH7dAMBd8+LAjlLMwVnO5s3GkSqGnhs/Ne47lDx
 qh07p1ZDmHqpW7SLXmqREVmjV7h71yg=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-Q723hMM7MICd5BMrIsyVzQ-1; Fri, 06 Oct 2023 13:28:31 -0400
X-MC-Unique: Q723hMM7MICd5BMrIsyVzQ-1
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3afb2b2005eso3729828b6e.0
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 10:28:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696613311; x=1697218111;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QRyNBmp2/Mq6fOdBF1CQxY11cele04Mt8HkIVgV6ztM=;
 b=OaKVmLIhMjRbAM9Fkt8fovIE4e5iKmI+uaGGnM/bj0TUSoNcK7IiBIXV2YmrPvF817
 zq7q28p6isZYSMlzmqpECg5lW9zh3UIHKaoy04WymwBvjqMay5n5pmOmq3L/jiCXMbRd
 AlRXHgBRaQo6OQfTH3I9p2otM76Qp6ay7ISpfCKcVxAFBc3D7fZsOOlJU6m2vJUjJdvh
 3xuLu5MgXD4EdLfJ+Xr369gtJDJoRQFBMatB0L0zbOIuus5ZxYGvEo54whvUQEU/Or4D
 V2x52ixllZ7ZCH6UXt9tqRlwo1qaRjP5px8wV96+vGfvBBt9R0ETZFNGAK6HXrje0s9M
 RRUg==
X-Gm-Message-State: AOJu0Yz3b5ikHDKItCX32aw160N4Td9Cdzoi62k5x3Jj+ftKNS13/JgG
 +MNNlPlv0sYrooavo9P5yoEEG/PvH6To9woef92JbemOy0AIJwVVAHp5OdWm2vdLowFmUAmmofh
 VhsYEO7GUJVfuY10=
X-Received: by 2002:a05:6808:20aa:b0:39c:59e2:dd79 with SMTP id
 s42-20020a05680820aa00b0039c59e2dd79mr10635578oiw.36.1696613311086; 
 Fri, 06 Oct 2023 10:28:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJ0aaP/M5eE/dDrzyAtPEYkfxo3n/9XADUGzpeeiGjQ9d7GmYlDo8KErkDul4aVm9bS5gp3A==
X-Received: by 2002:a05:6808:20aa:b0:39c:59e2:dd79 with SMTP id
 s42-20020a05680820aa00b0039c59e2dd79mr10635557oiw.36.1696613310754; 
 Fri, 06 Oct 2023 10:28:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 l17-20020ac81491000000b004181d77e08fsm1412782qtj.85.2023.10.06.10.28.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Oct 2023 10:28:29 -0700 (PDT)
Message-ID: <a0feb302-2490-8e3c-a54a-47bc8671f11e@redhat.com>
Date: Fri, 6 Oct 2023 19:28:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 00/21] vfio queue
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20231006062005.1040296-1-clg@redhat.com>
 <1e2652d6-c10b-9b65-6e2c-7903574d501a@redhat.com>
 <3ea30f06-aeea-8e66-a8ed-75a9292a415f@redhat.com>
 <1c19badf-0c65-4ee0-61a0-e653b7be89bf@redhat.com>
 <58d75d69-cfd8-903e-c0a1-f95acc64bfd0@redhat.com>
 <1d87070c-2561-c6da-1380-9e3e13bcd844@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <1d87070c-2561-c6da-1380-9e3e13bcd844@redhat.com>
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

On 10/6/23 19:08, Cédric Le Goater wrote:
> Hello Eric,
> 
> On 10/6/23 14:25, Eric Auger wrote:
>> Hi Cédric,
>>
>> On 10/6/23 13:46, Eric Auger wrote:
>>> Hi Cédric,
>>>
>>> On 10/6/23 13:42, Eric Auger wrote:
>>>> Hi Cédric,
>>>>
>>>> On 10/6/23 12:33, Cédric Le Goater wrote:
>>>>> On 10/6/23 08:19, Cédric Le Goater wrote:
>>>>>> The following changes since commit
>>>>>> 2f3913f4b2ad74baeb5a6f1d36efbd9ecdf1057d:
>>>>>>
>>>>>>     Merge tag 'for_upstream' of
>>>>>> https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging
>>>>>> (2023-10-05 09:01:01 -0400)
>>>>>>
>>>>>> are available in the Git repository at:
>>>>>>
>>>>>>     https://github.com/legoater/qemu/ tags/pull-vfio-20231006
>>>>>>
>>>>>> for you to fetch changes up to
>>>>>> 6e86aaef9ac57066aa923211a164df95b7b3cdf7:
>>>>>>
>>>>>>     vfio/common: Move legacy VFIO backend code into separate
>>>>>> container.c (2023-10-05 22:04:52 +0200)
>>>>>>
>>>>>> ----------------------------------------------------------------
>>>>>> vfio queue:
>>>>>>
>>>>>> * Fix for VFIO display when using Intel vGPUs
>>>>>> * Support for dynamic MSI-X
>>>>>> * Preliminary work for IOMMUFD support
>>>>>
>>>>> Stefan,
>>>>>
>>>>> I just did some tests on z with passthough devices (PCI and AP) and
>>>>> the series is not bisectable. QEMU crashes at patch  :
>>>>>
>>>>>    "vfio/pci: Introduce vfio_[attach/detach]_device".
>>>>>
>>>>> Also, with everything applied, the guest fails to start with :
>>>>>
>>>>>   vfio: IRQ 0 not available (number of irqs 0)
>>>>>
>>>>> So, please hold on and sorry for the noise. I will start digging
>>>>> on my side.
>>>> I just tested with the head on vfio/pci: Introduce
>>>> vfio_[attach/detach]_device, with PCIe assignment on ARM and I fail to
>>>> reproduce the crash.
>>>>
>>>> Do you try hotplug or something simpler?
>>>
>>> also works for me with hotplug/hotunplug. Please let me know if I can
>>> help.
>>
>> I think this is related to the error handling.
>>
>> if you hotplug a vfio-device and if this encounters an error,
>> vfio_realize fails and you end at the 'error' label where the name of
>> the device is freed: g_free(vbasedev->name);
>>
>> However I see that the vfio_finalize is called (Zhengzhong warned me !!)
>> calls vfio_pci_put_device
>> which calls g_free(vdev->vbasedev.name) again.
>> please try adding
>> vdev->vbasedev.name = NULL after freeing the name in vfio_realize error:
>> so see if it fixes the crash.
>>
>> Then wrt irq stuff, I would be tempted to say it sounds unrelated to the
>> iommufd prereq series but well.
>>
>> Please let me know how you want me to fix that mess, sorry.
> 
> So, the issue was a bit complex to dig because it only crashed
> with a s390 guest under libvirt. This is my all-in-one combo VM
> which has 2 PCI, 2 AP, 1 CCW passthrough devices and the issue
> is in AP I think.
> 
> vfio_ap_realize lacks :
> 
>   @@ -188,6 +188,7 @@ static void vfio_ap_realize(DeviceState
>            error_report_err(err);
>        }
>      +    return;
Hum indeed! Thanks for fixing that.
>    error:
>        error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->name);
>        g_free(vbasedev->name);
> 
> 
> No error were to return and since everything was fine, the error
> path generated a lot of mess indeed !
> 
> If you are ok with the above, I will squash the change in the
> related patch and send a v2.
Unfortunately this is not sufficient. There is another regression
(crash) on a double free of vbasedev->name as I reported before. I was
able to hit it on a failing hotplug.  How do you want me to send the
fix? I can resend the whole series of just fixes on the related patches.

Thanks

Eric> Thanks,
> 
> C.
> 
> 
> 
> 
>>
>> Eric
>>
>>
>>>
>>> Eric
>>>>
>>>> Thanks
>>>>
>>>> Eric
>>>>
>>>>
>>>>>
>>>>> Thanks,
>>>>>
>>>>> C.
>>>>>
>>>>>> ----------------------------------------------------------------
>>>>>> Alex Williamson (1):
>>>>>>         vfio/display: Fix missing update to set backing fields
>>>>>>
>>>>>> Eric Auger (7):
>>>>>>         scripts/update-linux-headers: Add iommufd.h
>>>>>>         vfio/common: Propagate KVM_SET_DEVICE_ATTR error if any
>>>>>>         vfio/common: Introduce
>>>>>> vfio_container_add|del_section_window()
>>>>>>         vfio/pci: Introduce vfio_[attach/detach]_device
>>>>>>         vfio/platform: Use vfio_[attach/detach]_device
>>>>>>         vfio/ap: Use vfio_[attach/detach]_device
>>>>>>         vfio/ccw: Use vfio_[attach/detach]_device
>>>>>>
>>>>>> Jing Liu (4):
>>>>>>         vfio/pci: detect the support of dynamic MSI-X allocation
>>>>>>         vfio/pci: enable vector on dynamic MSI-X allocation
>>>>>>         vfio/pci: use an invalid fd to enable MSI-X
>>>>>>         vfio/pci: enable MSI-X in interrupt restoring on dynamic
>>>>>> allocation
>>>>>>
>>>>>> Yi Liu (2):
>>>>>>         vfio/common: Move IOMMU agnostic helpers to a separate file
>>>>>>         vfio/common: Move legacy VFIO backend code into separate
>>>>>> container.c
>>>>>>
>>>>>> Zhenzhong Duan (7):
>>>>>>         vfio/pci: rename vfio_put_device to vfio_pci_put_device
>>>>>>         linux-headers: Add iommufd.h
>>>>>>         vfio/common: Extract out vfio_kvm_device_[add/del]_fd
>>>>>>         vfio/common: Move VFIO reset handler registration to a group
>>>>>> agnostic function
>>>>>>         vfio/common: Introduce a per container device list
>>>>>>         vfio/common: Store the parent container in VFIODevice
>>>>>>         vfio/common: Introduce a global VFIODevice list
>>>>>>
>>>>>>    hw/vfio/pci.h                   |    1 +
>>>>>>    include/hw/vfio/vfio-common.h   |   60 +-
>>>>>>    linux-headers/linux/iommufd.h   |  444 +++++++++
>>>>>>    hw/vfio/ap.c                    |   69 +-
>>>>>>    hw/vfio/ccw.c                   |  122 +--
>>>>>>    hw/vfio/common.c                | 1885
>>>>>> +++------------------------------------
>>>>>>    hw/vfio/container.c             | 1161 ++++++++++++++++++++++++
>>>>>>    hw/vfio/display.c               |    2 +
>>>>>>    hw/vfio/helpers.c               |  612 +++++++++++++
>>>>>>    hw/vfio/pci.c                   |  194 ++--
>>>>>>    hw/vfio/platform.c              |   43 +-
>>>>>>    hw/vfio/meson.build             |    2 +
>>>>>>    hw/vfio/trace-events            |    6 +-
>>>>>>    scripts/update-linux-headers.sh |    3 +-
>>>>>>    14 files changed, 2580 insertions(+), 2024 deletions(-)
>>>>>>    create mode 100644 linux-headers/linux/iommufd.h
>>>>>>    create mode 100644 hw/vfio/container.c
>>>>>>    create mode 100644 hw/vfio/helpers.c
>>>>>>
>>>>>
>>
> 


