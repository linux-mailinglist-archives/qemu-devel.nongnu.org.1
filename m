Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E097FB5EC
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 10:34:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7uTs-0005Ze-TG; Tue, 28 Nov 2023 04:34:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r7uTr-0005ZN-84
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 04:34:11 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r7uTp-0001IW-5s
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 04:34:11 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5c2ad6a5515so2065428a12.2
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 01:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1701164047; x=1701768847;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8fOu+ykw0NpEaev8EdJ36MTlj0sPwIADHYwGj89OliE=;
 b=eK+g774GYJAU7l/axNU559x4giJ7CSsYYDS0QcCyk/fTt7IvMbaVBlgFT2/FzLinJ5
 22sfr4ClK2ajS2Nfy+K1oq1YHPtgVIeHh21KnoEVmC3na0AKMST1k+uc++jVcCoTDwtq
 GaMSPq+IMB4qQsFpZa/ni+RA6HNqOSjkkmofDoeyczeziiUf4vLrl94ZIKYGH6pseuy6
 v0zJtB4ZXmvJgZcV6LrnztiB7UeO1rNqr+tjl+X5NohmYn8L8UjQzt76pX7gzsbJXbn0
 t4bM/+xtlhS9UvEmGPAVGSSJifMFgf2Tk6C8oVFP/2g3MMKK1R3Gd4eZfTTofCshP51U
 Po2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701164047; x=1701768847;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8fOu+ykw0NpEaev8EdJ36MTlj0sPwIADHYwGj89OliE=;
 b=hfJtge7LTnPIvU6LPcepkjtzMIzoizFkESD9q5RGfl7KvExB76jLWd1Ii19/2YPWDb
 yMDCTWv3ojfdOn/y17TXkOGGWN2MWx0ip3lW1mLtQYW4y87KIWo/X4cfBcsfDS0wOXQM
 PLEUui6SqrSUo4Ut0VfR824/YTpD22fu5UdRMMK0qjVsoY4HIa3cxyQwHi5virtaSJaQ
 4YYgLHTLbXZLo6yyEJTigEE1Hlbn6MeRphwt5jCYxaqncNv5Co5SoXrijKti52uqhorE
 9rCLJshH0fBbEoZbr6AKfrUuBqumvRV79Ohht23+9yZ4jiIXr9CHVCuV2fojWHgyC0jM
 aeig==
X-Gm-Message-State: AOJu0Yw8SPar56Jlo51dc5GvFmEDYEvGOCy7EBcDFAv8d/MiUMIEmyZ4
 XR6GIyeM7FXY6RYw+BIinTQubXEAL4q5dArH0wA=
X-Google-Smtp-Source: AGHT+IFxfiAO5UM8R+dFhJ9bfeZWyHNzetvde6x6fnap8PEfK76qVQHxq0W9LGFUW9AZt6GjpxsDJw==
X-Received: by 2002:a05:6a20:a114:b0:18b:4c44:d09 with SMTP id
 q20-20020a056a20a11400b0018b4c440d09mr16283131pzk.0.1701164047147; 
 Tue, 28 Nov 2023 01:34:07 -0800 (PST)
Received: from [157.82.205.15] ([157.82.205.15])
 by smtp.gmail.com with ESMTPSA id
 iw9-20020a170903044900b001cf7f0ab8e5sm9826181plb.21.2023.11.28.01.34.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Nov 2023 01:34:06 -0800 (PST)
Message-ID: <939d6a7f-0cb9-473d-9438-421c3cd4c48e@daynix.com>
Date: Tue, 28 Nov 2023 18:34:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Flexible SR-IOV support for virtio-net
Content-Language: en-US
To: Yui Washizu <yui.washidu@gmail.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <5d46f455-f530-4e5e-9ae7-13a2297d4bc5@daynix.com>
 <63ba118d-b203-4ec2-a4b5-a8ebacce5c1d@gmail.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <63ba118d-b203-4ec2-a4b5-a8ebacce5c1d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::529;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2023/11/28 17:47, Yui Washizu wrote:
> 
> On 2023/11/18 21:10, Akihiko Odaki wrote:
>> Hi,
>>
>> We are planning to add PCIe SR-IOV support to the virtio-net driver 
>> for Windows ("NetKVM")[1], and we want a SR-IOV feature for virtio-net 
>> emulation code in QEMU to test it. I expect there are other people 
>> interested in such a feature, considering that people are using igb[2] 
>> to test SR-IOV support in VMs.
>>
>> Washizu Yui have already proposed an RFC patch to add a SR-IOV feature 
>> to virtio-net emulation[3][4] but it's preliminary and has no 
>> configurability for VFs.
>>
>> Now I'm proposing to add SR-IOV support to virtio-net with full 
>> configurability for VFs by following the implementation of virtio-net 
>> failover[5]. I'm planning to write patches myself, but I know there 
>> are people interested in such patches so I'd like to let you know the 
>> idea beforehand.
>>
>> The idea:
>>
>> The problem when implementing configurability for VFs is that SR-IOV 
>> VFs can be realized and unrealized at runtime with a request from the 
>> guest. So a naive implementation cannot deal with a command line like 
>> the following:
>> -device virtio-net-pci,addr=0x0.0x0,sriov=on
>> -device virtio-net-pci,addr=0x0.0x1
>> -device virtio-net-pci,addr=0x0.0x2
>>
>> This will realize the virtio-net functions in 0x0.0x1 and 0x0.0x2 when 
>> the guest starts instead of when the guest requests to enable VFs.
>>
>> However, reviewing the virtio-net emulation code, I realized the 
>> virtio-net failover also "hides" devices when the guest starts. The 
>> following command line hides hostdev0 when the guest starts, and adds 
>> it when the guest requests VIRTIO_NET_F_STANDBY feature:
>>
>> -device virtio-net-pci,netdev=hostnet1,id=net1,mac=52:54:00:6f:55:cc, \
>>   bus=root2,failover=on
>> -device vfiopci,host=5e:00.2,id=hostdev0,bus=root1,failover_pair_id=net1
>>
>> So it should be also possible to do similar to "hide" VFs and 
>> realize/unrealize them when the guest requests.
>>
>> There are two things I hate with this idea when contrasting it with 
>> the conventional multifunction feature[6] though. One is that the PF 
>> must be added before VFs; a similar limitation is imposed for failover.
>>
>> Another is that it will be specific to virtio-net. I was considering 
>> to implement a "generic" SR-IOV feature that will work on various 
>> devices, but I realized that will need lots of configuration 
>> validations. We may eventually want it, but probably it's better to 
>> avoid such a big leap as the first step.
>>
>> Please tell me if you have questions or suggestions.
>>
> 
> 
> Hi, Odaki-san

Hi,

> 
> The idea appears to be practical and convenient.
> 
> I have some things I want to confirm.
> I understood your idea can make deices for VFs,
> created by qdev_new or qdev_realize function, invisible from guest OS.
> Is my understanding correct ?

Yes, the guest will request to enable VFs with the standard SR-IOV 
capability, and the virtio-net implementation will use appropriate 
QEMU-internal APIs to create and realize VFs accordingly.

> And, if your idea is realized,
> will it be possible to specify the backend device for the virtio-pci-net 
> device ?

Yes, you can specify netdev like conventional virtio-net devices.

> 
> Could you provide insights into the next steps
> beyond the implementation details ?
> About when do you expect your implementation
> to be merged into qemu ?
> Do you have a timeline for this plan ?
> Moreover, is there any way
> we can collaborate on the implementation you're planning ?

I intend to upstream my implementation. The flexibility of this design 
will make the SR-IOV support useful for many people and make it suitable 
for upstreaming. I also expect the implementation will be clean enough 
for upstreaming. I'll submit it to the mailing list when I finish the 
implementation so I'd like you to test and review it.

By the way, I started the implementation and realized it may be better 
to change the design so I present the design changes below:

First I intend to change the CLI. The interface in my last proposal 
expects there is only one PF in a bus and it is marked with "sriov" 
property. However, the specification allows to have multiple PFs in a 
bus so it's better to design the CLI so that it allows to have multiple 
PFs though I'm not going to implement such a feature at first.

The new CLI will instead add "sriov-pf" property to VFs, which 
designates the PF paired with them. The below is an example of a command 
line conforming to the new interface:

-device virtio-net-pci,addr=0x0.0x3,netdev=tap3,sriov-pf=pf1
-device virtio-net-pci,addr=0x0.0x2,netdev=tap2,id=pf1
-device virtio-net-pci,addr=0x0.0x1,netdev=tap1,sriov-pf=pf0
-device virtio-net-pci,addr=0x0.0x0,netdev=tap0,id=pf0

Another design change is *not* to use the "device hiding" API of 
failover. It is because fully-realized devices are useful when 
validating the configuration. In particular, VFs must have a consistent 
BAR configuration, and that can be validated only after they are realized.

So I'm now considering to have "prototype VFs" realized before the PF 
gets realized. Prototype VFs will be fully realized, but 
virtio_write_config() and virtio_read_config() will do nothing for those 
VFs, which effectively disables them. It is similar how functions are 
disabled until function 0 gets plugged for a conventional multifunction 
device (c.f., pci_host_config_write_common() and 
pci_host_config_read_common()).

When the PF gets realized, the PF will validate the configuration by 
inspecting the prototype VFs. If the configuration looks valid, the PF 
backs up DeviceState::opts and unplugs them. The PF will later use the 
backed up device options to realize VFs when the guest requests.

This design change forces to create VFs before the PF in the command 
line. It is similar that the conventional multifunction requires 
function 0 to be realized after the other functions.

I may make other design changes as the implementation progresses, but 
the above is the current design I have in mind.

Regards,
Akihiko Odaki

