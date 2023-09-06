Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C857934C2
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 07:11:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdkoi-0006ef-GV; Wed, 06 Sep 2023 01:11:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yui.washidu@gmail.com>)
 id 1qdkog-0006eX-Ij
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 01:11:02 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yui.washidu@gmail.com>)
 id 1qdkod-0001j9-A8
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 01:11:01 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-26d1e5f2c35so2300335a91.2
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 22:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693977056; x=1694581856; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+BMPnUg5qvjg/f97r4/a7aJVne6KIKStu+5piLk/UFE=;
 b=fcN5Tobem/xsTeBjMd4jR4uquQSrgP+lNvZvmD3/Z7ap4+LSl8uehokq8xElqKGLIz
 ZZ36OP+mDdZdmvHIa6MstRezR2AqM7Yo9lRBO9osy+cy0Vak7O0tKagYjWcWC0BzkjZg
 Lfdye9iTgp7FB6Es+JqK0Ft6Baub3c9T/dUc9NIBwzYCsKhhSzqcnUIwbPczc//hYC9d
 6sQSfVIb7wTmrXD7jrogOJGOr1hRAEzidQBZ43B6yP51Fsdfwy9D+JKTP6V/4+FF5FeC
 7LkMof0GG3cFS7zR0KtzVRqgMqmMFaHTYy31uxePYeyS8sHtzTKRgV2wzhW/XiggBVDU
 0BHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693977056; x=1694581856;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+BMPnUg5qvjg/f97r4/a7aJVne6KIKStu+5piLk/UFE=;
 b=lmIiQl+M75xUyqBRn33P1O4MphmfveDGagT3FgLJvU4pDfPdbq7rm7HqdjlwxSmO+F
 K8nXtQTpUpRT6K5jZEbjYW3CWdj3cgRvSbAyr3sJZZRqROSMnEyJNGRxarDsMnOUEkYz
 /Wg6gYtMSqp40fgPp8VaUebvlHjOPs7LFvxmgDi8csWug93M0i/4/Y+oiGXiVYXsm2q3
 OBjlrYLhlVOfQmfHIIh8fsPdVLxmWCDqCmbmWvrXsVlsgdSt2HwCPLTLMBWNhRJob9Lu
 XEaJQHMmQex108ApGcQj1EcyoHcGTpgsOHamSQWZP/nWvTjJcN1QIMEq1H0NPlzByqNu
 4xAg==
X-Gm-Message-State: AOJu0Yx9JQC1Iv0Km8dbJb+9f2z7xTIH6M7EXOXVFjyyQugdeKZ+zLCF
 gYSzqE3YMo/Q9pGsDUPwyBg=
X-Google-Smtp-Source: AGHT+IHhrQWINe0Nw86LDPwlscUfyfW1OD6G9VDFNMNMBZ0ii1AyThSaEXLGgEALmZFk3N16qWFqNw==
X-Received: by 2002:a17:90b:1e4e:b0:268:46fb:df32 with SMTP id
 pi14-20020a17090b1e4e00b0026846fbdf32mr13928115pjb.34.1693977055868; 
 Tue, 05 Sep 2023 22:10:55 -0700 (PDT)
Received: from [192.168.179.18] (KD106154145120.au-net.ne.jp.
 [106.154.145.120]) by smtp.gmail.com with ESMTPSA id
 em23-20020a17090b015700b002739282db53sm3393497pjb.32.2023.09.05.22.10.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Sep 2023 22:10:55 -0700 (PDT)
Message-ID: <e3f8b39f-742f-481b-b640-d6efb3437aa1@gmail.com>
Date: Wed, 6 Sep 2023 14:09:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/1] virtio-net: add support for SR-IOV emulation
Content-Language: en-US
From: Yui Washizu <yui.washidu@gmail.com>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, akihiko.odaki@daynix.com,
 yvugenfi@redhat.com, ybendito@redhat.com, mapfelba@redhat.com,
 marcel@redhat.com, ghammer@redhat.com, mdean@redhat.com
References: <1689731808-3009-1-git-send-email-yui.washidu@gmail.com>
 <CACGkMEv9yVCherC89W5ihyP-iZZHDhn1xZy-8aOd4ZSs+1Dk_Q@mail.gmail.com>
 <ef14eb09-e739-3a3a-ebda-13b385a85d8e@gmail.com>
 <CACGkMEtUUq6988VJoZuPhfdODMeyMsZUkm4Pq6u4NYzEZo3zeQ@mail.gmail.com>
 <e16a6dc9-fa72-4ff6-9dd4-fbd6e36eec82@gmail.com>
In-Reply-To: <e16a6dc9-fa72-4ff6-9dd4-fbd6e36eec82@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=yui.washidu@gmail.com; helo=mail-pj1-x1031.google.com
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


Hi Jason,


On 2023/08/30 14:28, Yui Washizu wrote:
>
> On 2023/07/24 15:58, Jason Wang wrote:
>> On Mon, Jul 24, 2023 at 10:32 AM Yui Washizu <yui.washidu@gmail.com> 
>> wrote:
>>>
>>> On 2023/07/20 11:20, Jason Wang wrote:
>>>> On Wed, Jul 19, 2023 at 9:59 AM Yui Washizu <yui.washidu@gmail.com> 
>>>> wrote:
>>>>> This patch series is the first step towards enabling
>>>>> hardware offloading of the L2 packet switching feature on 
>>>>> virtio-net device to host machine.
>>>>> We are considering that this hardware offloading enables
>>>>> the use of high-performance networks in virtual infrastructures,
>>>>> such as container infrastructures on VMs.
>>>>>
>>>>> To enable L2 packet switching by SR-IOV VFs, we are considering 
>>>>> the following:
>>>>> - making the guest recognize virtio-net devices as SR-IOV PF devices
>>>>>     (archived with this patch series)
>>>>> - allowing virtio-net devices to connect SR-IOV VFs to the backend 
>>>>> networks,
>>>>>     leaving the L2 packet switching feature to the management 
>>>>> layer like libvirt
>>>> Could you please show the qemu command line you want to propose here?
>>>
>>> I am considering how to specify the properties of VFs to connect SR-IOV
>>> VFs to the backend networks.
>>>
>>>
>>> For example:
>>>
>>>
>>> qemu-system-x86_64 -device
>>> pcie-root-port,port=8,chassis=8,id=pci.8,bus=pcie.0,multifunction=on
>>>                      -netdev tap,id=hostnet0,vhost=on
>>>                      -netdev tap,id=vfnet1,vhost=on # backend 
>>> network for
>>> SR-IOV VF 1
>>>                      -netdev tap,id=vfnet2,vhost=on # backend 
>>> network for
>>> SR-IOV VF 2
>>>                      -device
>>> virtio-net-pci,netdev=hostnet0,sriov_max_vfs=2,sriov_netdev=vfnet1:vfnet2,... 
>>>
>>>
>>>
>>> In this example, we can specify multiple backend networks to the VFs
>>> by adding "sriov_netdev" and separating them with ":".
>> This seems what is in my mind as well, more below
>>
>>> Additionally, when passing properties like "rx_queue_size" to VFs, we
>>> can utilize new properties,
>>> such as "sriov_rx_queue_size_per_vfs," to ensure that the same value is
>>> passed to all VFs.
>> Or we can introduce new device like:
>>
>> -netdev tap,id=hn0 \
>> -device virtio-net-pci,netdev=hn0,id=vnet_pf \
>> -netdev tap,netdev=hn1 \
>> -device 
>> virtio-net-pci-vf,netdev=hn1,id=vf0,pf=vnet_pf,rx_queue_size=XYZ ... \
>>
>> This allows us to reuse the codes for configuring vf parameters. But
>> note that rx_queue_size doesn't make too much sense to vhost-vDPA, as
>> qemu can perform nothing more than a simple sanity test.
>>
>> Thanks
>
>
> Thanks for proposing this new way.
>
> I have considered how to implement this.
>
>
> As virtio-net-pci-vf device should show up
>
> on the guest only when the guest OS creates a VF,
>
> the guest must not be able to see the VF device on PCI bus when qemu 
> starts.
>
> However, it's hard to realize this without overcomplicating
>
> relevant code due to current qemu implementation.
>
> It's because qdev_device_add_from_qdict,
>
> a function which is called when devices are specified
>
> with "-device" option of qemu startup command,
>
> always create devices by qdev_new and qdev_realize.
>
> It might be possible that we fix it
>
> so that qdev_new/qdev_realize aren't triggered for virtio-net-pci-vf 
> devices,
>
> but It seems that we need to special case the device in very generic code
>
> like qdev_device_add_from_qdict(), qdev_device_add(),
>
> device_init_func() or their caller function.
>
>
> Given my current ideas,
>
> it seems like this PATCH could become complex.
>
> Woule you have any suggestions
>
> for achieving this in more simple way possible ?
>
>

I was wondering if you could give me some feedback.
Best regard.


>
>>> I'm still considering about how to specify it, so please give me any
>>> comments if you have any.
>>>
>>>
>>>>>     - This makes hardware offloading of L2 packet switching possible.
>>>>>       For example, when using vDPA devices, it allows the guest
>>>>>       to utilize SR-IOV NIC embedded switch of hosts.
>>>> This would be interesting.
>>>>
>>>> Thanks
>>>>
>>>>> This patch series aims to enable SR-IOV emulation on virtio-net 
>>>>> devices.
>>>>> With this series, the guest can identify the virtio-net device as 
>>>>> an SR-IOV PF device.
>>>>> The newly added property 'sriov_max_vfs' allows us to enable the 
>>>>> SR-IOV feature
>>>>> on the virtio-net device.
>>>>> Currently, we are unable to specify the properties of a VF created 
>>>>> from the guest.
>>>>> The properties are set to their default values.
>>>>> In the future, we plan to allow users to set the properties.
>>>>>
>>>>> qemu-system-x86_64 --device virtio-net,sriov_max_vfs=<num>
>>>>> # when 'sriov_max_vfs' is present, the SR-IOV feature will be 
>>>>> automatically enabled
>>>>> # <num> means the max number of VF on guest
>>>>>
>>>>> Example commands to create VFs in virtio-net device from the guest:
>>>>>
>>>>> guest% readlink -f /sys/class/net/eth1/device
>>>>> /sys/devices/pci0000:00/0000:00:02.0/0000:01:00.0/virtio1
>>>>> guest% echo "2" > 
>>>>> /sys/devices/pci0000:00/0000:00:02.0/0000:01:00.0/sriov_numvfs
>>>>> guest% ip link show
>>>>>    eth0: ....
>>>>>    eth1: ....
>>>>>    eth2: .... #virtual VF created
>>>>>    eth3: .... #virtual VF created
>>>>>
>>>>> Please note that communication between VF and PF/VF is not 
>>>>> possible by this patch series itself.
>>>>>
>>>>> Yui Washizu (1):
>>>>>     virtio-pci: add SR-IOV capability
>>>>>
>>>>>    hw/pci/msix.c                  |  8 +++--
>>>>>    hw/pci/pci.c                   |  4 +++
>>>>>    hw/virtio/virtio-pci.c         | 62 
>>>>> ++++++++++++++++++++++++++++++----
>>>>>    include/hw/virtio/virtio-pci.h |  1 +
>>>>>    4 files changed, 66 insertions(+), 9 deletions(-)
>>>>>
>>>>> -- 
>>>>> 2.39.3
>>>>>

