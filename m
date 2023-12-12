Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 762AE80E7D8
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 10:36:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCzAd-0003Ds-MN; Tue, 12 Dec 2023 04:35:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCzAS-0003DP-PI
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 04:35:08 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCzAQ-0004x0-PM
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 04:35:08 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1d331f12f45so4143555ad.2
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 01:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702373704; x=1702978504;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YGjrfKueBvfO89y/N/X0vU0EtsD7ulRdAHN0wedF248=;
 b=oGwOdiC4JY9sYQYE8O/cokel1bfr8T79nlT5eN6x5iI9gp2Sur+AzQNc0qyDrVBE3g
 kSLkKuI0Lb0/d/kKplbcfVSnuoDSV2Bw7VInzJBmv9yV74qU0ALJsCRo6NszjU3oZOyF
 K8umqfTjlSeOP1TLu/3fe18txmOTaKsmUJPmy8BATNWfMYd7yI5uOIXBt0dGVnVpYrZ7
 AVJDVTaRtUphpKeivbgFwZyUFbDODxSNX6rSsHZqCeG2GvZwW73RYOZ/AMQGVrnffWJU
 ZlDZNQ/M4nCkbClQuaMEMoQG+8Xu2wVdBbbbCX3EYgkK1UsDMf3sikVyrNXTtSDtyIfd
 zD9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702373704; x=1702978504;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YGjrfKueBvfO89y/N/X0vU0EtsD7ulRdAHN0wedF248=;
 b=GJSgf7u0Op0Dvrx/Qe/TdGq5UkZde/hfAySAvTqu7QvKKD5WzrgwXX8ITPev+1GUbd
 o3bLplJN4fB6kyKy5zBz6GH6aESotsDPDGEHi869HJ1K3H+Q2ZnroDKSCuJguUTzplRA
 eE2ozBsbQOU5c8MrVtvY5g6f5H8I7TVewKq3O90KNJV6C84Oow4vT9Hs/QyEHg7lrjTr
 uCWLySo3es5skC5qBG3wy8UQiJu2Epf1OfOu0Et9bIC/D2KRTZowJvbF9P1xZ6TeOPg8
 o4h0+5YDv7D/9wVIXh0EbnkinyL6zwdqg4bvq4nLoY+fkUKhQ8o0+rlBHP8zxUOQK8X8
 RzZA==
X-Gm-Message-State: AOJu0Yxq+HYqplhImK9IBfoGGN/GiH6k9TMiwBheQQ7iaD4YbU9fwyWz
 qAKBqlrMr2h4bqUUxDkwM2zeZw==
X-Google-Smtp-Source: AGHT+IF+JgUhGcDVCmKPEbJ/VdzIEZUZ4jLIHBzg4+7SYA0S0pp3i/rdYqw94a++GLAySgqm7mWTLQ==
X-Received: by 2002:a17:902:da82:b0:1d0:d04a:7bfa with SMTP id
 j2-20020a170902da8200b001d0d04a7bfamr3127853plx.90.1702373704215; 
 Tue, 12 Dec 2023 01:35:04 -0800 (PST)
Received: from [157.82.205.15] ([157.82.205.15])
 by smtp.gmail.com with ESMTPSA id
 y7-20020a17090322c700b001cfb14a09a4sm8128986plg.126.2023.12.12.01.35.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Dec 2023 01:35:03 -0800 (PST)
Message-ID: <491ae4c6-fdb2-4daa-a6d0-004ce9401058@daynix.com>
Date: Tue, 12 Dec 2023 18:34:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 00/12] virtio-net: add support for SR-IOV emulation
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Yui Washizu <yui.washidu@gmail.com>
References: <20231210-sriov-v2-0-b959e8a6dfaf@daynix.com>
 <CACGkMEuYa7CUUp6F4D91P0mg=2GadhRESCx2j63P7Fkm42q++w@mail.gmail.com>
 <dc5bb0f8-3554-40f2-b683-3b5e58377ed3@daynix.com>
 <CACGkMEtrELfC4iqHv5e9oDD0OzwwiuyEDJWq-O5ocH02YMx9Wg@mail.gmail.com>
 <0a63d0d9-23f7-4303-81e7-00d85fea371b@daynix.com>
 <CACGkMEsUDQU3viO1dRS3DJzBPNHrM6ehyc+tdNbqbDG0R4us5A@mail.gmail.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEsUDQU3viO1dRS3DJzBPNHrM6ehyc+tdNbqbDG0R4us5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::635;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
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

On 2023/12/12 13:12, Jason Wang wrote:
> On Mon, Dec 11, 2023 at 4:29 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2023/12/11 16:26, Jason Wang wrote:
>>> On Mon, Dec 11, 2023 at 1:30 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> On 2023/12/11 11:52, Jason Wang wrote:
>>>>> On Sun, Dec 10, 2023 at 12:06 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>
>>>>>> Introduction
>>>>>> ------------
>>>>>>
>>>>>> This series is based on the RFC series submitted by Yui Washizu[1].
>>>>>> See also [2] for the context.
>>>>>>
>>>>>> This series enables SR-IOV emulation for virtio-net. It is useful
>>>>>> to test SR-IOV support on the guest, or to expose several vDPA devices
>>>>>> in a VM. vDPA devices can also provide L2 switching feature for
>>>>>> offloading though it is out of scope to allow the guest to configure
>>>>>> such a feature.
>>>>>>
>>>>>> The PF side code resides in virtio-pci. The VF side code resides in
>>>>>> the PCI common infrastructure, but it is restricted to work only for
>>>>>> virtio-net-pci because of lack of validation.
>>>>>>
>>>>>> User Interface
>>>>>> --------------
>>>>>>
>>>>>> A user can configure a SR-IOV capable virtio-net device by adding
>>>>>> virtio-net-pci functions to a bus. Below is a command line example:
>>>>>>      -netdev user,id=n -netdev user,id=o
>>>>>>      -netdev user,id=p -netdev user,id=q
>>>>>>      -device pcie-root-port,id=b
>>>>>>      -device virtio-net-pci,bus=b,addr=0x0.0x3,netdev=q,sriov-pf=f
>>>>>>      -device virtio-net-pci,bus=b,addr=0x0.0x2,netdev=p,sriov-pf=f
>>>>>>      -device virtio-net-pci,bus=b,addr=0x0.0x1,netdev=o,sriov-pf=f
>>>>>>      -device virtio-net-pci,bus=b,addr=0x0.0x0,netdev=n,id=f
>>>>>>
>>>>>> The VFs specify the paired PF with "sriov-pf" property. The PF must be
>>>>>> added after all VFs. It is user's responsibility to ensure that VFs have
>>>>>> function numbers larger than one of the PF, and the function numbers
>>>>>> have a consistent stride.
>>>>>
>>>>> This seems not user friendly. Any reason we can't just allow user to
>>>>> specify the stride here?
>>>>
>>>> It should be possible to assign addr automatically without requiring
>>>> user to specify the stride. I'll try that in the next version.
>>>>
>>>>>
>>>>> Btw, I vaguely remember qemu allows the params to be accepted as a
>>>>> list. If this is true, we can accept a list of netdev here?
>>>>
>>>> Yes, rocker does that. But the problem is not just about getting
>>>> parameters needed for VFs, which I forgot to mention in the cover letter
>>>> and will explain below.
>>>>
>>>>>
>>>>>>
>>>>>> Keeping VF instances
>>>>>> --------------------
>>>>>>
>>>>>> A problem with SR-IOV emulation is that it needs to hotplug the VFs as
>>>>>> the guest requests. Previously, this behavior was implemented by
>>>>>> realizing and unrealizing VFs at runtime. However, this strategy does
>>>>>> not work well for the proposed virtio-net emulation; in this proposal,
>>>>>> device options passed in the command line must be maintained as VFs
>>>>>> are hotplugged, but they are consumed when the machine starts and not
>>>>>> available after that, which makes realizing VFs at runtime impossible.
>>>>>
>>>>> Could we store the device options in the PF?
>>>>
>>>> I wrote it's to store the device options, but the problem is actually
>>>> more about realizing VFs at runtime instead of at the initialization time.
>>>>
>>>> Realizing VFs at runtime have two major problems. One is that it delays
>>>> the validations of options; invalid options will be noticed when the
>>>> guest requests to realize VFs.
>>>
>>> If PCI spec allows the failure when creating VF, then it should not be
>>> a problem.
>>
>> I doubt the spec cares such a failure at all. VF enablement should
>> always work for a real hardware. It's neither user-friendly to tell
>> configuration errors at runtime.
> 
> I'm not sure which options we should care about? Did you mean netdev
> options or the virtio-net specific ones?
> 
> If VF stick to the same options as PF (except for the SRIOV), it
> should be validated during the PF initialization.

I'm aware that it's necessary to validate netdev options and PCI 
function numbers (a.k.a. addr/devfn). I'm not sure if the other options 
may result in an invalid VF configuration.

That said, I think it's better to let the VF realization code validate 
the configuration at PF realization - it's less error-prone and 
potentially requires less code. It also benefits existing SR-IOV devices 
(igb and nvme) so I'm going to push that change forward whether it will 
be needed for virtio-net SR-IOV emulation.

Assuming the change to realize VFs early is going to happen for igb and 
nvme, most of the changes *only* needed by virtio-net SR-IOV emulation 
is done by:
patch 10 "pcie_sriov: Allow user to create SR-IOV device".

> 
>>
>>>
>>>> netdevs also warn that they are not used
>>>> at initialization time, not knowing that they will be used by VFs later.
>>>
>>> We could invent things to calm down this false positive.
>>>
>>>> References to other QEMU objects in the option may also die before VFs
>>>> are realized.
>>>
>>> Is there any other thing than netdev we need to consider?
>>
>> You will also want to set a distinct mac for each VF. Other properties
>> does not matter much in my opinion.
> 
> Qemu doesn't check mac duplication now. So it's up to the mgmt layer.

Right. mac is not important; it's just nice to have.

Regards,
Akihiko Odaki

