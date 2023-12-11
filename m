Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4D580C345
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 09:31:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCbff-0003q6-Ed; Mon, 11 Dec 2023 03:29:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCbfd-0003pp-KS
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 03:29:45 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCbfb-0003SJ-Ns
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 03:29:45 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6ceb93fb381so2799073b3a.0
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 00:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702283382; x=1702888182;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZM2woCU5Tf8BVOG7uyTgtypDScEVAEv8Xj9MvdxCWb4=;
 b=ecGdhfxvCvkhYKVceeTWhmGmyled86XsuooHSja50JOgRT5ogCpW3U0OVZ1LOIhlGw
 cxFFt+RkdNuiHYKCZAwD2QjAYR6tlMDIlsr2WrspPNITHSMeamqb8miRS2DFiScQ95Rj
 64eJuBWvMix/iFusCXfsnEdjq/hY5hqfW8WvOq3ne17Kjie7Gq8BG5AyBChm+j5LFaPe
 1QIxbpHzgM3fS4Y9S9vAbEeAzVHi9qut7qs1tbcyhKm18P6ddIT3wu5UVkNueUR04zfw
 eYOZgjEQmlWjQ9jFGdJosFDZ1rPjNDZbOdhF12h/R3NNhe0AK3pBymQtaGgh1i1B3vn1
 XeUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702283382; x=1702888182;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZM2woCU5Tf8BVOG7uyTgtypDScEVAEv8Xj9MvdxCWb4=;
 b=C4SGsIH5YA05oWxvQhIr6rw2sdWLL4PO+AkiDUQdGGHHTwOSNS0YPBRwz0GuY9oSas
 FzoBpB0o2i9hk9rrS6IcIxIF6y3PxPmhkWCF1EMSh1FPq1dfZOi4O2VVYx38oD9fGjJb
 q2JYJGTIHkfkPHWwStJT3oKwpXFC8+8orTQKg6iadO3B03YjVdSaJkk4xGgLSPQL0aso
 6OJWT3hvfm11PwhtfcPrY+a0tG2sFfFzQNKyQAM/trCa4qE2V1f7TX+Olj3JKW5O12Zd
 G//yJv47YwAhyVJ91YaMpk2Q26mBudMHMfglvg+2HA/mIX5N8xjWDquaCBnzhYZMVVUe
 tvDw==
X-Gm-Message-State: AOJu0Yz7in24jNNJEh5MGvsiw4FbCZQHQcjKDjQQI76XsGRuZrnEq3op
 duqkhDABlFOtYmIzbZrjtaFB1g==
X-Google-Smtp-Source: AGHT+IGy6Y2wHNOQFZsEo6nuYFTELJ1OcnWXY0tvhOaQIaqjPQ3l1WyloIDuKEouGJAKYkonwQntMQ==
X-Received: by 2002:a05:6a00:cc1:b0:6ce:49a7:1695 with SMTP id
 b1-20020a056a000cc100b006ce49a71695mr4893309pfv.32.1702283381942; 
 Mon, 11 Dec 2023 00:29:41 -0800 (PST)
Received: from [157.82.205.15] ([157.82.205.15])
 by smtp.gmail.com with ESMTPSA id
 k13-20020aa792cd000000b006ce273562fasm5712652pfa.40.2023.12.11.00.29.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 00:29:41 -0800 (PST)
Message-ID: <0a63d0d9-23f7-4303-81e7-00d85fea371b@daynix.com>
Date: Mon, 11 Dec 2023 17:29:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 00/12] virtio-net: add support for SR-IOV emulation
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
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEtrELfC4iqHv5e9oDD0OzwwiuyEDJWq-O5ocH02YMx9Wg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::434;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x434.google.com
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

On 2023/12/11 16:26, Jason Wang wrote:
> On Mon, Dec 11, 2023 at 1:30 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2023/12/11 11:52, Jason Wang wrote:
>>> On Sun, Dec 10, 2023 at 12:06 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> Introduction
>>>> ------------
>>>>
>>>> This series is based on the RFC series submitted by Yui Washizu[1].
>>>> See also [2] for the context.
>>>>
>>>> This series enables SR-IOV emulation for virtio-net. It is useful
>>>> to test SR-IOV support on the guest, or to expose several vDPA devices
>>>> in a VM. vDPA devices can also provide L2 switching feature for
>>>> offloading though it is out of scope to allow the guest to configure
>>>> such a feature.
>>>>
>>>> The PF side code resides in virtio-pci. The VF side code resides in
>>>> the PCI common infrastructure, but it is restricted to work only for
>>>> virtio-net-pci because of lack of validation.
>>>>
>>>> User Interface
>>>> --------------
>>>>
>>>> A user can configure a SR-IOV capable virtio-net device by adding
>>>> virtio-net-pci functions to a bus. Below is a command line example:
>>>>     -netdev user,id=n -netdev user,id=o
>>>>     -netdev user,id=p -netdev user,id=q
>>>>     -device pcie-root-port,id=b
>>>>     -device virtio-net-pci,bus=b,addr=0x0.0x3,netdev=q,sriov-pf=f
>>>>     -device virtio-net-pci,bus=b,addr=0x0.0x2,netdev=p,sriov-pf=f
>>>>     -device virtio-net-pci,bus=b,addr=0x0.0x1,netdev=o,sriov-pf=f
>>>>     -device virtio-net-pci,bus=b,addr=0x0.0x0,netdev=n,id=f
>>>>
>>>> The VFs specify the paired PF with "sriov-pf" property. The PF must be
>>>> added after all VFs. It is user's responsibility to ensure that VFs have
>>>> function numbers larger than one of the PF, and the function numbers
>>>> have a consistent stride.
>>>
>>> This seems not user friendly. Any reason we can't just allow user to
>>> specify the stride here?
>>
>> It should be possible to assign addr automatically without requiring
>> user to specify the stride. I'll try that in the next version.
>>
>>>
>>> Btw, I vaguely remember qemu allows the params to be accepted as a
>>> list. If this is true, we can accept a list of netdev here?
>>
>> Yes, rocker does that. But the problem is not just about getting
>> parameters needed for VFs, which I forgot to mention in the cover letter
>> and will explain below.
>>
>>>
>>>>
>>>> Keeping VF instances
>>>> --------------------
>>>>
>>>> A problem with SR-IOV emulation is that it needs to hotplug the VFs as
>>>> the guest requests. Previously, this behavior was implemented by
>>>> realizing and unrealizing VFs at runtime. However, this strategy does
>>>> not work well for the proposed virtio-net emulation; in this proposal,
>>>> device options passed in the command line must be maintained as VFs
>>>> are hotplugged, but they are consumed when the machine starts and not
>>>> available after that, which makes realizing VFs at runtime impossible.
>>>
>>> Could we store the device options in the PF?
>>
>> I wrote it's to store the device options, but the problem is actually
>> more about realizing VFs at runtime instead of at the initialization time.
>>
>> Realizing VFs at runtime have two major problems. One is that it delays
>> the validations of options; invalid options will be noticed when the
>> guest requests to realize VFs.
> 
> If PCI spec allows the failure when creating VF, then it should not be
> a problem.

I doubt the spec cares such a failure at all. VF enablement should 
always work for a real hardware. It's neither user-friendly to tell 
configuration errors at runtime.

> 
>> netdevs also warn that they are not used
>> at initialization time, not knowing that they will be used by VFs later.
> 
> We could invent things to calm down this false positive.
> 
>> References to other QEMU objects in the option may also die before VFs
>> are realized.
> 
> Is there any other thing than netdev we need to consider?

You will also want to set a distinct mac for each VF. Other properties 
does not matter much in my opinion.

> 
>>
>> The other problem is that QEMU cannot interact with the unrealized VFs.
>> For example, if you type "device_add virtio-net-pci,id=vf,sriov-pf=pf"
>> in HMP, you will expect "device_del vf" works, but it's hard to
>> implement such behaviors with unrealized VFs.
> 
> I think hotplug can only be done at PF level if we do that.

Assuming you mean to let netdev and mac accept arrays, yes.

> 
>>
>> I was first going to compromise and allow such quirky behaviors, but I
>> realized such a compromise is unnecessary if we reuse the PCI power down
>> logic so I wrote v2.
> 
> Haven't checked the code, but anything related to the PM here?

You mean power management? We don't have to care about PCI power down 
for VFs because powering down a SR-IOV PCI device will reset it and thus 
disable its VFs.

Regards,
Akihiko Odaki

