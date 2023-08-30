Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9117878D2FB
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 07:30:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbDkx-00027V-ND; Wed, 30 Aug 2023 01:28:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yui.washidu@gmail.com>)
 id 1qbDkt-00027N-2I
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 01:28:39 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yui.washidu@gmail.com>)
 id 1qbDkq-0001uU-Gb
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 01:28:38 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-68a410316a2so3797305b3a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 22:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693373313; x=1693978113; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h2IN7SMq8Jl60AsRwP/f8hzhNBr0P7FbWYXO4LKoysw=;
 b=GCjW7/1/o3dwkBHGqTc1256N7qKQTFJftrJlG9rzfpOJR8rLv4qY4gX6V18bTI+ZzS
 iSVCLA8sTzV+210rcdFkdqOio3lHwm2VksJd6VfdlZFfw8svuldrn86PHQ20iogB88nl
 j0RImzt+96M8iYmUlYo5BssxdiifbUVGlcHwc9eKeZ/nCSFplW6ts5P7qSd34/p+fDds
 dhsALHUlip4wET2DcDL8t/X/tirM7nTaVzW4a7LIv2hLtcGO5DhaVMn/pNdT+EnpwqUh
 WA4vd1WcjpAxMWCWQfyCQ2IaoVF6U9oolbKikc0/bnc+9sccvOOSMQUT3+nvesV1eYL/
 gO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693373313; x=1693978113;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h2IN7SMq8Jl60AsRwP/f8hzhNBr0P7FbWYXO4LKoysw=;
 b=OySNSv3BrVM/b7e8ftPeq5lOQtaglOQzYII3wVnvhY9mdUuRI8hIhWryiyC5Ok/o7p
 4GtGs9cjaWnYYluxiYxrusVJoZkZ0LYVRAP1zpw+eRIwv0Ll/0h/1dAypYexCMu/+3Re
 BMt4ZKfh713EW4+U87LFEwHWaB48mBeHE0oH6DA48ZozSETyMlaeSuFydMua/uVwgymX
 pkiRhsChvUQlk222uObJo6iYG8EGFZHSnXiaFS/2dXRFgOyHWJ0vEjKgW0eph8nYzCrk
 7XnLEDuTFcE5sJWM9A3PWj8obHM+A/gx+XWfuvkBipM8BgpIwvYD3tHMFamjb6eWNiiu
 8xSQ==
X-Gm-Message-State: AOJu0Yyu4gO/Rt7g3NYVhekiyNA99AivtpfUN3GzBORANjOVfWTXUcSG
 t5vUdruv6/XcQPevLPZc97Y=
X-Google-Smtp-Source: AGHT+IHVOusAlg9cQ5GR4pUr0V65kg/SW9mx9LzhAUO4zGxz9Dr6pL6tJ6g4z8XfTOl0hM8j+kDm0A==
X-Received: by 2002:a05:6a20:6a04:b0:137:2f8c:fab0 with SMTP id
 p4-20020a056a206a0400b001372f8cfab0mr1446435pzk.49.1693373313118; 
 Tue, 29 Aug 2023 22:28:33 -0700 (PDT)
Received: from ?IPV6:2001:268:c201:6f40:c9bd:2164:bebe:28ad?
 ([2001:268:c201:6f40:c9bd:2164:bebe:28ad])
 by smtp.gmail.com with ESMTPSA id
 m3-20020a1709026bc300b001befac3b3cbsm10259452plt.290.2023.08.29.22.28.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 22:28:32 -0700 (PDT)
Message-ID: <e16a6dc9-fa72-4ff6-9dd4-fbd6e36eec82@gmail.com>
Date: Wed, 30 Aug 2023 14:28:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/1] virtio-net: add support for SR-IOV emulation
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, akihiko.odaki@daynix.com,
 yvugenfi@redhat.com, ybendito@redhat.com, mapfelba@redhat.com,
 marcel@redhat.com, ghammer@redhat.com, mdean@redhat.com
References: <1689731808-3009-1-git-send-email-yui.washidu@gmail.com>
 <CACGkMEv9yVCherC89W5ihyP-iZZHDhn1xZy-8aOd4ZSs+1Dk_Q@mail.gmail.com>
 <ef14eb09-e739-3a3a-ebda-13b385a85d8e@gmail.com>
 <CACGkMEtUUq6988VJoZuPhfdODMeyMsZUkm4Pq6u4NYzEZo3zeQ@mail.gmail.com>
From: Yui Washizu <yui.washidu@gmail.com>
In-Reply-To: <CACGkMEtUUq6988VJoZuPhfdODMeyMsZUkm4Pq6u4NYzEZo3zeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=yui.washidu@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


On 2023/07/24 15:58, Jason Wang wrote:
> On Mon, Jul 24, 2023 at 10:32 AM Yui Washizu <yui.washidu@gmail.com> wrote:
>>
>> On 2023/07/20 11:20, Jason Wang wrote:
>>> On Wed, Jul 19, 2023 at 9:59 AM Yui Washizu <yui.washidu@gmail.com> wrote:
>>>> This patch series is the first step towards enabling
>>>> hardware offloading of the L2 packet switching feature on virtio-net device to host machine.
>>>> We are considering that this hardware offloading enables
>>>> the use of high-performance networks in virtual infrastructures,
>>>> such as container infrastructures on VMs.
>>>>
>>>> To enable L2 packet switching by SR-IOV VFs, we are considering the following:
>>>> - making the guest recognize virtio-net devices as SR-IOV PF devices
>>>>     (archived with this patch series)
>>>> - allowing virtio-net devices to connect SR-IOV VFs to the backend networks,
>>>>     leaving the L2 packet switching feature to the management layer like libvirt
>>> Could you please show the qemu command line you want to propose here?
>>
>> I am considering how to specify the properties of VFs to connect SR-IOV
>> VFs to the backend networks.
>>
>>
>> For example:
>>
>>
>> qemu-system-x86_64 -device
>> pcie-root-port,port=8,chassis=8,id=pci.8,bus=pcie.0,multifunction=on
>>                      -netdev tap,id=hostnet0,vhost=on
>>                      -netdev tap,id=vfnet1,vhost=on # backend network for
>> SR-IOV VF 1
>>                      -netdev tap,id=vfnet2,vhost=on # backend network for
>> SR-IOV VF 2
>>                      -device
>> virtio-net-pci,netdev=hostnet0,sriov_max_vfs=2,sriov_netdev=vfnet1:vfnet2,...
>>
>>
>> In this example, we can specify multiple backend networks to the VFs
>> by adding "sriov_netdev" and separating them with ":".
> This seems what is in my mind as well, more below
>
>> Additionally, when passing properties like "rx_queue_size" to VFs, we
>> can utilize new properties,
>> such as "sriov_rx_queue_size_per_vfs," to ensure that the same value is
>> passed to all VFs.
> Or we can introduce new device like:
>
> -netdev tap,id=hn0 \
> -device virtio-net-pci,netdev=hn0,id=vnet_pf \
> -netdev tap,netdev=hn1 \
> -device virtio-net-pci-vf,netdev=hn1,id=vf0,pf=vnet_pf,rx_queue_size=XYZ ... \
>
> This allows us to reuse the codes for configuring vf parameters. But
> note that rx_queue_size doesn't make too much sense to vhost-vDPA, as
> qemu can perform nothing more than a simple sanity test.
>
> Thanks


Thanks for proposing this new way.

I have considered how to implement this.


As virtio-net-pci-vf device should show up

on the guest only when the guest OS creates a VF,

the guest must not be able to see the VF device on PCI bus when qemu starts.

However, it's hard to realize this without overcomplicating

relevant code due to current qemu implementation.

It's because qdev_device_add_from_qdict,

a function which is called when devices are specified

with "-device" option of qemu startup command,

always create devices by qdev_new and qdev_realize.

It might be possible that we fix it

so that qdev_new/qdev_realize aren't triggered for virtio-net-pci-vf 
devices,

but It seems that we need to special case the device in very generic code

like qdev_device_add_from_qdict(), qdev_device_add(),

device_init_func() or their caller function.


Given my current ideas,

it seems like this PATCH could become complex.

Woule you have any suggestions

for achieving this in more simple way possible ?



>> I'm still considering about how to specify it, so please give me any
>> comments if you have any.
>>
>>
>>>>     - This makes hardware offloading of L2 packet switching possible.
>>>>       For example, when using vDPA devices, it allows the guest
>>>>       to utilize SR-IOV NIC embedded switch of hosts.
>>> This would be interesting.
>>>
>>> Thanks
>>>
>>>> This patch series aims to enable SR-IOV emulation on virtio-net devices.
>>>> With this series, the guest can identify the virtio-net device as an SR-IOV PF device.
>>>> The newly added property 'sriov_max_vfs' allows us to enable the SR-IOV feature
>>>> on the virtio-net device.
>>>> Currently, we are unable to specify the properties of a VF created from the guest.
>>>> The properties are set to their default values.
>>>> In the future, we plan to allow users to set the properties.
>>>>
>>>> qemu-system-x86_64 --device virtio-net,sriov_max_vfs=<num>
>>>> # when 'sriov_max_vfs' is present, the SR-IOV feature will be automatically enabled
>>>> # <num> means the max number of VF on guest
>>>>
>>>> Example commands to create VFs in virtio-net device from the guest:
>>>>
>>>> guest% readlink -f /sys/class/net/eth1/device
>>>>    /sys/devices/pci0000:00/0000:00:02.0/0000:01:00.0/virtio1
>>>> guest% echo "2" > /sys/devices/pci0000:00/0000:00:02.0/0000:01:00.0/sriov_numvfs
>>>> guest% ip link show
>>>>    eth0: ....
>>>>    eth1: ....
>>>>    eth2: .... #virtual VF created
>>>>    eth3: .... #virtual VF created
>>>>
>>>> Please note that communication between VF and PF/VF is not possible by this patch series itself.
>>>>
>>>> Yui Washizu (1):
>>>>     virtio-pci: add SR-IOV capability
>>>>
>>>>    hw/pci/msix.c                  |  8 +++--
>>>>    hw/pci/pci.c                   |  4 +++
>>>>    hw/virtio/virtio-pci.c         | 62 ++++++++++++++++++++++++++++++----
>>>>    include/hw/virtio/virtio-pci.h |  1 +
>>>>    4 files changed, 66 insertions(+), 9 deletions(-)
>>>>
>>>> --
>>>> 2.39.3
>>>>

