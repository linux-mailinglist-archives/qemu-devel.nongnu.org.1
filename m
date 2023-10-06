Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4D17BB6E5
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:47:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qojIJ-0007Uc-5R; Fri, 06 Oct 2023 07:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1qojI6-0007Nr-9N
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:46:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1qojI4-0003AN-6Y
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:46:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696592802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=haD7kVhvxpsj6KzlDfPrKGgFPm37d+atrAchNxvx5fY=;
 b=UekFOPIyuYT6kOSjvI7GIdLSsiFBefftDkJJKBpSy30aBHoSKuXE6n0RWDWYooJiaYhjUL
 XYohuF3nmo3snCpWjd4Jmq3voDLekwF9gCLvmH0o+a+PCZbpuzMzTcIWDLzYhUoJwA/bL3
 gdA/XrgpCHJK4XSAgPKJKfrNW3eG/is=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-XgJoNHPrPVCYBqqnwjObLg-1; Fri, 06 Oct 2023 07:46:41 -0400
X-MC-Unique: XgJoNHPrPVCYBqqnwjObLg-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-418198baf49so19962291cf.1
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 04:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696592801; x=1697197601;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=haD7kVhvxpsj6KzlDfPrKGgFPm37d+atrAchNxvx5fY=;
 b=jZW793AXU2GSHJayGpyFDyB01B0Ks00RL5nSDOAExWdfKXki4oXZs+ZjvcgTefMPJo
 V0RhdCVPhMshWGAf4bDNdTcGbshYlOarVNRW5RPS9KPky4nNMLGtnriLJxCbesMKi3Xh
 9qUPB4hC62StVOTOMcSvjkfIpzZDjXZKia5rtLTZqjKgRRa9pMvMr4lYctPr/T/rxmsh
 KymW8F/m6ynPMMSS0fHHJOBKGGPRdciwVHMvGZ6b1++mIzzbfvzyVXsa39vul3T7M/tY
 bh1lmIpDLoHHmjguJlrlnH49UeCQ5FX0RnH/4jig3vQ0l4QT0lE7B7KfaET/yd56wsSP
 AzIQ==
X-Gm-Message-State: AOJu0Yw9i13YsmyXWjvcfuGPzvHpYV31tIC303duRFz22HNt5L4yNqBR
 oa8PzOyk3EQfnkjZ4UKk8uoQlkg5zwnvW02UbhWn7wNhh0B4gMQs3cbPEu8d83wuYEXdvbJTB/Z
 iKHw002LWPtuPVg4=
X-Received: by 2002:a05:622a:2c1:b0:410:a9dd:bd07 with SMTP id
 a1-20020a05622a02c100b00410a9ddbd07mr8046149qtx.10.1696592800740; 
 Fri, 06 Oct 2023 04:46:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0mH2Ww8T6GwOonLhOMh0GdFIbuqB3f9HPwtoWF8NNFSMzzoyafHkRsSnN9ysPMCbSVAmmdA==
X-Received: by 2002:a05:622a:2c1:b0:410:a9dd:bd07 with SMTP id
 a1-20020a05622a02c100b00410a9ddbd07mr8046129qtx.10.1696592800346; 
 Fri, 06 Oct 2023 04:46:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 g8-20020ac81248000000b00417fa7d33dbsm1201946qtj.93.2023.10.06.04.46.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Oct 2023 04:46:39 -0700 (PDT)
Message-ID: <1c19badf-0c65-4ee0-61a0-e653b7be89bf@redhat.com>
Date: Fri, 6 Oct 2023 13:46:36 +0200
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
In-Reply-To: <3ea30f06-aeea-8e66-a8ed-75a9292a415f@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.797, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 10/6/23 13:42, Eric Auger wrote:
> Hi Cédric,
> 
> On 10/6/23 12:33, Cédric Le Goater wrote:
>> On 10/6/23 08:19, Cédric Le Goater wrote:
>>> The following changes since commit
>>> 2f3913f4b2ad74baeb5a6f1d36efbd9ecdf1057d:
>>>
>>>    Merge tag 'for_upstream' of
>>> https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging
>>> (2023-10-05 09:01:01 -0400)
>>>
>>> are available in the Git repository at:
>>>
>>>    https://github.com/legoater/qemu/ tags/pull-vfio-20231006
>>>
>>> for you to fetch changes up to 6e86aaef9ac57066aa923211a164df95b7b3cdf7:
>>>
>>>    vfio/common: Move legacy VFIO backend code into separate
>>> container.c (2023-10-05 22:04:52 +0200)
>>>
>>> ----------------------------------------------------------------
>>> vfio queue:
>>>
>>> * Fix for VFIO display when using Intel vGPUs
>>> * Support for dynamic MSI-X
>>> * Preliminary work for IOMMUFD support
>>
>> Stefan,
>>
>> I just did some tests on z with passthough devices (PCI and AP) and
>> the series is not bisectable. QEMU crashes at patch  :
>>
>>   "vfio/pci: Introduce vfio_[attach/detach]_device".
>>
>> Also, with everything applied, the guest fails to start with :
>>
>>  vfio: IRQ 0 not available (number of irqs 0)
>>
>> So, please hold on and sorry for the noise. I will start digging
>> on my side.
> I just tested with the head on vfio/pci: Introduce
> vfio_[attach/detach]_device, with PCIe assignment on ARM and I fail to
> reproduce the crash.
> 
> Do you try hotplug or something simpler?

also works for me with hotplug/hotunplug. Please let me know if I can help.

Eric
> 
> Thanks
> 
> Eric
> 
> 
>>
>> Thanks,
>>
>> C.
>>
>>> ----------------------------------------------------------------
>>> Alex Williamson (1):
>>>        vfio/display: Fix missing update to set backing fields
>>>
>>> Eric Auger (7):
>>>        scripts/update-linux-headers: Add iommufd.h
>>>        vfio/common: Propagate KVM_SET_DEVICE_ATTR error if any
>>>        vfio/common: Introduce vfio_container_add|del_section_window()
>>>        vfio/pci: Introduce vfio_[attach/detach]_device
>>>        vfio/platform: Use vfio_[attach/detach]_device
>>>        vfio/ap: Use vfio_[attach/detach]_device
>>>        vfio/ccw: Use vfio_[attach/detach]_device
>>>
>>> Jing Liu (4):
>>>        vfio/pci: detect the support of dynamic MSI-X allocation
>>>        vfio/pci: enable vector on dynamic MSI-X allocation
>>>        vfio/pci: use an invalid fd to enable MSI-X
>>>        vfio/pci: enable MSI-X in interrupt restoring on dynamic
>>> allocation
>>>
>>> Yi Liu (2):
>>>        vfio/common: Move IOMMU agnostic helpers to a separate file
>>>        vfio/common: Move legacy VFIO backend code into separate
>>> container.c
>>>
>>> Zhenzhong Duan (7):
>>>        vfio/pci: rename vfio_put_device to vfio_pci_put_device
>>>        linux-headers: Add iommufd.h
>>>        vfio/common: Extract out vfio_kvm_device_[add/del]_fd
>>>        vfio/common: Move VFIO reset handler registration to a group
>>> agnostic function
>>>        vfio/common: Introduce a per container device list
>>>        vfio/common: Store the parent container in VFIODevice
>>>        vfio/common: Introduce a global VFIODevice list
>>>
>>>   hw/vfio/pci.h                   |    1 +
>>>   include/hw/vfio/vfio-common.h   |   60 +-
>>>   linux-headers/linux/iommufd.h   |  444 +++++++++
>>>   hw/vfio/ap.c                    |   69 +-
>>>   hw/vfio/ccw.c                   |  122 +--
>>>   hw/vfio/common.c                | 1885
>>> +++------------------------------------
>>>   hw/vfio/container.c             | 1161 ++++++++++++++++++++++++
>>>   hw/vfio/display.c               |    2 +
>>>   hw/vfio/helpers.c               |  612 +++++++++++++
>>>   hw/vfio/pci.c                   |  194 ++--
>>>   hw/vfio/platform.c              |   43 +-
>>>   hw/vfio/meson.build             |    2 +
>>>   hw/vfio/trace-events            |    6 +-
>>>   scripts/update-linux-headers.sh |    3 +-
>>>   14 files changed, 2580 insertions(+), 2024 deletions(-)
>>>   create mode 100644 linux-headers/linux/iommufd.h
>>>   create mode 100644 hw/vfio/container.c
>>>   create mode 100644 hw/vfio/helpers.c
>>>
>>


