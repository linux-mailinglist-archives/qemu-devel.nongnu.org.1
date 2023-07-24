Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED8B75E9C6
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 04:33:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNlNZ-0006ZM-TC; Sun, 23 Jul 2023 22:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yui.washidu@gmail.com>)
 id 1qNlNY-0006ZE-J1
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 22:32:56 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yui.washidu@gmail.com>)
 id 1qNlNW-0003qP-VB
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 22:32:56 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-666ed230c81so3727704b3a.0
 for <qemu-devel@nongnu.org>; Sun, 23 Jul 2023 19:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690165973; x=1690770773;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XuwIUolCh0CMNBMvX/qVs5aUsP7oO3CZljt1sh2fMTY=;
 b=QBYU7b44Hufd3ENGZKAErO2FNFttcel3Rmno/iemZzyVbKzx72Qdn8sEBR6N0owKM4
 5MLmAEP5hfhf+Ca5bwMk2c0kS8M30rWxtBk8hSoiHtaO4VVlAzs+zki+XKQOPZmBZPzo
 b6R2fWkoKhMbuQnac+Sthac/zKSD2brRED9yTn1DSzmqCWZTtRpg9ezoFe1dXcOA3Pxj
 bzT+f76oau5F07j52e5ShCnj1t8nZtjHEPOJajQa3tCsMXnOcQlD5y1PY63vn5v/NV7l
 G5aN96nyX5ywi1oVd7swtcMSaNzaYwspdYzf1Lz+6FH+aef5nz7BBaxnG6veYJBQu/7j
 DbSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690165973; x=1690770773;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XuwIUolCh0CMNBMvX/qVs5aUsP7oO3CZljt1sh2fMTY=;
 b=cqEseptr4IiVYCS2Qqk9ioWkLTXQoHsGknvyYUaemys/fUVBJWu+za/gM6TRBs6oyD
 JVxz/qIn4P58zWBLaUJ+coZZt/vnWDrx9FsmnD0xTdVc5hnZqMtu82vpKRKjP9xcZSu3
 qYDZFPaKYxDTb5r/GItjMQhRGrXKOti8HIkfW2fNcWYx0sZdroPhiGNt96m5rC8LDKju
 e57WUe6eBvlszIs1K1POCy7bEYiSgndad/eApwZ2adfX2PDIlyLC26kqD9d1b0EoiFpJ
 ZFeleJHBfPtxREN3x/g2yOMwmRf9PPnY3YTUZNnVOv3sWzV8k4OXNA4PjKT8LUtOzOt0
 K+zA==
X-Gm-Message-State: ABy/qLYIJS0cGPCQjounmg9/fNi0JBlapjVS0h1btYZpU9Mktpi4YlwB
 nQ7G8b67uEY4Mhulz9ju/tk=
X-Google-Smtp-Source: APBJJlF2VPNQG+++ofMCjd825V5A23cTTRMTen2+flMC3XYefxXk4MXbL6KHUHqAQNx93yQnQlaaCA==
X-Received: by 2002:a05:6a00:2e19:b0:67e:45ab:b86b with SMTP id
 fc25-20020a056a002e1900b0067e45abb86bmr9166107pfb.28.1690165972578; 
 Sun, 23 Jul 2023 19:32:52 -0700 (PDT)
Received: from [172.20.149.24] ([222.151.198.97])
 by smtp.gmail.com with ESMTPSA id
 j20-20020aa78d14000000b006866a293e58sm4297747pfe.176.2023.07.23.19.32.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jul 2023 19:32:52 -0700 (PDT)
Message-ID: <ef14eb09-e739-3a3a-ebda-13b385a85d8e@gmail.com>
Date: Mon, 24 Jul 2023 11:32:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC 0/1] virtio-net: add support for SR-IOV emulation
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, akihiko.odaki@daynix.com,
 yvugenfi@redhat.com, ybendito@redhat.com, mapfelba@redhat.com,
 marcel@redhat.com, ghammer@redhat.com, mdean@redhat.com
References: <1689731808-3009-1-git-send-email-yui.washidu@gmail.com>
 <CACGkMEv9yVCherC89W5ihyP-iZZHDhn1xZy-8aOd4ZSs+1Dk_Q@mail.gmail.com>
Content-Language: en-US
From: Yui Washizu <yui.washidu@gmail.com>
In-Reply-To: <CACGkMEv9yVCherC89W5ihyP-iZZHDhn1xZy-8aOd4ZSs+1Dk_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=yui.washidu@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.093, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


On 2023/07/20 11:20, Jason Wang wrote:
> On Wed, Jul 19, 2023 at 9:59 AM Yui Washizu <yui.washidu@gmail.com> wrote:
>> This patch series is the first step towards enabling
>> hardware offloading of the L2 packet switching feature on virtio-net device to host machine.
>> We are considering that this hardware offloading enables
>> the use of high-performance networks in virtual infrastructures,
>> such as container infrastructures on VMs.
>>
>> To enable L2 packet switching by SR-IOV VFs, we are considering the following:
>> - making the guest recognize virtio-net devices as SR-IOV PF devices
>>    (archived with this patch series)
>> - allowing virtio-net devices to connect SR-IOV VFs to the backend networks,
>>    leaving the L2 packet switching feature to the management layer like libvirt
> Could you please show the qemu command line you want to propose here?


I am considering how to specify the properties of VFs to connect SR-IOV 
VFs to the backend networks.


For example:


qemu-system-x86_64 -device 
pcie-root-port,port=8,chassis=8,id=pci.8,bus=pcie.0,multifunction=on
                    -netdev tap,id=hostnet0,vhost=on
                    -netdev tap,id=vfnet1,vhost=on # backend network for 
SR-IOV VF 1
                    -netdev tap,id=vfnet2,vhost=on # backend network for 
SR-IOV VF 2
                    -device 
virtio-net-pci,netdev=hostnet0,sriov_max_vfs=2,sriov_netdev=vfnet1:vfnet2,...


In this example, we can specify multiple backend networks to the VFs
by adding "sriov_netdev" and separating them with ":".
Additionally, when passing properties like "rx_queue_size" to VFs, we 
can utilize new properties,
such as "sriov_rx_queue_size_per_vfs," to ensure that the same value is 
passed to all VFs.

I'm still considering about how to specify it, so please give me any 
comments if you have any.


>>    - This makes hardware offloading of L2 packet switching possible.
>>      For example, when using vDPA devices, it allows the guest
>>      to utilize SR-IOV NIC embedded switch of hosts.
> This would be interesting.
>
> Thanks
>
>> This patch series aims to enable SR-IOV emulation on virtio-net devices.
>> With this series, the guest can identify the virtio-net device as an SR-IOV PF device.
>> The newly added property 'sriov_max_vfs' allows us to enable the SR-IOV feature
>> on the virtio-net device.
>> Currently, we are unable to specify the properties of a VF created from the guest.
>> The properties are set to their default values.
>> In the future, we plan to allow users to set the properties.
>>
>> qemu-system-x86_64 --device virtio-net,sriov_max_vfs=<num>
>> # when 'sriov_max_vfs' is present, the SR-IOV feature will be automatically enabled
>> # <num> means the max number of VF on guest
>>
>> Example commands to create VFs in virtio-net device from the guest:
>>
>> guest% readlink -f /sys/class/net/eth1/device
>>   /sys/devices/pci0000:00/0000:00:02.0/0000:01:00.0/virtio1
>> guest% echo "2" > /sys/devices/pci0000:00/0000:00:02.0/0000:01:00.0/sriov_numvfs
>> guest% ip link show
>>   eth0: ....
>>   eth1: ....
>>   eth2: .... #virtual VF created
>>   eth3: .... #virtual VF created
>>
>> Please note that communication between VF and PF/VF is not possible by this patch series itself.
>>
>> Yui Washizu (1):
>>    virtio-pci: add SR-IOV capability
>>
>>   hw/pci/msix.c                  |  8 +++--
>>   hw/pci/pci.c                   |  4 +++
>>   hw/virtio/virtio-pci.c         | 62 ++++++++++++++++++++++++++++++----
>>   include/hw/virtio/virtio-pci.h |  1 +
>>   4 files changed, 66 insertions(+), 9 deletions(-)
>>
>> --
>> 2.39.3
>>

