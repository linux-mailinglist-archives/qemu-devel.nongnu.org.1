Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 334B17666E9
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 10:23:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPI0S-0006vm-6C; Fri, 28 Jul 2023 03:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yui.washidu@gmail.com>)
 id 1qPI0Q-0006ve-64
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 03:35:22 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yui.washidu@gmail.com>)
 id 1qPI0O-0007Qr-Dn
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 03:35:21 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-1bba254a7d4so1455417fac.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 00:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690529718; x=1691134518;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Nmg25CEg3DyYzz54q7smFELsJPKN9VtRn/ce0istu/I=;
 b=CJpYa7WwVT3ijDbnYK/Hwcevw+VTJrs7C9xqIvKaoUKVI3bESGge5eruc86OBtnOnM
 FxVfDNDwQZWBUvNnST4a8kRI0k3qDSe8BhjszY9FU06/mcNuzY5FXGgHPWtRTkX6TucD
 g/9Ix3R154FSkLlGLLrGnhJ7urIjZtuB/2Bw3/BpFwrWgEgyNXO4F8E6c837UY4OH/vi
 APWk0YgCgv8Fw0KqtDneS4p2B4+eXp8czvBweMz8hRMuLiayVNHBOMcpeycmr4ppv/LI
 lNCgeYXSEpQS2gDTJP4bcd1qt5HaqYxumQOmVOM4adDXSmMrgkYXsCdp8rSUNzuZ9UTV
 qqxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690529718; x=1691134518;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nmg25CEg3DyYzz54q7smFELsJPKN9VtRn/ce0istu/I=;
 b=GX/L23p2nQN+SZIKyzSWEZ6kDQtK38z9y6w5RKCo5thmKs3AVm6OyR+SMvfEHIahPx
 f+8IHDBJqYJk2kTfK98IXvfOW9kERiOvlVtM5NRHucx4JpXQy7epyiQj0ngk8ExoC9/2
 gxJqjE3SsyNnOYAJ//0maz2wU6e6T34dwFcD0nIn66/LvyYdZWvsitNdrDGRQOONxqkp
 y6vrwVELpq6IWK7KInAoubGZ4tP8loOFaIoGVGopv74t4cr5+F06xEGPTEDLV9fE3hH5
 Ky8hcXk4/aajjZWbrk0XkA2rpypuIi93/wiXEvTw/kL3CoA8wyF3mIeHyrEZR1kBObL5
 Xp+A==
X-Gm-Message-State: ABy/qLbyl8Vo0yn/NuaY/iPi5XxHbqhHYZDhTFOuBqbNVhTsvlaBiUOY
 r7xE6ukM90NH6Nc56PtpSvk=
X-Google-Smtp-Source: APBJJlFKVjPGatl5I47YyfeyGVbrcDkYQy9TEv623kSljBxCFoG3h0LQP+VGdAzm2EpZQHp5kkOJGw==
X-Received: by 2002:a05:6871:612:b0:1b4:6d3b:3e15 with SMTP id
 w18-20020a056871061200b001b46d3b3e15mr2390496oan.3.1690529718531; 
 Fri, 28 Jul 2023 00:35:18 -0700 (PDT)
Received: from [172.20.149.24] ([222.151.198.97])
 by smtp.gmail.com with ESMTPSA id
 k12-20020aa790cc000000b00682c1db7551sm448495pfk.49.2023.07.28.00.35.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jul 2023 00:35:18 -0700 (PDT)
Message-ID: <2d0c5e29-49d0-a1cc-eb96-d80550984ee2@gmail.com>
Date: Fri, 28 Jul 2023 16:35:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
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
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=yui.washidu@gmail.com; helo=mail-oa1-x29.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
> This allows us to reuse the codes for configuring vf parameters.


Yes, I was also considering this method was one of the option.


I was concerned that the implementation
for it might be different from other devices specified by the "-device" 
option
because VF devices are created when the guest creates VFs from PFs,
not when the guest starts,
and the implementation may be complicated.
So I dropped the idea then.


However, I think it is a cleaner way for specifying VFs than my 
suggested one.


I will further consider whether the implementation will be really 
difficult or not.


Thank you.


> But
> note that rx_queue_size doesn't make too much sense to vhost-vDPA, as
> qemu can perform nothing more than a simple sanity test.
>
> Thanks
>
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

